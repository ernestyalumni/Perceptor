#!/bin/bash
#
# REV:    0.1.A (Valid are A, B, D, T, Q, and P)
#               (For Alpha, Beta, Dev, Test, QA, and Production)
#
# PLATFORM: Linux but otherwise Not platform dependent
#
# PURPOSE: Post-installation actions for CUDA Toolkit.
# TODO: Set these environment variables permanently.
#
# set -n   # Uncomment to check script syntax, without execution.
#          # NOTE: Do not forget to put the # comment back in or
#          #       the shell script will never execute!
# set -x   # Uncomment to debug this shell script
#
# cf. https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#post-installation-actions
##########################################################

echo $PATH
export PATH=/usr/local/cuda-12.0/bin${PATH:+:${PATH}}

echo $LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/local/cuda-12.0/lib64\
                         ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}