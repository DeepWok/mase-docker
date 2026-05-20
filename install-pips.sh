#!/usr/bin/env bash
# --------------------------------------------------------------------
#    This script installs pip packages for both Docker containers 
# --------------------------------------------------------------------
set -o errexit
set -o pipefail
set -o nounset

# Install MASE pip dependencies
mkdir -p /srcPkgs \
    && cd /srcPkgs \
    && git clone https://github.com/DeepWok/mase.git \
    && cd mase \
    && pip3 install --no-build-isolation --extra-index-url https://download.pytorch.org/whl/cu128 ".${1:-}" \
    && cd .. \
    && rm -rf mase
