#!/usr/bin/env bash

set -euo pipefail

# ═════════════════════════════════════════════════════════════════════════════
#  CudoShare Installer for macOS
# ═════════════════════════════════════════════════════════════════════════════
#  Usage:
#    curl -fsSL https://raw.githubusercontent.com/CudoShare/cudoshare-releases/main/install-mac.sh | bash
#    bash install-mac.sh
# ═════════════════════════════════════════════════════════════════════════════

readonly APP_NAME="CudoShare"
readonly REPO="CudoShare/cudoshare-releases"
readonly DOWNLOAD_URL="https://github.com/${REPO}/releases/latest/download/CudoShare-macos.dmg"
readonly INSTALL_DIR="/Applications"
readonly TEMP_DIR="$(mktemp -d)"
readonly DMG_PATH="${TEMP_DIR}/CudoShare-macos.dmg"
readonly MOUNT_POINT="${TEMP_DIR}/mount"

# ─── ANSI Styles ────────────────────────────────────────────────────────────
BOLD=$(tput bold 2>/dev/null || echo '')
DIM=$(tput dim 2>/dev/null || echo '')
RESET=$(tput sgr0 2>/dev/null || echo '')

# Colors
RED=$(tput setaf 1 2>/dev/null || echo '')
GREEN=$(tput setaf 2 2>/dev/null || echo '')
YELLOW=$(tput setaf 3 2>/dev/null || echo '')
BLUE=$(tput setaf 4 2>/dev/null || echo '')
MAGENTA=$(tput setaf 5 2>/dev/null || echo '')
CYAN=$(tput setaf 6 2>/dev/null || echo '')
WHITE=$(tput setaf 7 2>/dev/null || echo '')

BRIGHT_GREEN=$(tput setaf 10 2>/dev/null || echo "$GREEN")
BRIGHT_CYAN=$(tput setaf 14 2>/dev/null || echo "$CYAN")
BRIGHT_YELLOW=$(tput setaf 11 2>/dev/null || echo "$YELLOW")
BRIGHT_MAGENTA=$(tput setaf 13 2>/dev/null || echo "$MAGENTA")
BRIGHT_WHITE=$(tput setaf 15 2>/dev/null || echo "$WHITE")

# ─── Unicode ────────────────────────────────────────────────────────────────
HORIZ='─'
VERT='│'
TL='╭'
TR='╮'
BL='╰'
BR_='╯'
ARROW='▸'
CHECK='✓'
CROSS='✗'
BULLET='•'

# ─── Helpers ────────────────────────────────────────────────────────────────

print_banner() {
    clear 2>/dev/null || true
    cat <<'EOF'

EOF
    echo "  ${CYAN}${BOLD}   ${TL}──────────────────────────────────────────${TR}${RESET}"
    echo "  ${CYAN}${BOLD}   ${VERT}                                          ${VERT}${RESET}"
    echo "  ${CYAN}${BOLD}   ${VERT}${RESET}     ${BOLD}${BRIGHT_WHITE}  ⚡  C U D O S H A R E${RESET}              ${CYAN}${BOLD}${VERT}${RESET}"
    echo "  ${CYAN}${BOLD}   ${VERT}                                          ${VERT}${RESET}"
    echo "  ${CYAN}${BOLD}   ${VERT}${RESET}       ${DIM}Lightning-fast file sharing${RESET}      ${CYAN}${BOLD}${VERT}${RESET}"
    echo "  ${CYAN}${BOLD}   ${VERT}${RESET}          ${DIM}Direct · Secure · Private${RESET}       ${CYAN}${BOLD}${VERT}${RESET}"
    echo "  ${CYAN}${BOLD}   ${VERT}                                          ${VERT}${RESET}"
    echo "  ${CYAN}${BOLD}   ${BL}──────────────────────────────────────────${BR_}${RESET}"
    echo ""
}

draw_box_top() {
    local width=$1
    printf "  ${CYAN}${BOLD}${TL}"
    for ((i=0; i<width; i++)); do printf "%s" "$HORIZ"; done
    printf "${TR}${RESET}\n"
}

draw_box_bottom() {
    local width=$1
    printf "  ${CYAN}${BOLD}${BL}"
    for ((i=0; i<width; i++)); do printf "%s" "$HORIZ"; done
    printf "${BR_}${RESET}\n"
}

draw_box_line() {
    local text="$1"
    local width=$2
    local padding=$((width - ${#text}))
    printf "  ${CYAN}${BOLD}${VERT}${RESET} ${text}"
    for ((i=0; i<padding-1; i++)); do printf " "; done
    printf "${CYAN}${BOLD}${VERT}${RESET}\n"
}

spinner() {
    local pid=$1
    local message="$2"
    local spin_chars=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
    local i=0
    while kill -0 "$pid" 2>/dev/null; do
        i=$(( (i + 1) % 10 ))
        printf "\r  ${CYAN}${BOLD}%s${RESET} ${DIM}%s${RESET}  " "${spin_chars[$i]}" "$message"
        sleep 0.08
    done
    printf "\r%-60s\r" " "
}

progress_bar() {
    local current=$1
    local total=$2
    local width=40
    local percent=$((current * 100 / total))
    local filled=$((current * width / total))
    local empty=$((width - filled))
    printf "\r  ${DIM}[${RESET}"
    for ((i=0; i<filled; i++)); do printf "${BRIGHT_CYAN}█${RESET}"; done
    for ((i=0; i<empty; i++)); do printf "${DIM}░${RESET}"; done
    printf "${DIM}]${RESET} ${BOLD}%3d%%${RESET}" "$percent"
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

print_step() {
    echo ""
    echo "  ${BRIGHT_CYAN}${BOLD}${ARROW}${RESET} ${BOLD}$1${RESET}"
}

print_success() {
    echo "  ${BRIGHT_GREEN}${BOLD}${CHECK}${RESET} $1"
}

print_warn() {
    echo "  ${BRIGHT_YELLOW}${BOLD}!${RESET} $1"
}

print_error() {
    echo "  ${RED}${BOLD}${CROSS}${RESET} $1"
}

# ─── Main ───────────────────────────────────────────────────────────────────

print_banner

# ─── Step 1: System Check ───────────────────────────────────────────────────
print_step "Checking your system"

SYS_MSG=""
OS_MAJOR=$(sw_vers -productVersion | cut -d. -f1)
ARCH=$(uname -m)

if [[ "${OS_MAJOR}" -lt 14 ]]; then
    print_error "macOS 14.0+ required. You have $(sw_vers -productVersion)"
    exit 1
fi

if [[ "${ARCH}" == "arm64" ]]; then
    SYS_MSG="Apple Silicon · macOS $(sw_vers -productVersion)"
elif [[ "${ARCH}" == "x86_64" ]]; then
    SYS_MSG="Intel 64-bit · macOS $(sw_vers -productVersion)"
else
    print_error "Unsupported architecture: ${ARCH}"
    exit 1
fi

print_success "${SYS_MSG}"

# ─── Step 2: Close running app ──────────────────────────────────────────────
if pgrep -xq "CudoShare" 2>/dev/null; then
    print_warn "CudoShare is running. Please quit it first."
    echo ""
    draw_box_top 48
    draw_box_line "  ${YELLOW}Press Return to continue anyway${RESET}" 48
    draw_box_bottom 48
    echo ""
    read -r
fi

# ─── Step 3: Download ───────────────────────────────────────────────────────
print_step "Downloading CudoShare"

mkdir -p "${MOUNT_POINT}"

TOTAL_SIZE=$(curl -fsSLI "$DOWNLOAD_URL" 2>/dev/null | grep -i content-length | awk '{print $2}' | tr -d '\r' || echo "0")

if [[ "$TOTAL_SIZE" =~ ^[0-9]+$ ]] && [[ "$TOTAL_SIZE" -gt 0 ]]; then
    curl -fsSL "$DOWNLOAD_URL" -o "${DMG_PATH}" 2>/dev/null &
    CURL_PID=$!
    while kill -0 "$CURL_PID" 2>/dev/null; do
        if [[ -f "${DMG_PATH}" ]]; then
            CURRENT_SIZE=$(stat -f%z "${DMG_PATH}" 2>/dev/null || echo 0)
            if [[ "$CURRENT_SIZE" -gt 0 ]]; then
                progress_bar "$CURRENT_SIZE" "$TOTAL_SIZE"
            fi
        fi
        sleep 0.2
    done
    wait "$CURL_PID"
    printf "\r%-60s\r" " "
else
    curl -fsSL "$DOWNLOAD_URL" -o "${DMG_PATH}" 2>/dev/null &
    CURL_PID=$!
    spinner "$CURL_PID" "Downloading CudoShare-macos.dmg..."
    wait "$CURL_PID"
fi

if [[ ! -f "${DMG_PATH}" ]] || [[ ! -s "${DMG_PATH}" ]]; then
    print_error "Download failed. Check your internet connection."
    exit 1
fi

FILE_SIZE=$(du -h "${DMG_PATH}" | cut -f1)
print_success "Downloaded ${FILE_SIZE}"

# ─── Step 4: Mount & Install ────────────────────────────────────────────────
print_step "Mounting disk image"

hdiutil attach "${DMG_PATH}" -nobrowse -quiet -mountpoint "${MOUNT_POINT}" >/dev/null 2>&1 &
SPIN_PID=$!
spinner "$SPIN_PID" "Attaching DMG..."
wait "$SPIN_PID"

APP_BUNDLE=""
for item in "${MOUNT_POINT}"/*.app; do
    if [[ -d "${item}" ]]; then
        APP_BUNDLE="${item}"
        break
    fi
done

if [[ -z "${APP_BUNDLE}" ]]; then
    print_error "Could not find CudoShare.app inside the DMG."
    exit 1
fi

APP_NAME_ONLY=$(basename "${APP_BUNDLE}")
DEST_PATH="${INSTALL_DIR}/${APP_NAME_ONLY}"

if [[ -d "${DEST_PATH}" ]]; then
    print_warn "Replacing existing installation..."
    rm -rf "${DEST_PATH}"
fi

print_step "Installing to Applications"
cp -a "${APP_BUNDLE}" "${DEST_PATH}" &
SPIN_PID=$!
spinner "$SPIN_PID" "Copying files..."
wait "$SPIN_PID"

touch "${DEST_PATH}"

hdiutil detach "${MOUNT_POINT}" -quiet >/dev/null 2>&1 &
SPIN_PID=$!
spinner "$SPIN_PID" "Cleaning up..."
wait "$SPIN_PID"

print_success "Installation complete"

# ─── Step 5: Verification ───────────────────────────────────────────────────
if command -v codesign &>/dev/null; then
    if codesign -vv "${DEST_PATH}" &>/dev/null; then
        print_success "Code signature verified"
    else
        print_warn "First launch: approve in System Settings → Privacy & Security"
    fi
fi

# ─── Final Banner ───────────────────────────────────────────────────────────
echo ""
draw_box_top 50
draw_box_line "  ${BOLD}${BRIGHT_GREEN}Installation Complete!${RESET}                            " 50
draw_box_line "                                                   " 50
draw_box_line "  ${BOLD}⭐${RESET}  CudoShare is ready to use                " 50
draw_box_line "  ${BOLD}📁${RESET}  Location: ${DIM}/Applications/CudoShare.app${RESET}       " 50
draw_box_line "  ${BOLD}🚀${RESET}  Launch:   ${DIM}open -a CudoShare${RESET}                   " 50
draw_box_line "                                                   " 50
draw_box_line "  ${BOLD}🎉${RESET}  Welcome aboard — Share without limits  " 50
draw_box_bottom 50
echo ""
