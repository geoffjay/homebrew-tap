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
  version "0.10.0"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/geoffjay/nemo/releases/download/v#{version}/nemo-aarch64-apple-darwin.tar.gz"
      sha256 "236b633b5a4b5394f827bd292c1858dc4fade40a996113f88034c9e78e42ac7b"
    end
    on_intel do
      url "https://github.com/geoffjay/nemo/releases/download/v#{version}/nemo-x86_64-apple-darwin.tar.gz"
      sha256 "8ba9d8b213b06a8e1d908317726dd8601220d3c388f60816930ab5a83d61aa3d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/geoffjay/nemo/releases/download/v#{version}/nemo-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f25eb8a3a0c58dca9e7203d8ea8c2a1a6e8ceb1daf4cde3878dafba231fef35e"
    end
    on_intel do
      url "https://github.com/geoffjay/nemo/releases/download/v#{version}/nemo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "55f8e097a8eb5ade1257ace2eebca8f51e21a7d6be62551e6f7a94151a0eacb1"
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
