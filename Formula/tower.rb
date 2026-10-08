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
  version "0.1.0"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/geoffjay/tower/releases/download/v#{version}/tower-aarch64-apple-darwin.tar.gz"
      sha256 "516dd169a6d98b14e945881e531fe0e0157b8974af4770d70d2f3dc0118b677f"
    end
    on_intel do
      url "https://github.com/geoffjay/tower/releases/download/v#{version}/tower-x86_64-apple-darwin.tar.gz"
      sha256 "430ab03b35442a0001d1559d4d5162d18876a59e222b5bd9d20fa4d51b6aa570"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/geoffjay/tower/releases/download/v#{version}/tower-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d534f30e7ea8abcfd8f85d3eaa73aa8cff16392c9e69c1700d98180ac3c8774c"
    end
    on_intel do
      url "https://github.com/geoffjay/tower/releases/download/v#{version}/tower-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "12c43af353474d2c23ce9dad1ab14318293fee0603599d3a124be96aca9d050a"
    end
  end

  def install
    bin.install "tower"
  end

  test do
    assert_match "tower", shell_output("#{bin}/tower --version")
  end
end
