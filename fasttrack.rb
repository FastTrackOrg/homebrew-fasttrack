class Fasttrack < Formula
  desc "FastTrack is a cross-platform application designed to track multiple objects in video recording. "
  homepage "https://fasttrack.sh"
  url "https://github.com/FastTrackOrg/FastTrack/archive/refs/tags/v6.3.1.tar.gz"
  sha256 "40864090be3647672eba2e35b41f952e17005cbde7d80fa890a7025411acdce9"
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
