<#
.SYNOPSIS
  Builds the Microsoft Store (MSIX) package for Intelligent Speech.

.DESCRIPTION
  Produces dist-msix/IntelligentSpeech_<version>_x64.msix from a release build with
  the in-app auto-updater compiled out (cargo feature `msix` + VITE_MSIX=1). The
  Store delivers updates for this package. The normal Windows installer and the
  macOS build are unaffected: they are built without these flags and keep the updater.

  Upload the resulting .msix to Partner Center unsigned; the Store signs it.
  For local sideload testing pass -CertPath/-CertPassword (the certificate subject
  must equal the manifest Publisher, CN=92764B88-701F-49CC-99DC-4C1EF773C569).

.EXAMPLE
  .\scripts\build-msix.ps1
  .\scripts\build-msix.ps1 -SkipBuild        # repackage an existing release build
#>
param(
  [switch]$SkipBuild,
  [string]$CertPath,
  [string]$CertPassword
)

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

# --- version: tauri.conf.json "1.2.0" -> MSIX "1.2.0.0" (Store requires revision 0)
$conf = Get-Content "$root\src-tauri\tauri.conf.json" -Raw | ConvertFrom-Json
$version = "$($conf.version).0"
if ($version -notmatch '^\d+\.\d+\.\d+\.0$') { throw "Unexpected version '$version'" }

# --- build (updater disabled in this build only)
if (-not $SkipBuild) {
  $env:VITE_MSIX = "1"
  try {
    bun run tauri build --no-bundle --features msix
    if ($LASTEXITCODE -ne 0) { throw "tauri build failed" }
  } finally {
    Remove-Item Env:\VITE_MSIX -ErrorAction SilentlyContinue
  }
}

# --- locate build output (respects .cargo/config.toml target-dir)
$meta = cargo metadata --manifest-path "$root\src-tauri\Cargo.toml" --no-deps --format-version 1 | ConvertFrom-Json
$release = Join-Path $meta.target_directory "release"
$exe = Join-Path $release "handy.exe"
if (-not (Test-Path $exe)) { throw "Release build not found at $exe (run without -SkipBuild)" }

# --- stage package contents
$stage = Join-Path $root "dist-msix\stage"
if (Test-Path $stage) { Remove-Item $stage -Recurse -Force }
New-Item -ItemType Directory -Path "$stage\Assets" | Out-Null

Copy-Item $exe "$stage\IntelligentSpeech.exe"
$dlls = Get-ChildItem $release -Filter *.dll -File
if (-not $dlls) { Write-Warning "No DLLs next to the exe; the app may be missing ONNX Runtime/DirectML." }
$dlls | Copy-Item -Destination $stage

Copy-Item "$root\src-tauri\resources" "$stage\resources" -Recurse
Get-ChildItem "$stage\resources" -Filter "android_screenshot*" -Recurse | Remove-Item -Force

foreach ($a in "StoreLogo", "Square44x44Logo", "Square71x71Logo", "Square150x150Logo") {
  Copy-Item "$root\src-tauri\icons\$a.png" "$stage\Assets\$a.png"
}

(Get-Content "$root\src-tauri\msix\AppxManifest.xml" -Raw).Replace("__VERSION__", $version) |
  Set-Content "$stage\AppxManifest.xml" -Encoding utf8

# --- pack
$sdk = Get-ChildItem "${env:ProgramFiles(x86)}\Windows Kits\10\bin" -Directory |
  Where-Object { $_.Name -match '^10\.' } | Sort-Object Name -Descending |
  Where-Object { Test-Path "$($_.FullName)\x64\makeappx.exe" } | Select-Object -First 1
if (-not $sdk) { throw "makeappx.exe not found; install the Windows 10/11 SDK." }
$makeappx = "$($sdk.FullName)\x64\makeappx.exe"

$out = Join-Path $root "dist-msix\IntelligentSpeech_${version}_x64.msix"
& $makeappx pack /d $stage /p $out /o
if ($LASTEXITCODE -ne 0) { throw "makeappx failed" }

if ($CertPath) {
  $signtool = "$($sdk.FullName)\x64\signtool.exe"
  & $signtool sign /fd SHA256 /f $CertPath /p $CertPassword $out
  if ($LASTEXITCODE -ne 0) { throw "signtool failed" }
}

Write-Host "`nCreated $out"
Write-Host "Display name: Intelligent Speech | Updater: disabled (Store-managed)"
