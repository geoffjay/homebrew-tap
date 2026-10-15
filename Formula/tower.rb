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
  version "0.2.0"
  license "MIT OR Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/geoffjay/tower/releases/download/v#{version}/tower-aarch64-apple-darwin.tar.gz"
      sha256 "3be1989ff45d5639c084a664f7cbee1902421297a81ab612dcc4b1edfbfa8707"
    end
    on_intel do
      url "https://github.com/geoffjay/tower/releases/download/v#{version}/tower-x86_64-apple-darwin.tar.gz"
      sha256 "5a098170c006c909cab9b8371ba4ca25dd5a85f1ada8df2ab1732b1e31e1c7ba"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/geoffjay/tower/releases/download/v#{version}/tower-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5a2b14998ffbb56b461ebb10e42fbac57921aa28a32eb463d500f0e874ed614d"
    end
    on_intel do
      url "https://github.com/geoffjay/tower/releases/download/v#{version}/tower-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e81fed76993b9ed9fa2fd07e31832038c1593398da6f18cf1b516e726f017821"
    end
  end

  def install
    bin.install "tower"
  end

  test do
    assert_match "tower", shell_output("#{bin}/tower --version")
  end
end
