# cf. https://docs.opencv.org/3.4/db/df5/tutorial_linux_gcc_cmake.html

MESSAGE(STATUS "OpenCV_INCLUDE_DIRS : ${OpenCV_INCLUDE_DIRS}")
MESSAGE(STATUS "OpenCV_LIBS : ${OpenCV_LIBS}")

ADD_EXECUTABLE(DisplayImage DisplayImage.cpp)
TARGET_LINK_LIBRARIES(DisplayImage ${OpenCV_LIBS})