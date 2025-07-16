class Fasttrack < Formula
  desc "FastTrack is a cross-platform application designed to track multiple objects in video recording. "
  homepage "https://fasttrack.sh"
  url "https://github.com/FastTrackOrg/FastTrack/archive/refs/tags/v6.5.0.tar.gz"
  sha256 "a28e975709f9654063fe4cfe91b8758818724b41f68986fdd20a356476cb69c8"
  license "GPL-3.0"
  revision 1

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "qt"
  depends_on "opencv"

  def install
    system "cmake", "-S", ".", "-B", "build", "-DSKIP_TEST=ON"
    system "cmake", "--build", "build"

    libexec.install "build/bin/fasttrack.app"

    bin.install_symlink libexec/"fasttrack.app/Contents/MacOS/fasttrack"
  end

  def caveats
    <<~EOS
      🎉 FastTrack has been installed!

      🖥️ To run the CLI:
        fasttrack --cli [options]

      ▶️ To launch the GUI (from Terminal):
        fasttrack

      🧩 Optional: Add FastTrack to your Applications folder:
        ln -s "#{opt_libexec}/fasttrack.app" /Applications/FastTrack.app
    EOS
  end
end
