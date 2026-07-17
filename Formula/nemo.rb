# typed: false
# frozen_string_literal: true

# Homebrew formula for Nemo.
#
# This file is the source of truth for the formula published to the
# geoffjay/homebrew-nemo tap. It is regenerated for each release by
# scripts/gen-homebrew-formula.sh, which fills in the version and the
# per-target sha256 checksums from the release's checksums.txt.
#
# See docs/packaging.md for the tap setup and release workflow.
class Nemo < Formula
  desc "Configuration-driven, GPU-accelerated desktop application framework"
  homepage "https://github.com/geoffjay/nemo"
  version "0.8.0"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/geoffjay/nemo/releases/download/v#{version}/nemo-aarch64-apple-darwin.tar.gz"
      sha256 "b489afb6cdb52c0d9ba507550cc8fa1806f45f9efdf422beb85b77839a87bd70"
    end
    on_intel do
      url "https://github.com/geoffjay/nemo/releases/download/v#{version}/nemo-x86_64-apple-darwin.tar.gz"
      sha256 "95a1ee0cc5b41d031a2c6f986eefd762ee8dc5a3932debd645f1a4ecbb4910e0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/geoffjay/nemo/releases/download/v#{version}/nemo-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "37f52b8193f57baebf0d7f59361f23ce42992b20d54fa1cc7db32db86112e9b4"
    end
    on_intel do
      url "https://github.com/geoffjay/nemo/releases/download/v#{version}/nemo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cc8301fe4a1a8b9e1f8b780b6534d3f36e29177eb551e44b354e06aa785be14f"
    end
  end

  def install
    bin.install "nemo"
    pkgshare.install Dir["share/nemo/*"] if Dir.exist?("share/nemo")
  end

  test do
    assert_match "nemo", shell_output("#{bin}/nemo --version")
  end
end
