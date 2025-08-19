import json
import os

# ---- Color utilities ----

def hex_to_rgb(hex_color):
    hex_color = hex_color.lstrip("#")
    return tuple(int(hex_color[i:i+2], 16) for i in (0, 2 ,4))

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

# Blend brown for base0F & orange for base09
brown = "#a0522d"
base0F = blend(fg, brown, 0.6)
orange = "#d65d0e"
base09 = blend(fg, orange, 0.6)

# Build Lua base16 table
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

