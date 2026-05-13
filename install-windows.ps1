#Requires -Version 5.1
<#
.SYNOPSIS
    CudoShare Installer for Windows
.DESCRIPTION
    Downloads and installs the latest CudoShare release on Windows 10/11.
    Run as Administrator for best results.
.EXAMPLE
    irm https://raw.githubusercontent.com/CudoShare/cudoshare-releases/main/install-windows.ps1 | iex
    .\install-windows.ps1
#>

[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

# ============================================================================
# Configuration
# ============================================================================

$AppName      = 'CudoShare'
$Repo         = 'CudoShare/cudoshare-releases'
$DownloadUrl  = "https://github.com/$Repo/releases/latest/download/CudoShare-windows.msi"
$TempDir      = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), "CudoShare-Install-$(Get-Random)")
$MsiPath      = [System.IO.Path]::Combine($TempDir, 'CudoShare-windows.msi')
$LogPath      = [System.IO.Path]::Combine($TempDir, 'install.log')

# ============================================================================
# Helpers
# ============================================================================

function Write-Info    ($msg) { Write-Host "[INFO] $msg" -ForegroundColor Cyan }
function Write-Success ($msg) { Write-Host "[OK]   $msg" -ForegroundColor Green }
function Write-Warn    ($msg) { Write-Host "[WARN] $msg" -ForegroundColor Yellow }
function Write-ErrorMsg($msg) { Write-Host "[ERR]  $msg" -ForegroundColor Red }

function Test-IsAdmin {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Test-OSVersion {
    $os = Get-CimInstance Win32_OperatingSystem
    $caption = $os.Caption
    $build = [System.Environment]::OSVersion.Version

    # Windows 10 (1903 = build 18362) or Windows 11 (build 22000+)
    $minBuild = 18362
    $currentBuild = $os.BuildNumber

    if ($currentBuild -lt $minBuild) {
        Write-ErrorMsg "CudoShare requires Windows 10 version 1903 (build 18362) or later."
        Write-ErrorMsg "Your build: $currentBuild"
        exit 1
    }

    # 64-bit check
    if (-not [Environment]::Is64BitOperatingSystem) {
        Write-ErrorMsg "CudoShare requires a 64-bit version of Windows."
        exit 1
    }

    Write-Success "$caption (Build $currentBuild) — supported."
}

function Invoke-Cleanup {
    if (Test-Path $TempDir) {
        Remove-Item -Recurse -Force $TempDir -ErrorAction SilentlyContinue
    }
}

# ============================================================================
# Main
# ============================================================================

Write-Host ""
Write-Host "==========================================" -ForegroundColor Blue
Write-Host "     CudoShare Installer for Windows" -ForegroundColor Blue
Write-Host "==========================================" -ForegroundColor Blue
Write-Host ""

# Admin check (warn, don't fail — MSI can sometimes run as user)
if (-not (Test-IsAdmin)) {
    Write-Warn "This script is not running as Administrator."
    Write-Warn "Installation may fail if you lack permissions. If it fails, please re-run as Admin:"
    Write-Warn "  Right-click PowerShell -> 'Run as Administrator', then run the install command again."
    Write-Host ""
    $continue = Read-Host "Press [Enter] to continue anyway, or Ctrl+C to cancel"
}

# OS checks
Write-Info "Checking system requirements..."
Test-OSVersion

# Network check
Write-Info "Checking internet connectivity..."
if (-not (Test-Connection -ComputerName github.com -Count 1 -Quiet -ErrorAction SilentlyContinue)) {
    Write-Warn "Cannot reach github.com. Proceeding anyway..."
}

# Check if running
$process = Get-Process -Name $AppName -ErrorAction SilentlyContinue
if ($process) {
    Write-Warn "CudoShare is currently running."
    Write-Warn "Please close CudoShare before installing to avoid file-in-use errors."
    $null = Read-Host "Press [Enter] to continue anyway, or Ctrl+C to cancel"
}

# Create temp dir
New-Item -ItemType Directory -Path $TempDir -Force | Out-Null

# Download
Write-Info "Downloading latest CudoShare for Windows..."
Write-Info "URL: $DownloadUrl"

try {
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri $DownloadUrl -OutFile $MsiPath -UseBasicParsing -TimeoutSec 120
    $ProgressPreference = 'Continue'
}
catch {
    Write-ErrorMsg "Download failed: $($_.Exception.Message)"
    Write-ErrorMsg "Please check your internet connection or try downloading manually from:"
    Write-ErrorMsg "  https://github.com/$Repo/releases/latest"
    Invoke-Cleanup
    exit 1
}

$fileSize = (Get-Item $MsiPath).Length
if ($fileSize -lt 1MB) {
    Write-ErrorMsg "Downloaded file seems too small ($([math]::Round($fileSize/1KB, 2)) KB)."
    Write-ErrorMsg "The release may not exist yet, or the download was interrupted."
    Invoke-Cleanup
    exit 1
}

Write-Success "Downloaded $([math]::Round($fileSize/1MB, 2)) MB to $MsiPath"

# Install
Write-Info "Installing CudoShare..."
Write-Info "This may take a moment. Please wait..."

$msiArgs = @(
    '/i'
    "`"$MsiPath`""
    '/qn'
    '/norestart'
    "/l*v `"$LogPath`""
)

$proc = Start-Process -FilePath 'msiexec.exe' -ArgumentList $msiArgs -Wait -PassThru -NoNewWindow

if ($proc.ExitCode -ne 0) {
    Write-ErrorMsg "Installation failed with exit code $($proc.ExitCode)."
    if (Test-Path $LogPath) {
        Write-ErrorMsg "Install log saved to: $LogPath"
        Write-ErrorMsg "Last 10 lines of log:"
        Get-Content $LogPath -Tail 10 | ForEach-Object { Write-ErrorMsg "  $_" }
    }
    Invoke-Cleanup
    exit 1
}

Write-Success "Installation completed successfully."

# Verify installation
$installDirs = @(
    "${env:ProgramFiles}\$AppName",
    "${env:ProgramFiles(x86)}\$AppName",
    "${env:LocalAppData}\Programs\$AppName"
)

$found = $false
foreach ($dir in $installDirs) {
    if (Test-Path $dir) {
        Write-Success "Found installation at: $dir"
        $found = $true
        break
    }
}

if (-not $found) {
    Write-Warn "Could not automatically locate installation directory."
    Write-Warn "CudoShare should be available in your Start Menu."
}

# Cleanup
Invoke-Cleanup

# ============================================================================
# Done
# ============================================================================

Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host "     Installation Complete!" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""
Write-Host "  🚀 Launch:    Press Win key, type 'CudoShare', and press Enter"
Write-Host "  🖥️  Start Menu: Look for 'CudoShare' under All Apps"
Write-Host ""
Write-Host "  💡 First Launch Tip:"
Write-Host "     Windows SmartScreen may show a warning. Click 'More info' then 'Run anyway'."
Write-Host ""
Write-Host "  🎉 Welcome to CudoShare — Share without limits."
Write-Host ""
