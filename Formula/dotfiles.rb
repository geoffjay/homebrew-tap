# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Dotfiles < Formula
  desc "Developer tooling"
  homepage "https://github.com/geoffjay/dotfiles"
  version "0.2.0"
  bottle :unneeded

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/geoffjay/dotfiles/releases/download/v0.2.0/dotfiles_Darwin_x86_64.tar.gz"
      sha256 "375332b8560c5172bf2b9f9e3370abffc3df89ffcde92070958f545ef5ddd95c"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/geoffjay/dotfiles/releases/download/v0.2.0/dotfiles_linux_x86_64.tar.gz"
      sha256 "dcad0c4c83ab34da1f15f99893ab8e43164a8e218bb5d0977a2d9817ec9d1c49"
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url "https://github.com/geoffjay/dotfiles/releases/download/v0.2.0/dotfiles_linux_armv6.tar.gz"
      sha256 "e8edd17321180fca572ee7f0d05a82a24201eb554e08ad61ae48c0e5eb395d10"
    end
  end

  depends_on "go"

  def install
    bin.install "dotfiles"
  end

  test do
    system "#{bin}/dotfiles version"
  end
end
