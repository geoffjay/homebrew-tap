# typed: false
# frozen_string_literal: true

# Homebrew formula for tower.
#
# This file is the source of truth for the formula published to the
# geoffjay/homebrew-tap tap. It is regenerated for each release by
# scripts/gen-homebrew-formula.sh, which fills in the version and the
# per-target sha256 checksums from the release's checksums.txt.
#
# See docs/knowledgebase/concepts/releases.md for the release workflow.
class Tower < Formula
  desc "Control and visibility for herds of coding agents"
  homepage "https://github.com/geoffjay/tower"
  version "0.8.0"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/geoffjay/tower/releases/download/v#{version}/tower-aarch64-apple-darwin.tar.gz"
      sha256 "d0569e7aa2565462f7d138669c597653e4d36719a031aa59c3804447137eaf80"
    end
    on_intel do
      url "https://github.com/geoffjay/tower/releases/download/v#{version}/tower-x86_64-apple-darwin.tar.gz"
      sha256 "a9ded8fa408fde709635e352df43c78bff7b7b62b25b5ea8ffe56ff1297b2a87"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/geoffjay/tower/releases/download/v#{version}/tower-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "eac0d9cb71b8029298e661a2e6c896a3c03d3b2681ee39f6a616afcf759e9a77"
    end
    on_intel do
      url "https://github.com/geoffjay/tower/releases/download/v#{version}/tower-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a0cf096f53b5f8373298a21fd573cdf8452d3d236391e43d5154a15eb9dac3aa"
    end
  end

  def install
    bin.install "tower"
  end

  test do
    assert_match "tower", shell_output("#{bin}/tower --version")
  end
end
