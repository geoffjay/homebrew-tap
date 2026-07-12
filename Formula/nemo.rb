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
  version "0.7.0"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/geoffjay/nemo/releases/download/v#{version}/nemo-aarch64-apple-darwin.tar.gz"
      sha256 "91b82b7afd5e50dba644829af62b666d4942a3ce809d087a8d78abf491c80f1d"
    end
    on_intel do
      url "https://github.com/geoffjay/nemo/releases/download/v#{version}/nemo-x86_64-apple-darwin.tar.gz"
      sha256 "6eca9830ef29254a67c85c5ec91ee503e4a289b144530c44a0bae639b61a7137"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/geoffjay/nemo/releases/download/v#{version}/nemo-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "81be1c1da3deba591f64726e78ce6f88881cb74f62f1d687bda654065430c2f3"
    end
    on_intel do
      url "https://github.com/geoffjay/nemo/releases/download/v#{version}/nemo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "df482c305b2716866ef423975acc3f675135c7ebf5f4f2ae011852803945edb7"
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
