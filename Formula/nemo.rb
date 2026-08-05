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
  version "0.9.4"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/geoffjay/nemo/releases/download/v#{version}/nemo-aarch64-apple-darwin.tar.gz"
      sha256 "def1a6ef96ab54738da6bd5ceff1519e92453227960ad97107500ff31b67627f"
    end
    on_intel do
      url "https://github.com/geoffjay/nemo/releases/download/v#{version}/nemo-x86_64-apple-darwin.tar.gz"
      sha256 "38cdc4ce23090e31edb4a434eef0b5f8ce6ec86d77e53c11a5518257160e7635"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/geoffjay/nemo/releases/download/v#{version}/nemo-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "78d6079fe162cd0ca0cf3521818cf767e8e1dace2875f476b824500d3ffcd9ab"
    end
    on_intel do
      url "https://github.com/geoffjay/nemo/releases/download/v#{version}/nemo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8e10ccb67ed8dc646896719bbc9bc3d59540a8c8842949cab13974aa551e5e4f"
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
