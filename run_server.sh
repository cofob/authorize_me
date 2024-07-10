#!/usr/bin/env bash
# This script runs the compiled source code
set -eax

amber src/server.ab dist/server.sh
bash dist/server.sh $@
