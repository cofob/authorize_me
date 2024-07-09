#!/usr/bin/env bash
# This script compiles the source code for the project
set -eax

# Delete dist folder if it exists
if [ -d "dist" ]; then
  rm -rf dist
fi

# Create dist folder
mkdir dist

# Compile the source code
amber src/main.ab dist/main.sh