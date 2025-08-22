#    ┳┓┏┓┏┓┏┓┓┏┓ ┏┓┏┓┓ ┏┓┳┓  ┏┓┏┓┳┓┏┓┳┓┏┓┏┳┓┏┓┳┓
#    ┣┫┣┫┗┓┣ ┃┣┓ ┃ ┃┃┃ ┃┃┣┫━━┃┓┣ ┃┃┣ ┣┫┣┫ ┃ ┃┃┣┫
#    ┻┛┛┗┗┛┗┛┻┗┛━┗┛┗┛┗┛┗┛┛┗  ┗┛┗┛┛┗┗┛┛┗┛┗ ┻ ┗┛┛┗
#
# Dependencies:
# Only Python standard library

import json
import os
import random
import colorsys

# ---- Color Utilities ----

def hex_to_rgb(hex_color):
    hex_color = hex_color.lstrip("#")
    return tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))

def rgb_to_hex(rgb):
    return "#{:02x}{:02x}{:02x}".format(*rgb)

def lighten(color, amount=0.1):
    r, g, b = hex_to_rgb(color)
    r = min(int(r + (255 - r) * amount), 255)
    g = min(int(g + (255 - g) * amount), 255)
    b = min(int(b + (255 - b) * amount), 255)
    return rgb_to_hex((r, g, b))

def darken(color, amount=0.1):
    r, g, b = hex_to_rgb(color)
    r = max(int(r * (1 - amount)), 0)
    g = max(int(g * (1 - amount)), 0)
    b = max(int(b * (1 - amount)), 0)
    return rgb_to_hex((r, g, b))

def get_luminance(color):
    r, g, b = hex_to_rgb(color)
    return 0.2126 * r + 0.7152 * g + 0.0722 * b

# ---- HLS-based Hue Shift (lightweight alternative to LCHab) ----
def hls_shift_from_theme(base_hex, target_hue_deg, reference_hex):
    """Use reference color's saturation/lightness, only change hue."""
    ref_r, ref_g, ref_b = [x / 255.0 for x in hex_to_rgb(reference_hex)]
    _, l, s = colorsys.rgb_to_hls(ref_r, ref_g, ref_b)

    h_new = target_hue_deg / 360.0
    r_new, g_new, b_new = colorsys.hls_to_rgb(h_new, l, s)
    return rgb_to_hex((int(r_new * 255), int(g_new * 255), int(b_new * 255)))

# ---- Load Theme JSON ----

home = os.path.expanduser("~")
input_path = os.path.join(home, ".cache", "wal", "colors.json")
output_path = os.path.join(home, ".cache", "wal", "colors-base16-nvim.lua")

with open(input_path, "r") as f:
    data = json.load(f)

bg = data["special"]["background"]
fg = data["special"]["foreground"]

bg_lum = get_luminance(bg)
fg_lum = get_luminance(fg)
theme_is_light = bg_lum > fg_lum

# ---- Shade base00 - base07 ----

shade = darken if theme_is_light else lighten

base00 = shade(bg, 0.00)
base01 = shade(bg, 0.05)
base02 = shade(bg, 0.10)
base03 = shade(bg, 0.20)
base04 = shade(fg, 0.30)
base05 = shade(fg, 0.00)
base06 = shade(fg, 0.05)
base07 = shade(fg, 0.00)

# ---- Generate Harmonious Orange and Peach ----
reference_color = data["colors"]["color10"]  # bright red
base09 = hls_shift_from_theme(bg, 30, reference_color)  # orange
base0F = hls_shift_from_theme(bg, 20, reference_color)  # peach


# ---- Base08 to Base0E from theme ----

lua_colors = {
    "base00": base00,
    "base01": base01,
    "base02": base02,
    "base03": base03,
    "base04": base04,
    "base05": base05,
    "base06": base06,
    "base07": base07,
    "base08": data["colors"]["color9"],   # red
    "base09": base09,                     # orange
    "base0A": data["colors"]["color11"],  # yellow
    "base0B": data["colors"]["color10"],  # green
    "base0C": data["colors"]["color14"],  # cyan
    "base0D": data["colors"]["color12"],  # blue
    "base0E": data["colors"]["color13"],  # magenta
    "base0F": base0F,                     # peach
}

# ---- Write Lua Output ----

with open(output_path, "w") as f:
    f.write("-- stylua: ignore\n")
    f.write(f"-- Detected as {'light' if theme_is_light else 'dark'} theme\n")
    f.write("return {\n")
    for key, value in lua_colors.items():
        f.write(f"  {key} = \"{value}\",\n")
    f.write("}\n")

print(f"✅ Lua theme written to: {output_path}")
