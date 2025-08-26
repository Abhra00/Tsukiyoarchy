#!/usr/bin/env python3

#    ┳┓┏┓┏┓┏┓┓┏┓ ┏┓┏┓┓ ┏┓┳┓  ┏┓┏┓┳┓┏┓┳┓┏┓┏┳┓┏┓┳┓
#    ┣┫┣┫┗┓┣ ┃┣┓ ┃ ┃┃┃ ┃┃┣┫━━┃┓┣ ┃┃┣ ┣┫┣┫ ┃ ┃┃┣┫
#    ┻┛┛┗┗┛┗┛┻┗┛━┗┛┗┛┗┛┗┛┛┗  ┗┛┗┛┛┗┗┛┛┗┛┗ ┻ ┗┛┛┗
#
# Dependencies: Python 3 standard library only
# Input:  ~/.cache/wal/colors.json (from pywal)
# Output: ~/.cache/wal/colors-base16-nvim.lua (Base16 Lua theme for Neovim)

import json
import os
import colorsys

# ── Color Utilities ──────────────────────────────────────────────────────────────

def hex_to_rgb(hex_color):
    hex_color = hex_color.lstrip("#")
    return tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))

def rgb_to_hex(rgb):
    return "#{:02x}{:02x}{:02x}".format(*rgb)

def lighten(hex_color, amount=0.1):
    r, g, b = hex_to_rgb(hex_color)
    r = min(int(r + (255 - r) * amount), 255)
    g = min(int(g + (255 - g) * amount), 255)
    b = min(int(b + (255 - b) * amount), 255)
    return rgb_to_hex((r, g, b))

def darken(hex_color, amount=0.1):
    r, g, b = hex_to_rgb(hex_color)
    r = max(int(r * (1 - amount)), 0)
    g = max(int(g * (1 - amount)), 0)
    b = max(int(b * (1 - amount)), 0)
    return rgb_to_hex((r, g, b))

def shift_hue(hex_color, degrees):
    r, g, b = [x / 255.0 for x in hex_to_rgb(hex_color)]
    h, l, s = colorsys.rgb_to_hls(r, g, b)
    h = (h + degrees / 360.0) % 1.0
    r_new, g_new, b_new = colorsys.hls_to_rgb(h, l, s)
    return rgb_to_hex((int(r_new * 255), int(g_new * 255), int(b_new * 255)))

def get_luminance(hex_color):
    r, g, b = hex_to_rgb(hex_color)
    return 0.2126 * r + 0.7152 * g + 0.0722 * b

# ── Load pywal Colors ────────────────────────────────────────────────────────────

home = os.path.expanduser("~")
input_path = os.path.join(home, ".cache", "wal", "colors.json")
output_path = os.path.join(home, ".cache", "wal", "colors-base16-nvim.lua")

with open(input_path, "r") as f:
    data = json.load(f)

bg = data["special"]["background"]
fg = data["special"]["foreground"]

# ── Theme Brightness ─────────────────────────────────────────────────────────────

theme_is_light = get_luminance(bg) > get_luminance(fg)

# ── Base00 - Base03: Background Shades ───────────────────────────────────────────

shadebg = darken if theme_is_light else lighten

base00 = shadebg(bg, 0.00)  # background
base01 = shadebg(bg, 0.05)  # lighter background
base02 = shadebg(bg, 0.10)  # selection background
base03 = shadebg(bg, 0.20)  # comments, invisibles

# ── Base04 - Base07: Foreground Shades (Proper Gradation) ────────────────────────

if theme_is_light:
    base04 = lighten(fg, 0.15)  # UI text / subtle fg
    base05 = fg                 # main foreground
    base06 = darken(fg, 0.15)   # bold fg
    base07 = darken(fg, 0.30)   # headings / strong contrast
else:
    base04 = darken(fg, 0.15)   # UI text / subtle fg
    base05 = fg                 # main foreground
    base06 = lighten(fg, 0.15)  # bold fg
    base07 = lighten(fg, 0.30)  # headings / strong contrast

# ── Base08 - Base0F: Accent Hues from pywal ──────────────────────────────────────

base08 = data["colors"]["color9"]   # red
base09 = shift_hue(base08, 15)      # orange (shifted red)
base0A = data["colors"]["color11"]  # yellow
base0B = data["colors"]["color10"]  # green
base0C = data["colors"]["color14"]  # cyan
base0D = data["colors"]["color12"]  # blue
base0E = data["colors"]["color13"]  # magenta
base0F = shift_hue(base0E, -15)     # special / fallback

# ── Compose Final Lua Table ──────────────────────────────────────────────────────

lua_colors = {
    "base00": base00,
    "base01": base01,
    "base02": base02,
    "base03": base03,
    "base04": base04,
    "base05": base05,
    "base06": base06,
    "base07": base07,
    "base08": base08,
    "base09": base09,
    "base0A": base0A,
    "base0B": base0B,
    "base0C": base0C,
    "base0D": base0D,
    "base0E": base0E,
    "base0F": base0F,
}

# ── Write Lua Theme File ─────────────────────────────────────────────────────────

with open(output_path, "w") as f:
    f.write("-- stylua: ignore\n")
    f.write(f"-- Detected as {'light' if theme_is_light else 'dark'} theme\n")
    f.write("return {\n")
    for key in sorted(lua_colors):
        f.write(f"  {key} = \"{lua_colors[key]}\",\n")
    f.write("}\n")

print(f"✅ Lua Base16 theme written to: {output_path}")
