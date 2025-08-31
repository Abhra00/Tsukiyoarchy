#!/bin/sh
set -e

# Install location for patched fonts
fontDir="$HOME/fonts"
mkdir -p "$fontDir"

# Official URLs
sfMonoUrl="https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg"
patcherZipUrl="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FontPatcher.zip"

# Temporary workspace
tmpDir="$(mktemp -d)"
dmgFile="$tmpDir/SF-Mono.dmg"
zipFile="$tmpDir/FontPatcher.zip"
patcherDir="$tmpDir/nerd-patcher"

echo "Downloading SF Mono DMG..."
wget -qO "$dmgFile" "$sfMonoUrl"

echo "Downloading Nerd Fonts Patcher..."
wget -qO "$zipFile" "$patcherZipUrl"

echo "Extracting FontPatcher.zip..."
unzip -qq "$zipFile" -d "$patcherDir"
patcher="$patcherDir/font-patcher"

# Ensure patcher is executable
chmod +x "$patcher"

echo "Extracting SF Mono DMG..."
7z x -y "$dmgFile" -o"$tmpDir/dmg" >/dev/null

# Locate the .pkg inside the DMG
pkgFile=$(find "$tmpDir/dmg" -name "*.pkg" | head -n1)
if [ -z "$pkgFile" ]; then
    echo "❌ No .pkg found in DMG."
    exit 1
fi

echo "Extracting PKG with 7z..."
7z x -y "$pkgFile" -o"$tmpDir/pkg" >/dev/null

# Extract all Payloads and collect the raw .otf fonts
rawFonts="$tmpDir/fonts"
mkdir -p "$rawFonts"
payloads=$(find "$tmpDir/pkg" -type f -name "Payload*")

echo "Extracting Payload contents..."
for payload in $payloads; do
    outDir="$tmpDir/payload-$(basename "$payload")"
    mkdir -p "$outDir"
    (cd "$outDir" && cat "$payload" | gzip -d | cpio -idmv) 2>/dev/null || true
    find "$outDir" -name "*.otf" -exec cp {} "$rawFonts" \;
done

# Patch each .otf via Nerd Font Patcher
echo "Patching fonts with Nerd Fonts Patcher (complete set)..."
for font in "$rawFonts"/*.otf; do
    echo " → Patching $(basename "$font")"
    fontforge -script "$patcher" \
      --complete \
      --outputdir "$fontDir" \
      "$font"
done

echo "Cleaning up..."
rm -rf "$tmpDir"

# Refresh font cache
if command -v fc-cache >/dev/null 2>&1; then
    echo "Refreshing font cache..."
    fc-cache -f "$fontDir"
fi

echo "✅ SF Mono Nerd Fonts are installed in $fontDir"
echo "Installed files:"
ls -1 "$fontDir"

