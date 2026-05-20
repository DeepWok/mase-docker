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
    && pip3 install . \
    && pip3 install ".[mx-ptq]" \
    && cd .. \
    && rm -rf mase
