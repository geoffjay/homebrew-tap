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
  version "0.1.1"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/geoffjay/tower/releases/download/v#{version}/tower-aarch64-apple-darwin.tar.gz"
      sha256 "b721c5fcdb9965c866394f7746e1a771c9864e14d8f70f99ab142fb5f036be33"
    end
    on_intel do
      url "https://github.com/geoffjay/tower/releases/download/v#{version}/tower-x86_64-apple-darwin.tar.gz"
      sha256 "49dcd7e030c38677e8c6530f21ee056a8821e20aa275e02ac49a2389ee2f3030"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/geoffjay/tower/releases/download/v#{version}/tower-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "86d1e7842e4acd9cab74e91c544286b00e8f0ab0bcf054f6aeda00f00fbaedd5"
    end
    on_intel do
      url "https://github.com/geoffjay/tower/releases/download/v#{version}/tower-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "de5440bff6213e4ed613f5d1d12c5579bca9ac503e2caff8a6f207b9b8e3a17f"
    end
  end

  def install
    bin.install "tower"
  end

  test do
    assert_match "tower", shell_output("#{bin}/tower --version")
  end
end
