# typed: false
# frozen_string_literal: true

class GitUtils < Formula
  desc 'A collection of useful git commands'
  homepage 'https://github.com/geoffjay/git-utils'
  version '0.1.2'
  bottle :unneeded

  on_macos do
    if Hardware::CPU.intel?
      url 'https://github.com/geoffjay/git-utils/releases/download/v0.1.2/git-utils-v0.1.2-darwin-x86_64.tar.gz'
      sha256 'caf1d9c27161b8319ebf11f44438d224c4ddbcda15c11acad1cc0e0be7aa329b'
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url 'https://github.com/geoffjay/git-utils/releases/download/v0.1.2/git-utils-v0.1.2-linux-x86_64.tar.gz'
      sha256 'da6d7e6313310ac162e8a339c295b718a7b20c29b03779404f028113834359b8'
    end
    if Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      url 'https://github.com/geoffjay/git-utils/releases/download/v0.1.2/git-utils-v0.1.2-linux-armv6.tar.gz'
      sha256 '0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5'
    end
  end

  depends_on 'rust'

  def install
    bin.install 'git-utils'
  end

  test do
    system "#{bin}/git-utils version"
  end
end
