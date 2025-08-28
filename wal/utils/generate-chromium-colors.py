#    ┏┓┓┏┳┓┏┓┳┳┓┳┳┳┳┳┓  ┏┓┏┓┓ ┏┓┳┓  ┏┓┏┓┳┓┏┓┳┓┏┓┏┳┓┏┓┳┓
#    ┃ ┣┫┣┫┃┃┃┃┃┃┃┃┃┃┃━━┃ ┃┃┃ ┃┃┣┫━━┃┓┣ ┃┃┣ ┣┫┣┫ ┃ ┃┃┣┫
#    ┗┛┛┗┛┗┗┛┛ ┗┻┗┛┛ ┗  ┗┛┗┛┗┛┗┛┛┗  ┗┛┗┛┛┗┗┛┛┗┛┗ ┻ ┗┛┛┗
#
import json
from pathlib import Path
from colorsys import rgb_to_hls, hls_to_rgb
import shutil

# Constants
THEME_NAME = "Chromium-Pywal"
WAL_COLORS_PATH = Path.home() / ".cache" / "wal" / "colors.json"
THEME_DIR = Path.home() / ".cache" / "wal" / THEME_NAME

def hex_to_rgb(hex_color):
    hex_color = hex_color.lstrip("#")
    return tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))

def adjust_lightness(rgb, offset):
    """Offset the lightness of an RGB color in HLS space."""
    r, g, b = [x / 255.0 for x in rgb]
    h, l, s = rgb_to_hls(r, g, b)
    l = min(1, max(0, l + offset))  # Clamp between 0 and 1
    r, g, b = hls_to_rgb(h, l, s)
    return (int(r * 255), int(g * 255), int(b * 255))

def is_dark(rgb):
    """Determine if the color is dark based on luminance."""
    r, g, b = rgb
    luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b
    return luminance < 128

def prepare_theme_dir():
    if THEME_DIR.exists():
        shutil.rmtree(THEME_DIR)
    THEME_DIR.mkdir(parents=True, exist_ok=True)

def generate_theme(background, foreground, accent, secondary):
    theme_manifest = {
        "manifest_version": 3,
        "version": "1.0",
        "name": "Chromium Pywal Theme",
        "theme": {
            "colors": {
                "frame": list(background),
                "frame_inactive": list(background),
                "toolbar": list(accent),
                "ntp_text": list(foreground),
                "ntp_link": list(accent),
                "ntp_section": list(secondary),
                "button_background": list(foreground),
                "toolbar_button_icon": list(foreground),
                "toolbar_text": list(foreground),
                "omnibox_background": list(background),
                "omnibox_text": list(foreground)
            },
            "properties": {
                "ntp_background_alignment": "bottom"
            }
        }
    }

    manifest_path = THEME_DIR / "manifest.json"
    with open(manifest_path, "w") as f:
        json.dump(theme_manifest, f, indent=2)

def main():
    with open(WAL_COLORS_PATH) as f:
        wal = json.load(f)

    background = hex_to_rgb(wal["special"]["background"])
    foreground = hex_to_rgb(wal["special"]["foreground"])

    # Apply brightness logic
    if is_dark(background):
        accent = adjust_lightness(background, 0.10)     # 10% lighter
        secondary = adjust_lightness(background, 0.20)  # 20% lighter
    else:
        accent = adjust_lightness(background, -0.10)     # 10% darker
        secondary = adjust_lightness(background, -0.20)  # 20% darker

    prepare_theme_dir()
    generate_theme(background, foreground, accent, secondary)

    print(f"✅ Chrome theme generated at: {THEME_DIR}")

if __name__ == "__main__":
    main()

