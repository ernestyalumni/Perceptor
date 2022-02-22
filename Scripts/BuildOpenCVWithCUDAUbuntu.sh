#!/bin/bash
#
# REV:    0.1.A (Valid are A, B, D, T, Q, and P)
#               (For Alpha, Beta, Dev, Test, QA, and Production)
#
# PLATFORM: Linux but otherwise Not platform dependent
#
# REQUIREMENTS: If this script has requirements that need to be noted, this
#               is the place to spell those requirements in detail.
#
#         EXAMPLE:  OpenSSH is required for this shell script to work.
#
# PURPOSE: Build OpenCV with CUDA with C++ only, no Python.
#
# set -n   # Uncomment to check script syntax, without execution.
#          # NOTE: Do not forget to put the # comment back in or
#          #       the shell script will never execute!
# set -x   # Uncomment to debug this shell script
#
##########################################################
#         DEFINE FILES AND VARIABLES HERE
##########################################################
#
# cf. https://docs.opencv.org/4.x/d6/d15/tutorial_building_tegra_cuda.html
# "Configuring Desktop Ubuntu Linx"
#
# BUILD_PNG governs whether the libpng library is built from source in the
# 3rdparty directory.
# BUILD_JPEG, BUILD_TBB, BUILD_TIFF, BUILD_ZLIB as above.
#
# Turn off 3rd. party protobuf build to avoid error in parameter packing in
# argument.
#
# cf. https://docs.opencv.org/4.x/db/d05/tutorial_config_reference.html
# OPENCV_DNN_CUDA - enable CUDA backend, CUDA, CUBLAS, and CUDNN must be
# installed.
#
# WITH_GSTREAMER specifies whether to include GStreamer 1.0 support.
# WITH_GSTREAMER_0_10 specifies whether to include GStreamer 0.10 support.
# Both were OFF by openCV.org documentation, but on for others' examples.
#
# WITH_OPENEXR - specifies whether to include ILM support via OpenEXR
#
# For CUDA_TOOLKIT_ROOT_DIR, I'm insisting that a soft symbolic link to the
# desired CUDA is made.
#
# For CUDA_ARCH_BIN, I looked up https://en.wikipedia.org/wiki/CUDA and looked
# up the number for compute capability for each card I was interested in:
# GeForce 980 Ti (Maxwell) = 5.2
# GeForce 1050 Ti (Pascal) = 6.1
# Jetson TX2 (Pascal) = 6.2
# Jetson Xavier NX (Volta) = 7.2
# GeForce RTX 3070 (Ampere) = 8.6
#
# Video4Linux WITH_V4L - capture images from camera using Video4Linux API.
#

flags_for_cmakes="-DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local \
  -DBUILD_PNG=OFF \
  -DBUILD_TIFF=OFF \
  -DBUILD_TBB=OFF \
  -DBUILD_JPEG=OFF \
  -DBUILD_ZLIB=OFF \
  -DBUILD_EXAMPLES=OFF \
  -DBUILD_JAVA=OFF \
  -DBUILD_opencv_python=OFF \
  -DBUILD_PROTOBUF=ON \
  -DBUILD_WEBP=OFF \
  -DWITH_OPENCL=OFF \
  -DWITH_TBB=ON \
  -DWITH_OPENGL=ON \
  -DOPENCV_ENABLE_NONFREE=ON \
  -D ENABLE_FAST_MATH=1 \
  -D CUDA_FAST_MATH=1 \
  -D WITH_CUBLAS=1 \
  -DWITH_CUDA=ON \
  -DWITH_GTK=ON \
  -DWITH_VTK=OFF \
  -D WITH_CUDNN=ON \
  -D OPENCV_DNN_CUDA=ON \
  -D WITH_FFPEG=ON \
  -DWITH_GSTREAMER=ON \
  -DWITH_GSTREAMER_0_10=ON \
  -DWITH_OPENEXR=OFF \
  -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda \
  -DCUDA_ARCH_BIN='5.2 6.1 6.2 7.2 8.6' \
  -DCUDA_ARCH_PTX="" \
  -DWITH_V4L=ON \
  -DBUILD_opencv_python2=OFF \
  -DINSTALL_PYTHON_EXAMPLES=OFF \
  -DINSTALL_C_EXAMPLES=OFF \
  -DINSTALL_TESTS=OFF \
  -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
  -DOPENCV_TEST_DATA_PATH=../opencv_extra/testdata \
  -DOPENGL_GL_PREFERENCE=LEGACY "

flags_on_one_line="-DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local -DBUILD_PNG=OFF -DBUILD_TIFF=OFF -DBUILD_TBB=OFF -DBUILD_JPEG=OFF -DBUILD_ZLIB=OFF -DBUILD_EXAMPLES=OFF -DBUILD_JAVA=OFF -DBUILD_opencv_python=OFF -DBUILD_PROTOBUF=ON -DBUILD_WEBP=OFF -DWITH_OPENCL=OFF -DWITH_TBB=ON -DWITH_OPENGL=ON -DOPENCV_ENABLE_NONFREE=ON -D ENABLE_FAST_MATH=1 -D CUDA_FAST_MATH=1 -D WITH_CUBLAS=1 -DWITH_CUDA=ON -DWITH_GTK=ON -DWITH_VTK=OFF -D WITH_CUDNN=ON -D OPENCV_DNN_CUDA=ON -D WITH_FFPEG=ON -DWITH_GSTREAMER=ON -DWITH_GSTREAMER_0_10=ON -DWITH_OPENEXR=OFF -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda -DCUDA_ARCH_BIN='5.2 6.1 6.2 7.2 8.6' -DCUDA_ARCH_PTX="" -DWITH_V4L=ON -DBUILD_opencv_python2=OFF -DINSTALL_PYTHON_EXAMPLES=OFF -DINSTALL_C_EXAMPLES=OFF -DINSTALL_TESTS=OFF -DOPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules -DOPENCV_TEST_DATA_PATH=../opencv_extra/testdata -DOPENGL_GL_PREFERENCE=LEGACY "

##########################################################
#              DEFINE FUNCTIONS HERE
##########################################################

# cf. OpenCV "Installation in Linux", opencv.org
# cf. https://docs.opencv.org/3.4/d7/d9f/tutorial_linux_install.html
# cf. "How to install OpenCV 4.5.2 with CUDA 11.2 and CUDNN 8.2 in Ubuntu 20.04"
# cf. https://gist.github.com/raulqf/f42c718a658cddc16f9df07ecc627be7

function install_required
{
  sudo apt update
  sudo apt upgrade
  # Compiler, required, generic tools.
  sudo apt-get install build-essential cmake pkg-config git

  # GTK+2.x or higher, including headers (libgtk2.0-dev), required.
  # ffmpeg or libav development packages: libavcodec-dev, libavformat-dev,
  # libswscale-dev
  sudo apt-get install libgtk-3-dev libavcodec-dev libavformat-dev \
    libswscale-dev libavresample-dev
}

# cf. https://docs.opencv.org/4.x/d6/d15/tutorial_building_tegra_cuda.html
function install_required_tegra_like
{
  sudo apt-get install libglew-dev zlib1g-dev libavutil-dev libpostproc-dev \
    libeigen3-dev
}

# Image I/O libraries (libs)
function install_optional_imageIO
{
  # [optional] libjpeg-dev, libpng-dev, libtiff-dev, libjasper-dev,
  # libdc1394-22-dev.
  # libjasper may not be there.
  sudo apt-get install libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev
}

# cf. https://gist.github.com/raulqf/f42c718a658cddc16f9df07ecc627be7
function install_optional_audio_video
{
  # Video/Audio Libs - FFMPEG, GSTREAMER, x264 and so on.
  sudo apt install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
}

# Parallelism library C++ for CPU
function install_optional_cpu_parallelism
{
  sudo apt-get install libtbb2 libtbb-dev
}

# cf. $ sudo apt-get install libprotobuf-dev protobuf-compiler
function install_optional_protobuf
{
  sudo apt-get install libprotobuf-dev protobuf-compiler
}

function check_for_opencv_contrib()
{
  if [ -d "../../opencv_contrib" ] && [ -d "../../opencv_contrib/modules" ]
  then
    printf "opencv_contrib dir exists; proceeding"
  else
    printf "opencv_contrib repo isn't local; git cloning ... "
    cd ../../
    git clone https://github.com/opencv/opencv_contrib.git
  fi
}

make_build_dir_cmake_and_make ()
{
  if [ -d "../Build" ]
  then
    printf "Build dir already exists; proceeding"
  else
    printf "Build dir doesn't exist; making it."
    mkdir -p ../Build/
  fi

  cd ../Build/
  eval "cmake $1 .."

  # cf. https://stackoverflow.com/questions/226703/how-do-i-prompt-for-yes-no-cancel-input-in-a-linux-shell-script
  while true; do
    read -p "Do you wish to make now?" yn
    case $yn in
      [Nn]* ) exit;;
      esac
  done

  # cf. https://stackoverflow.com/questions/6482377/check-existence-of-input-argument-in-a-bash-shell-script
  # $# variable tells you number of input arguments script was passed.
  if [ $# -eq 2 ]
    then
      # Check if argument is empty string or not; -z switch tests if expansion
      # "$1" is a null string or not.
      if [ -z "$2" ]
        then
          make -j
      else
        make -j$2
      fi
  else
    # Default to 2 cores.
    make -j2
  fi
}

##########################################################
#               BEGINNING OF MAIN
##########################################################

install_required

install_required_tegra_like

install_optional_imageIO

install_optional_cpu_parallelism

install_optional_protobuf

check_for_opencv_contrib

make_build_dir_cmake_and_make $flags_for_cmakes

# End of script

