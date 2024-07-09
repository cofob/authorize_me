#!/usr/bin/env bash
# This script runs the compiled source code
set -eax

amber src/main.ab dist/main.sh
bash dist/main.sh $@
