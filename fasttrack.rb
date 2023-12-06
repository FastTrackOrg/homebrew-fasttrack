class Fasttrack < Formula
  desc "FastTrack is a cross-platform application designed to track multiple objects in video recording. "
  homepage "https://fasttrack.sh"
  url "https://github.com/FastTrackOrg/FastTrack/archive/refs/tags/v6.3.3.tar.gz"
  sha256 "3d516f48d0fe16da5b7ee2b95adf272a700c83d2d177e7d9ac3fcb1458afa750"
  license " GPL-3.0"
  revision 1

  depends_on "pkg-config" => :build
  depends_on "googletest" => :build
  depends_on "qt"
  depends_on "opencv"

  def install
    system "qmake6", "FastTrack.pro",
           "CONFIG+=release"
    system "make"
    bin.install "src/build/FastTrack.app"
    bin.install "src/build_cli/FastTrack-cli.app/Contents/MacOS/FastTrack-cli"
  end
end
