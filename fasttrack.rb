class Fasttrack < Formula
  desc "FastTrack is a cross-platform application designed to track multiple objects in video recording. "
  homepage "https://fasttrack.sh"
  url "https://github.com/FastTrackOrg/FastTrack/archive/refs/tags/v6.4.0.tar.gz"
  sha256 "e20b1e2c1dc7ae96ce0ab2cd0eaa6c262475ad9883fd6e630882d0c23815f3db"
  license "GPL-3.0"
  revision 1

  depends_on "pkg-config" => :build
  depends_on "googletest" => :build
  depends_on "qt"
  depends_on "opencv"

  def install
    system "cmake", "-S", ".", "-B", "build"
    system "cmake", "--build", "build"
    prefix.install "src/build/bin/fasttrack.app"
    bin.write_exec_script "#{prefix}/fasttrack.app/Contents/MacOS/fasttrack"
    bin.install "src/build/bin/fasttrack-cli.app/Contents/MacOS/fasttrack-cli"
  end
end
