#!/bin/bash
# Optimize images for web: resize to max 1200px on the long edge, save to img/opt/
# Uses macOS `sips` — no additional dependencies required.

set -e

SRC_DIR="img"
OPT_DIR="img/opt"
MAX_DIM=1200

# Folders to process (skip opt/ itself)
FOLDERS=(
  "3884-connecticut"
)

for folder in "${FOLDERS[@]}"; do
  src="$SRC_DIR/$folder"
  dst="$OPT_DIR/$folder"

  if [ ! -d "$src" ]; then
    echo "Source not found: $src — skipping"
    continue
  fi

  mkdir -p "$dst"

  for img in "$src"/*.jpg "$src"/*.JPG "$src"/*.jpeg "$src"/*.JPEG; do
    [ -f "$img" ] || continue
    fname=$(basename "$img")
    out="$dst/$fname"

    echo "Optimizing $img → $out"
    sips --resampleHeightWidthMax $MAX_DIM "$img" --out "$out" > /dev/null
  done
done

echo "Done."
