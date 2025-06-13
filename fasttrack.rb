class Fasttrack < Formula
  desc "FastTrack is a cross-platform application designed to track multiple objects in video recording. "
  homepage "https://fasttrack.sh"
  url "https://github.com/FastTrackOrg/FastTrack/archive/refs/tags/v6.4.0.tar.gz"
  sha256 "4f2de4d0ed185591722361dd21998cce489f5c97e7fe2a77c7d0e10d6193a8c3"
  license "GPL-3.0"
  revision 3

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "googletest" => :build
  depends_on "qt"
  depends_on "opencv"

  def install
    system "cmake", "-S", ".", "-B", "build"
    system "cmake", "--build", "build"

    libexec.install "build/bin/fasttrack.app"
    (bin/"fasttrack").write <<~EOS
      #!/bin/bash
      open "#{libexec}/fasttrack.app"
    EOS

    bin.install "build/bin/fasttrack-cli.app/Contents/MacOS/fasttrack-cli"
  end

  def caveats
    <<~EOS
      To launch the FastTrack GUI:
        fasttrack

      To use the command-line tool:
        fasttrack-cli

      If you want to launch the FastTrack GUI like a regular app:
        ln -s "#{opt_libexec}/fasttrack.app" /Applications/FastTrack.app
    EOS
  end
end
