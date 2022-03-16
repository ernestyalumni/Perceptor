#!/bin/bash

################################################################################
# cf. Vasquez, Simmonds. Mastering Embedded Linux Programming. 2021.
################################################################################

# Ch. 2. Learning about Toolchains.

function toolchain_examples
{
  # Find the tuple used when building the toolchain
  printf "gcc -dumpmachine\n"
  gcc -dumpmachine
}

##########################################################
#               BEGINNING OF MAIN
##########################################################

toolchain_examples

# End of script
