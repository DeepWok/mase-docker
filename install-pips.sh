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
    && git clone git@github.com:DeepWok/mase.git \
    && cd mase \
    && pip3 install -e . \
    && cd .. \
    && rm -rf mase
