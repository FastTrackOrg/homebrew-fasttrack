class Fasttrack < Formula
  desc "FastTrack is a cross-platform application designed to track multiple objects in video recording. "
  homepage "https://fasttrack.sh"
  url "https://github.com/FastTrackOrg/FastTrack/archive/refs/tags/v6.3.4.tar.gz"
  sha256 "7ce8ca265178cb689d677b02c76ab77ba18e1a35ad59ca9d14cf11728f8ffad8"
  license "GPL-3.0"
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
