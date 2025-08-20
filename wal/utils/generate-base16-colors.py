#    ┳┓┏┓┏┓┏┓┓┏┓ ┏┓┏┓┓ ┏┓┳┓  ┏┓┏┓┳┓┏┓┳┓┏┓┏┳┓┏┓┳┓
#    ┣┫┣┫┗┓┣ ┃┣┓ ┃ ┃┃┃ ┃┃┣┫━━┃┓┣ ┃┃┣ ┣┫┣┫ ┃ ┃┃┣┫
#    ┻┛┛┗┗┛┗┛┻┗┛━┗┛┗┛┗┛┗┛┛┗  ┗┛┗┛┛┗┗┛┛┗┛┗ ┻ ┗┛┛┗
#

import json
import os
import colorsys

# ---- Color utilities ----

def hex_to_rgb(hex_color):
    hex_color = hex_color.lstrip("#")
    return tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))

def rgb_to_hex(rgb):
    return "#{:02x}{:02x}{:02x}".format(*rgb)

def blend(color1, color2, ratio=0.5):
    r1, g1, b1 = hex_to_rgb(color1)
    r2, g2, b2 = hex_to_rgb(color2)
    blended = (
        int(r1 * (1 - ratio) + r2 * ratio),
        int(g1 * (1 - ratio) + g2 * ratio),
        int(b1 * (1 - ratio) + b2 * ratio),
    )
    return rgb_to_hex(blended)

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

# ---- HSL utilities ----

def hex_to_hsl(hex_color):
    r, g, b = [x / 255.0 for x in hex_to_rgb(hex_color)]
    h, l, s = colorsys.rgb_to_hls(r, g, b)  # HLS: h=[0-1], l, s
    return h * 360, s, l

def hsl_to_hex(h, s, l):
    h = (h % 360) / 360.0
    r, g, b = colorsys.hls_to_rgb(h, l, s)
    return rgb_to_hex((int(r * 255), int(g * 255), int(b * 255)))

# ---- Load JSON ----

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

# Shading function to use
shade = darken if theme_is_light else lighten

# Shade base00 - base07 using background and foreground
base00 = shade(bg, 0.00)
base01 = shade(bg, 0.05)
base02 = shade(bg, 0.10)
base03 = shade(bg, 0.20)
base04 = shade(fg, 0.30)
base05 = shade(fg, 0.00)
base06 = shade(fg, 0.05)
base07 = shade(fg, 0.00)

# ---- Warm colors generation ----
bright_colors = [
    data["colors"]["color9"],
    data["colors"]["color10"],
    data["colors"]["color11"],
    data["colors"]["color12"],
    data["colors"]["color13"],
    data["colors"]["color14"],
    data["colors"]["color15"],
]

bright_hsl = [hex_to_hsl(c) for c in bright_colors]

# Find warm hues (20°–60° = orange/yellow)
warm_candidates = [(h, s, l) for (h, s, l) in bright_hsl if 20 <= h <= 60]

if warm_candidates:
    h, s, l = warm_candidates[0]
    candidate_orange = hsl_to_hex(h, min(s + 0.2, 1.0), min(l + 0.1, 1.0))
    candidate_brown  = hsl_to_hex(h, max(s - 0.3, 0.0), max(l - 0.3, 0.0))
else:
    # fallback from magenta
    h, s, l = hex_to_hsl(data["colors"]["color13"])
    candidate_orange = hsl_to_hex(h - 60, min(s + 0.2, 1.0), min(l + 0.1, 1.0))
    candidate_brown  = hsl_to_hex(h - 70, max(s - 0.3, 0.0), max(l - 0.3, 0.0))

# Raw reference warm colors
raw_orange = "#d65d0e"
raw_brown = "#a0522d"

# Final: blend candidate with raw (to "pop" but still fit scheme)
base09 = blend(candidate_orange, raw_orange, 0.4)  # Orange
base0F = blend(candidate_brown,  raw_brown,  0.4)  # Brown

# ---- Build Lua base16 table ----
lua_colors = {
    "base00": base00,
    "base01": base01,
    "base02": base02,
    "base03": base03,
    "base04": base04,
    "base05": base05,
    "base06": base06,
    "base07": base07,
    "base08": data["colors"]["color9"],
    "base09": base09,
    "base0A": data["colors"]["color11"],
    "base0B": data["colors"]["color10"],
    "base0C": data["colors"]["color14"],
    "base0D": data["colors"]["color12"],
    "base0E": data["colors"]["color13"],
    "base0F": base0F,
}

# ---- Write Lua file ----

with open(output_path, "w") as f:
    f.write("--  ┏┓┓┏┓ ┏┏┓┓   ┳┓┏┓┏┓┏┓┓┏┓  ┳┓┓┏┳┳┳┓  ┏┓┏┓┓ ┏┓┳┓┏┓\n")
    f.write("--  ┃┃┗┫┃┃┃┣┫┃ ━━┣┫┣┫┗┓┣ ┃┣┓━━┃┃┃┃┃┃┃┃━━┃ ┃┃┃ ┃┃┣┫┗┓\n")
    f.write("--  ┣┛┗┛┗┻┛┛┗┗┛  ┻┛┛┗┗┛┗┛┻┗┛  ┛┗┗┛┻┛ ┗  ┗┛┗┛┗┛┗┛┛┗┗┛\n")
    f.write("--                                                  \n\n")
    f.write("-- stylua: ignore\n")
    f.write(f"-- Detected as {'light' if theme_is_light else 'dark'} theme\n")
    f.write("return {\n")
    for key, value in lua_colors.items():
        f.write(f"  {key} = \"{value}\",\n")
    f.write("}\n")

print(f"✅ Lua theme written to: {output_path}")
