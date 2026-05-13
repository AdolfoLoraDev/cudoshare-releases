#!/usr/bin/env bash

set -euo pipefail

# ============================================================================
# CudoShare Installer for macOS
# ============================================================================
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/CudoShare/cudoshare-releases/main/install-mac.sh | bash
#   bash install-mac.sh
# ============================================================================

readonly APP_NAME="CudoShare"
readonly REPO="CudoShare/cudoshare-releases"
readonly DOWNLOAD_URL="https://github.com/${REPO}/releases/latest/download/CudoShare-macos.dmg"
readonly INSTALL_DIR="/Applications"
readonly TEMP_DIR="$(mktemp -d)"
readonly DMG_PATH="${TEMP_DIR}/CudoShare-macos.dmg"
readonly MOUNT_POINT="${TEMP_DIR}/mount"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

cleanup() {
    if [[ -d "${MOUNT_POINT}" ]]; then
        hdiutil detach "${MOUNT_POINT}" -quiet 2>/dev/null || true
    fi
    if [[ -d "${TEMP_DIR}" ]]; then
        rm -rf "${TEMP_DIR}"
    fi
}

trap cleanup EXIT

# ---------------------------------------------------------------------------
# Preflight checks
# ---------------------------------------------------------------------------

echo ""
echo "=========================================="
echo "     CudoShare Installer for macOS"
echo "=========================================="
echo ""

log_info "Checking system requirements..."

# macOS version check (14.0+)
OS_MAJOR=$(sw_vers -productVersion | cut -d. -f1)
OS_MINOR=$(sw_vers -productVersion | cut -d. -f2)
if [[ "${OS_MAJOR}" -lt 14 ]]; then
    log_error "CudoShare requires macOS 14.0 (Sonoma) or later."
    log_error "Your version: $(sw_vers -productVersion)"
    exit 1
fi

# Architecture check
ARCH=$(uname -m)
if [[ "${ARCH}" != "arm64" && "${ARCH}" != "x86_64" ]]; then
    log_error "Unsupported architecture: ${ARCH}"
    log_error "CudoShare supports Apple Silicon (M1/M2/M3/M4) and Intel 64-bit Macs."
    exit 1
fi

log_success "macOS $(sw_vers -productVersion) on ${ARCH} — supported."

# Check if CudoShare is already running
if pgrep -xq "CudoShare"; then
    log_warn "CudoShare is currently running."
    log_warn "Please quit CudoShare before installing to avoid conflicts."
    read -r -p "Press [Enter] to continue anyway, or Ctrl+C to cancel..."
fi

# Check write permissions
if [[ ! -w "${INSTALL_DIR}" ]]; then
    log_error "You do not have write permission to ${INSTALL_DIR}."
    log_error "Please run this script with a user that can write to Applications, or use:"
    echo "  sudo bash install-mac.sh"
    exit 1
fi

# ---------------------------------------------------------------------------
# Download
# ---------------------------------------------------------------------------

log_info "Downloading latest CudoShare for macOS..."
log_info "URL: ${DOWNLOAD_URL}"

if ! command -v curl &>/dev/null; then
    log_error "curl is required but not installed."
    exit 1
fi

mkdir -p "${MOUNT_POINT}"

HTTP_CODE=$(curl -fsSL -w "%{http_code}" -o "${DMG_PATH}" "${DOWNLOAD_URL}")
if [[ "${HTTP_CODE}" != "200" ]]; then
    log_error "Download failed (HTTP ${HTTP_CODE})."
    log_error "Please check your internet connection or try downloading manually from:"
    echo "  https://github.com/${REPO}/releases/latest"
    exit 1
fi

FILE_SIZE=$(du -h "${DMG_PATH}" | cut -f1)
log_success "Downloaded ${FILE_SIZE} to ${DMG_PATH}"

# ---------------------------------------------------------------------------
# Mount & Install
# ---------------------------------------------------------------------------

log_info "Mounting disk image..."

hdiutil attach "${DMG_PATH}" -nobrowse -quiet -mountpoint "${MOUNT_POINT}"

APP_BUNDLE=""
for item in "${MOUNT_POINT}"/*.app; do
    if [[ -d "${item}" ]]; then
        APP_BUNDLE="${item}"
        break
    fi
done

if [[ -z "${APP_BUNDLE}" ]]; then
    log_error "Could not find ${APP_NAME}.app inside the DMG."
    exit 1
fi

APP_NAME_ONLY=$(basename "${APP_BUNDLE}")
DEST_PATH="${INSTALL_DIR}/${APP_NAME_ONLY}"

# Remove old version if exists
if [[ -d "${DEST_PATH}" ]]; then
    log_warn "Existing ${APP_NAME} found. Updating..."
    rm -rf "${DEST_PATH}"
fi

log_info "Copying ${APP_NAME_ONLY} to ${INSTALL_DIR}..."
cp -a "${APP_BUNDLE}" "${DEST_PATH}"
log_success "Installed to ${DEST_PATH}"

# Detach DMG
hdiutil detach "${MOUNT_POINT}" -quiet
log_success "Unmounted disk image."

# ---------------------------------------------------------------------------
# Post-install
# ---------------------------------------------------------------------------

# Verify codesign / notarization (optional but nice)
if command -v codesign &>/dev/null; then
    if codesign -vv "${DEST_PATH}" &>/dev/null; then
        log_success "Application signature verified."
    else
        log_warn "Could not verify application signature. You may see a security warning on first launch."
        log_warn "If so, go to System Settings > Privacy & Security and click 'Open Anyway'."
    fi
fi

log_info "Registering application..."
# Touch to help Finder notice the new app
touch "${DEST_PATH}"

# ---------------------------------------------------------------------------
# Done
# ---------------------------------------------------------------------------

echo ""
echo "=========================================="
echo -e "     ${GREEN}Installation Complete!${NC}"
echo "=========================================="
echo ""
echo "  📁 Location: ${DEST_PATH}"
echo "  🚀 Launch:   open -a ${APP_NAME}"
echo ""
echo "  💡 First Launch Tip:"
echo "     If you see 'CudoShare can't be opened', go to:"
echo "     System Settings > Privacy & Security > Open Anyway"
echo ""
echo "  🎉 Welcome to CudoShare — Share without limits."
echo ""
