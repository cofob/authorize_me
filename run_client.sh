#!/usr/bin/env bash
# This script runs the compiled source code
set -eax

amber src/client.ab dist/client.sh
bash dist/client.sh $@
