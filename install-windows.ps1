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

# ═════════════════════════════════════════════════════════════════════════════
#  Configuration
# ═════════════════════════════════════════════════════════════════════════════

$AppName      = 'CudoShare'
$Repo         = 'CudoShare/cudoshare-releases'
$DownloadUrl  = "https://github.com/$Repo/releases/latest/download/CudoShare.msi"
$TempDir      = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), "CudoShare-Install-$(Get-Random)")
$MsiPath      = [System.IO.Path]::Combine($TempDir, 'CudoShare-windows.msi')
$LogPath      = [System.IO.Path]::Combine($TempDir, 'install.log')

# ═════════════════════════════════════════════════════════════════════════════
#  Colors & Styles (ANSI)
# ═════════════════════════════════════════════════════════════════════════════

$esc = [char]27
$Reset       = "${esc}[0m"
$Bold        = "${esc}[1m"
$Dim         = "${esc}[2m"

$Black       = "${esc}[30m"
$Red         = "${esc}[31m"
$Green       = "${esc}[32m"
$Yellow      = "${esc}[33m"
$Blue        = "${esc}[34m"
$Magenta     = "${esc}[35m"
$Cyan        = "${esc}[36m"
$White       = "${esc}[37m"

$BrightGreen = "${esc}[92m"
$BrightCyan  = "${esc}[96m"
$BrightYellow= "${esc}[93m"
$BrightWhite = "${esc}[97m"

# Box Drawing
$HORIZ = '─'
$VERT  = '│'
$TL    = '╭'
$TR    = '╮'
$BL    = '╰'
$BR    = '╯'
$Arrow = '▸'
$Check = '✓'
$Cross = '✗'

# ═════════════════════════════════════════════════════════════════════════════
#  Helpers
# ═════════════════════════════════════════════════════════════════════════════

function Clear-Terminal {
    if ($Host.Name -match 'ConsoleHost') {
        Clear-Host
    }
}

function Write-Color {
    param([string]$Text)
    Write-Host "$Text$Reset" -NoNewline
}

function Print-Banner {
    Clear-Terminal
    Write-Color "`n"
    Write-Color "  ${Cyan}${Bold}   ${TL}"
    for ($i=0; $i -lt 42; $i++) { Write-Color $HORIZ }
    Write-Color "${TR}${Reset}`n"

    Write-Color "  ${Cyan}${Bold}   ${VERT}                                          ${VERT}${Reset}`n"
    Write-Color "  ${Cyan}${Bold}   ${VERT}${Reset}     ${Bold}${BrightWhite}  ⚡  C U D O S H A R E${Reset}              ${Cyan}${Bold}${VERT}${Reset}`n"
    Write-Color "  ${Cyan}${Bold}   ${VERT}                                          ${VERT}${Reset}`n"
    Write-Color "  ${Cyan}${Bold}   ${VERT}${Reset}       ${Dim}Lightning-fast file sharing${Reset}      ${Cyan}${Bold}${VERT}${RESET}`n"
    Write-Color "  ${Cyan}${Bold}   ${VERT}${RESET}          ${Dim}Direct · Secure · Private${RESET}       ${Cyan}${Bold}${VERT}${RESET}`n"
    Write-Color "  ${Cyan}${Bold}   ${VERT}                                          ${VERT}${RESET}`n"

    Write-Color "  ${Cyan}${Bold}   ${BL}"
    for ($i=0; $i -lt 42; $i++) { Write-Color $HORIZ }
    Write-Color "${BR}${Reset}`n`n"
}

function Draw-BoxTop {
    param([int]$Width = 50)
    Write-Color "  ${Cyan}${Bold}${TL}"
    for ($i=0; $i -lt $Width; $i++) { Write-Color $HORIZ }
    Write-Color "${TR}${Reset}`n"
}

function Draw-BoxBottom {
    param([int]$Width = 50)
    Write-Color "  ${Cyan}${Bold}${BL}"
    for ($i=0; $i -lt $Width; $i++) { Write-Color $HORIZ }
    Write-Color "${BR}${Reset}`n"
}

function Draw-BoxLine {
    param([string]$Text, [int]$Width = 50)
    $pad = $Width - $Text.Length
    Write-Color "  ${Cyan}${Bold}${VERT}${Reset} $Text"
    for ($i=0; $i -lt $pad - 1; $i++) { Write-Color ' ' }
    Write-Color "${Cyan}${Bold}${VERT}${Reset}`n"
}

function Show-Spinner {
    param(
        [scriptblock]$ScriptBlock,
        [string]$Message = "Working..."
    )
    $spinChars = @('⠋','⠙','⠹','⠸','⠼','⠴','⠦','⠧','⠇','⠏')
    $job = Start-Job -ScriptBlock $ScriptBlock
    $i = 0
    while ($job.State -eq 'Running') {
        $i = ($i + 1) % 10
        $char = $spinChars[$i]
        Write-Color "`r  ${Cyan}${Bold}${char}${Reset} ${Dim}${Message}${Reset}  "
        Start-Sleep -Milliseconds 80
    }
    $result = Receive-Job -Job $job -ErrorAction SilentlyContinue
    Remove-Job -Job $job
    Write-Color "`r$(' ' * 70)`r"
    return $result
}

function Show-ProgressBar {
    param([int]$Current, [int]$Total, [int]$Width = 40)
    $pct = [math]::Floor($Current * 100 / $Total)
    $filled = [math]::Floor($Current * $Width / $Total)
    $empty = $Width - $filled
    Write-Color "  ${Dim}[${Reset}"
    for ($i=0; $i -lt $filled; $i++) { Write-Color "${BrightCyan}█${Reset}" }
    for ($i=0; $i -lt $empty; $i++) { Write-Color "${Dim}░${Reset}" }
    Write-Color "${Dim}]${Reset} ${Bold}${pct,3}%${Reset}"
}

function Test-IsAdmin {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Invoke-Cleanup {
    if (Test-Path $TempDir) {
        Remove-Item -Recurse -Force $TempDir -ErrorAction SilentlyContinue
    }
}

# ═════════════════════════════════════════════════════════════════════════════
#  Main
# ═════════════════════════════════════════════════════════════════════════════

Print-Banner

# ─── Step 1: System Check ───────────────────────────────────────────────────
Write-Color "  ${BrightCyan}${Bold}${Arrow}${Reset} ${Bold}Checking your system${RESET}`n"

$os = Get-CimInstance Win32_OperatingSystem
$build = [int]$os.BuildNumber
$minBuild = 18362

if ($build -lt $minBuild) {
    Write-Color "  ${Red}${Bold}${Cross}${RESET} Windows 10 v1903+ required. Build: $build`n"
    exit 1
}

if (-not [Environment]::Is64BitOperatingSystem) {
    Write-Color "  ${Red}${Bold}${Cross}${RESET} 64-bit Windows required`n"
    exit 1
}

$arch = if ([Environment]::Is64BitOperatingSystem) { "x64" } else { "x86" }
Write-Color "  ${BrightGreen}${Bold}${Check}${RESET} Windows $($os.Caption) · Build $build · $arch`n"

# ─── Admin Warning ──────────────────────────────────────────────────────────
if (-not (Test-IsAdmin)) {
    Write-Color "  ${BrightYellow}${Bold}!${RESET} Not running as Administrator`n"
    Write-Color "  ${Dim}Some systems require admin rights for MSI installation.${RESET}`n"
    Write-Color "  ${Dim}If this fails, re-run PowerShell as Admin and try again.${RESET}`n`n"
}

# ─── Check running ──────────────────────────────────────────────────────────
$proc = Get-Process -Name $AppName -ErrorAction SilentlyContinue
if ($proc) {
    Write-Color "  ${BrightYellow}${Bold}!${RESET} CudoShare is currently running${RESET}`n"
    Write-Color "  ${Dim}Please close it first, or press Enter to continue anyway.${RESET}`n"
    $null = Read-Host
}

# ─── Step 2: Download ───────────────────────────────────────────────────────
Write-Color "`n  ${BrightCyan}${Bold}${Arrow}${RESET} ${Bold}Downloading CudoShare${RESET}`n"

New-Item -ItemType Directory -Path $TempDir -Force | Out-Null

$ProgressPreference = 'SilentlyContinue'

$size = 0
try {
    $response = Invoke-WebRequest -Uri $DownloadUrl -Method Head -UseBasicParsing -TimeoutSec 10 -ErrorAction SilentlyContinue
    $sizeStr = $response.Headers['Content-Length']
    if ($sizeStr) { $size = [long]$sizeStr }
}
catch { $size = 0 }

if ($size -gt 0) {
    $wc = New-Object System.Net.WebClient
    $done = $false
    $wc.DownloadFileAsync((New-Object System.Uri($DownloadUrl)), $MsiPath)

    while (-not $done) {
        if (Test-Path $MsiPath) {
            $current = (Get-Item $MsiPath).Length
            if ($current -ge $size) { $done = $true }
            Show-ProgressBar $current $size
        }
        Start-Sleep -Milliseconds 200
        if (-not $wc.IsBusy) { $done = $true }
    }
    Write-Color "`n"
    $wc.Dispose()
}
else {
    Show-Spinner -Message "Downloading CudoShare-windows.msi..." -ScriptBlock {
        param($url, $path)
        $wc = New-Object System.Net.WebClient
        $wc.DownloadFile($url, $path)
        $wc.Dispose()
    } -ArgumentList $DownloadUrl, $MsiPath | Out-Null
}

$ProgressPreference = 'Continue'

if (-not (Test-Path $MsiPath) -or (Get-Item $MsiPath).Length -lt 1MB) {
    Write-Color "  ${Red}${Bold}${Cross}${RESET} Download failed. Check your connection.`n"
    Invoke-Cleanup
    exit 1
}

$fileSizeMB = [math]::Round((Get-Item $MsiPath).Length / 1MB, 1)
Write-Color "  ${BrightGreen}${Bold}${Check}${RESET} Downloaded ${fileSizeMB} MB`n"

# ─── Step 3: Install ────────────────────────────────────────────────────────
Write-Color "`n  ${BrightCyan}${Bold}${Arrow}${RESET} ${Bold}Installing CudoShare${RESET}`n"

$msiArgs = @('/i', "`"$MsiPath`"", '/qn', '/norestart', "/l*v `"$LogPath`"")

$exitCode = Show-Spinner -Message "Installing... This may take a moment" -ScriptBlock {
    param($argsList)
    $p = Start-Process -FilePath 'msiexec.exe' -ArgumentList $argsList -Wait -PassThru -NoNewWindow
    return $p.ExitCode
} -ArgumentList (,$msiArgs)

if ($exitCode -ne 0) {
    Write-Color "  ${Red}${Bold}${Cross}${RESET} Installation failed (exit code: $exitCode)`n"
    if (Test-Path $LogPath) {
        Write-Color "  ${Dim}Log saved to: $LogPath${RESET}`n"
        Get-Content $LogPath -Tail 5 | ForEach-Object {
            Write-Color "  ${Dim}  $_${RESET}`n"
        }
    }
    Invoke-Cleanup
    exit 1
}

Write-Color "  ${BrightGreen}${Bold}${Check}${RESET} Installation complete`n"

# ─── Step 4: Verify ─────────────────────────────────────────────────────────
$installDirs = @(
    "${env:ProgramFiles}\$AppName",
    "${env:ProgramFiles(x86)}\$AppName",
    "${env:LocalAppData}\Programs\$AppName"
)

$foundDir = $null
foreach ($dir in $installDirs) {
    if (Test-Path $dir) {
        $foundDir = $dir
        break
    }
}

if ($foundDir) {
    Write-Color "  ${BrightGreen}${Bold}${Check}${RESET} Found at: ${Dim}$foundDir${RESET}`n"
}

Invoke-Cleanup

# ─── Final Banner ───────────────────────────────────────────────────────────
Write-Color "`n"
Draw-BoxTop 52
Draw-BoxLine "  ${Bold}${BrightGreen}Installation Complete!${Reset}                              " 52
Draw-BoxLine "                                                        " 52
Draw-BoxLine "  ⭐  CudoShare is ready to use                          " 52
Draw-BoxLine "  📁  Start Menu: Search for ${Bold}CudoShare${Reset}                  " 52
Draw-BoxLine "  🚀  Desktop shortcut created                           " 52
Draw-BoxLine "                                                        " 52
Draw-BoxLine "  🎉  Welcome aboard — Share without limits             " 52
Draw-BoxBottom 52
Write-Color "`n"
