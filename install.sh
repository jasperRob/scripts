#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# If bin directory does not exist, create it
mkdir -p ~/bin

# Vreate symlinks to all other executable scripts in this directory in ~/bin
for file in "$SCRIPT_DIR"/*; do
  [ "$file" = "$SCRIPT_DIR/install.sh" ] && continue
  [ "$(basename "$file")" = "README.md" ] && continue
  [ -x "$file" ] || continue

  name="$(basename "$file")"
  ln -sf "$file" ~/bin/"$name"
  echo "Linked: ~/bin/$name -> $file"
done
