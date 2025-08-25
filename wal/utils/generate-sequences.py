#  ┏┓┏┓┳┓┏┓┳┓┏┓┏┳┓┏┓  ┏┓┳┓┏┓┳  ┏┓┏┓┏┓┳┳┏┓┳┓┏┓┏┓┏┓
#  ┃┓┣ ┃┃┣ ┣┫┣┫ ┃ ┣   ┣┫┃┃┗┓┃  ┗┓┣ ┃┃┃┃┣ ┃┃┃ ┣ ┗┓
#  ┗┛┗┛┛┗┗┛┛┗┛┗ ┻ ┗┛  ┛┗┛┗┗┛┻  ┗┛┗┛┗┻┗┛┗┛┛┗┗┛┗┛┗┛
#                                                



#!/usr/bin/env python3
import json
from pathlib import Path

# === Utility Functions ===
def hex_to_rgb(hex_color):
    hex_color = hex_color.lstrip("#")
    return tuple(int(hex_color[i:i+2], 16) for i in (0, 2, 4))

def rgb_to_hex(rgb):
    return f"#{rgb[0]:02x}{rgb[1]:02x}{rgb[2]:02x}"

def blend(color1, color2, t):
    return tuple(
        int((1 - t) * c1 + t * c2)
        for c1, c2 in zip(hex_to_rgb(color1), hex_to_rgb(color2))
    )

def generate_grayscale(index):
    """Generate standard xterm grayscale color for index 232–255"""
    level = 8 + (index - 232) * 10
    return f"#{level:02x}{level:02x}{level:02x}"

# === Config ===
colors_json_path = Path.home() / ".cache/wal/colors.json"
output_path = Path.home() / ".cache/wal/sequences.txt"
total_colors = 256

# === Load colors.json ===
with open(colors_json_path) as f:
    data = json.load(f)

# Extract base 16 theme colors
base_colors = []
for i in range(16):
    key = f"color{i}"
    color = data["colors"].get(key)
    if not color:
        raise ValueError(f"{key} not found in colors.json!")
    base_colors.append(color)

# === Generate ANSI sequences ===
with open(output_path, "w") as f:
    for i in range(total_colors):
        if i < 16:
            # Use exact theme base colors
            hex_color = base_colors[i]
        elif 232 <= i <= 255:
            # Preserve grayscale ramp
            hex_color = generate_grayscale(i)
        else:
            # Interpolate between base colors (16–231)
            segment = (i - 16) / (232 - 16) * (len(base_colors) - 1)
            lower = int(segment)
            upper = min(lower + 1, len(base_colors) - 1)
            t = segment - lower
            hex_color = rgb_to_hex(blend(base_colors[lower], base_colors[upper], t))

        # Write escape sequence
        f.write(f"\x1b]4;{i};{hex_color}\x1b\\")
