class Fasttrack < Formula
  desc "FastTrack is a cross-platform application designed to track multiple objects in video recording. "
  homepage "https://fasttrack.sh"
  url "https://github.com/FastTrackOrg/FastTrack/archive/refs/tags/v6.3.2.tar.gz"
  sha256 "ef542f87e7318c51fae0c530535b029be6d339faab4e37091385b9b082fe8fa6"
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
