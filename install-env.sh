#!/usr/bin/env bash
# --------------------------------------------------------------------
#    This script installs environment vars for both Docker containers 
# --------------------------------------------------------------------
set -o errexit
set -o pipefail
set -o nounset

# Add environment variables
VHLS_PATH=$1
VHLS_VERSION=$2
printf "\
\nexport LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:\$LIBRARY_PATH \
\n# Basic PATH setup \
\nexport PATH=/workspace/scripts:/workspace/hls/build/bin:/workspace/llvm/build/bin:\$PATH:/srcPkgs/verible/bin \
\n# Vitis HLS setup \
\nexport VHLS=$VHLS_PATH \
\nexport XLNX_VERSION=$VHLS_VERSION \
\n# source \${VHLS}/Vitis_HLS/\${XLNX_VERSION}/settings64.sh \
\n# MLIR-AIE PATH setup \
\nexport PATH=/srcPkgs/cmake/bin:/workspace/hls/build/bin:/workspace/llvm/build/bin:/workspace/mlir-aie/install/bin:/workspace/mlir-air/install/bin:\$PATH \
\nexport PYTHONPATH=\$PATH:/workspace:/workspace/machop:/workspace/mlir-aie/install/python:/workspace/mlir-air/install/python:\$PYTHONPATH \
\nexport LD_LIBRARY_PATH=/workspace/mlir-aie/lib:/workspace/mlir-air/lib:/opt/xaiengine:\$LD_LIBRARY_PATH \
\n# Thread setup \
\nexport nproc=\$(grep -c ^processor /proc/cpuinfo) \
\n# Terminal color... \
\nexport PS1=\"[\\\\\\[\$(tput setaf 3)\\\\\\]\\\t\\\\\\[\$(tput setaf 2)\\\\\\] \\\u\\\\\\[\$(tput sgr0)\\\\\\]@\\\\\\[\$(tput setaf 2)\\\\\\]\\\h \\\\\\[\$(tput setaf 7)\\\\\\]\\\w \\\\\\[\$(tput sgr0)\\\\\\]] \\\\\\[\$(tput setaf 6)\\\\\\]$ \\\\\\[\$(tput sgr0)\\\\\\]\" \
\nexport LS_COLORS='rs=0:di=01;96:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01' \
\nalias ls='ls --color' \
\nalias grep='grep --color'\n" >> /root/.bashrc

#Add vim environment
printf "\
\nset autoread \
\nautocmd BufWritePost *.cpp silent! !clang-format -i <afile> \
\nautocmd BufWritePost *.c   silent! !clang-format -i <afile> \
\nautocmd BufWritePost *.h   silent! !clang-format -i <afile> \
\nautocmd BufWritePost *.hpp silent! !clang-format -i <afile> \
\nautocmd BufWritePost *.cc  silent! !clang-format -i <afile> \
\nautocmd BufWritePost *.py  silent! set tabstop=4 shiftwidth=4 expandtab \
\nautocmd BufWritePost *.py  silent! !python3 -m black <afile> \
\nautocmd BufWritePost *.sv  silent! !verible-verilog-format --inplace <afile> \
\nautocmd BufWritePost *.v  silent! !verible-verilog-format --inplace <afile> \
\nautocmd BufWritePost * redraw! \
\n" >> /root/.vimrc

