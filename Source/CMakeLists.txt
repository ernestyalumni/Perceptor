CMAKE_MINIMUM_REQUIRED (VERSION 3.14)

# Language of the project is CXX (for C++)
PROJECT(PERCEPTOR LANGUAGES CXX CUDA)

# BEFORE prepends the directories specified onto current list of directories.
# cf. https://cmake.org/cmake/help/v3.0/command/include_directories.html
INCLUDE_DIRECTORIES(BEFORE ${CMAKE_SOURCE_DIR})

# cf. https://stackoverflow.com/questions/31881249/cmake-cuda-opencv

FIND_PACKAGE(CUDA REQUIRED)

IF (CUDA_FOUND)

ENDIF()

FIND_PROGRAM(CCACHE_FOUND ccache)

IF(CCACHE_FOUND)
  SET(CMAKE_CXX_COMPILER_LAUNCHER ccache)
ENDIF()

# Declare dependency on GoogleTest which is downloaded from GitHub.
# cf. https://google.github.io/googletest/quickstart-cmake.html
INCLUDE(FetchContent)
FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/609281088cfefc76f9d0ce82e1ff6c30cc3591e5.zip
)

FetchContent_MakeAvailable(googletest)

# cf. https://docs.opencv.org/3.4/db/df5/tutorial_linux_gcc_cmake.html

FIND_PACKAGE(OpenCV REQUIRED)

INCLUDE_DIRECTORIES(${OpenCV_INCLUDE_DIRS})

FIND_PACKAGE(Boost)

ADD_SUBDIRECTORY(Executables)

IF (BOOST_FOUND)
  ADD_SUBDIRECTORY(BoostUnitTests)
ENDIF()

ADD_SUBDIRECTORY(UnitTests)
