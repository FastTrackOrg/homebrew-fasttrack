class Opencv < Formula
  desc "Open source computer vision library"
  homepage "https://opencv.org/"
  license "Apache-2.0"
  revision 1

  stable do
    url "https://github.com/opencv/opencv/archive/refs/tags/4.11.0.tar.gz"
    sha256 "9a7c11f924eff5f8d8070e297b322ee68b9227e003fd600d4b8122198091665f"

    resource "contrib" do
      url "https://github.com/opencv/opencv_contrib/archive/refs/tags/4.11.0.tar.gz"
      sha256 "2dfc5957201de2aa785064711125af6abb2e80a64e2dc246aca4119b19687041"
    end
  end

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build
  depends_on "eigen"
  depends_on "ffmpeg"
  depends_on "jpeg-turbo"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "openblas"
  depends_on "webp"
  depends_on "zlib"

  uses_from_macos "zlib"

  def install
    resource("contrib").stage buildpath/"opencv_contrib"

    ENV["OpenBLAS_HOME"] = Formula["openblas"].opt_prefix
    ENV.delete("PYTHONPATH")

    # Delete bundled 3rdparty
    %w[ffmpeg libjasper libjpeg libjpeg-turbo libpng libtiff libwebp openexr openjpeg protobuf tbb zlib].each do |l|
      rm_r(buildpath/"3rdparty"/l)
    end

    args = %W[
      -DCMAKE_CXX_STANDARD=17
      -DCMAKE_OSX_DEPLOYMENT_TARGET=
      -DBUILD_LIST=core,imgproc,highgui,imgcodecs,videoio,video,calib3d,photo,features2d
      -DBUILD_TESTS=OFF
      -DBUILD_PERF_TESTS=OFF
      -DBUILD_EXAMPLES=OFF
      -DBUILD_opencv_python3=OFF
      -DOPENCV_ENABLE_NONFREE=OFF
      -DOPENCV_EXTRA_MODULES_PATH=#{buildpath}/opencv_contrib/modules
      -DOPENCV_GENERATE_PKGCONFIG=ON
      -DWITH_1394=OFF
      -DWITH_CUDA=OFF
      -DWITH_EIGEN=ON
      -DWITH_FFMPEG=ON
      -DWITH_GPHOTO2=OFF
      -DWITH_GSTREAMER=OFF
      -DWITH_JASPER=OFF
      -DWITH_OPENEXR=OFF
      -DWITH_OPENGL=OFF
      -DWITH_OPENVINO=OFF
      -DWITH_QT=OFF
      -DWITH_TBB=OFF
      -DWITH_VTK=OFF
      -DWITH_JPEG=ON
      -DWITH_PNG=ON
      -DWITH_TIFF=ON
      -DWITH_WEBP=ON
      -DWITH_ZLIB=ON
      -DBUILD_JPEG=OFF
      -DBUILD_PNG=OFF
      -DBUILD_TIFF=OFF
      -DBUILD_WEBP=OFF
      -DBUILD_ZLIB=OFF
    ]

    system "cmake", "-S", ".", "-B", "build", *args, *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    # Fix .pc file
    inreplace lib/"pkgconfig/opencv#{version.major}.pc", prefix, opt_prefix
  end

  test do
    (testpath/"test.cpp").write <<~CPP
      #include <opencv2/opencv.hpp>
      #include <iostream>
      int main() {
        std::cout << CV_VERSION << std::endl;
        return 0;
      }
    CPP
    system ENV.cxx, "-std=c++17", "test.cpp", "-I#{include}/opencv4", "-o", "test"
    assert_equal version.to_s, shell_output("./test").strip
  end
end
