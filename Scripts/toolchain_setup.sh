#!/bin/bash

################################################################################
# cf. Vasquez, Simmonds. Mastering Embedded Linux Programming. 2021.
# Ch. 2. Learning about Toolchains.
################################################################################

function install_ubuntu_required
{
  # libstdc++6 libstdc++ both problematic, conflicts with newer libstdc++11

  sudo apt-get update
  sudo apt-get install autoconf automake bison bzip2 cmake flex g++ gawk gcc \
    gettext git gperf help2man libncurses5-dev \
    libtool libtool-bin \
    make patch python3-dev rsync texinfo unzip wget xz-utils
}

function install_crosstool-NG
{
  git clone git@github.com:crosstool-ng/crosstool-ng.git
  cd crosstool-ng
  # crosstool-ng-1.24.0 tag is out dated.
  git checkout master
  ./bootstrap
  # --prefix=${PWD} option means program will be installed into the current dir,
  # which avoids need for root permissions, as would be required if you were to
  # install it in default location /usr/local/share
  ./configure --prefix=${PWD}
  make
  make install
}

##########################################################
#               BEGINNING OF MAIN
##########################################################

install_ubuntu_required

install_crosstool-NG

# End of script
