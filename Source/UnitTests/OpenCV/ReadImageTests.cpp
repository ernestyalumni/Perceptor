#include <opencv2/core.hpp>
#include <opencv2/imgcodecs.hpp>
#include <gtest/gtest.h>
#include <string>

namespace GoogleUnitTests
{
namespace OpenCV
{

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
TEST(ReadImageTests, ImReadReads)
{
  // TODO: Require to install samples?
  //const std::string image_path {cv::samples::findFile("starry_night.jpg")};
  const std::string image_path {"../Data/len_full.jpg"};
  cv::Mat img {cv::imread(image_path, cv::IMREAD_COLOR)};

  EXPECT_FALSE(img.empty());
}

} // namespace OpenCV
} // namespace GoogleUnitTests
