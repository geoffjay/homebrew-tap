# This file was generated by GoReleaser. DO NOT EDIT.
class SgTooling < Formula
  desc "Developer tooling"
  homepage "https://github.com/geoffjay/7g-tooling"
  version "0.1.5-beta"
  bottle :unneeded

  if OS.mac?
    url "https://github.com/geoffjay/7g-tooling/releases/download/v0.1.5-beta/7g-tooling_Darwin_x86_64.tar.gz"
    sha256 "fd7c574241faef63479c5055b0e2c76bd0a62a53a08d43382e835e60a753df27"
  elsif OS.linux?
  end
  
  depends_on "go"

  def install
    bin.install "7g"
  end

  test do
    system "#{bin}/7g version"
  end
end
