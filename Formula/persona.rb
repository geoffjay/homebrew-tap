# typed: false
# frozen_string_literal: true

# CLI-only installation. For the GUI app, use: brew install --cask geoffjay/tap/persona
class Persona < Formula
  desc 'A framework for stateful AI-assisted conversations with persistent memory'
  homepage 'https://github.com/geoffjay/persona'
  version '0.2.0'
  license 'MIT'

  on_macos do
    if Hardware::CPU.arm?
      url 'https://github.com/geoffjay/persona/releases/download/v0.2.0/persona-aarch64-apple-darwin.tar.gz'
      sha256 '779742094300548a772a994ac4396631bc08b7f60b280974364f63164760836e'
    elsif Hardware::CPU.intel?
      url 'https://github.com/geoffjay/persona/releases/download/v0.2.0/persona-x86_64-apple-darwin.tar.gz'
      sha256 'ed838df6223b82d73e97a3ea45d7b23c749725c22915a9969bdf22ccea7883ed'
    end
  end

  depends_on :macos

  def install
    bin.install 'persona'

    # Install data files (personas and .opencode config) to share
    pkgshare.install Dir['share/persona/*']
  end

  def caveats
    <<~EOS
      Persona data files have been installed to:
        #{pkgshare}

      On first run, the application will copy these to:
        ~/Library/Application Support/persona/

      To manually initialize the data directory, you can run:
        mkdir -p ~/Library/Application\\ Support/persona
        cp -r #{pkgshare}/* ~/Library/Application\\ Support/persona/
    EOS
  end

  test do
    assert_predicate bin / 'persona', :exist?
    assert_predicate pkgshare / 'personas', :exist?
    assert_predicate pkgshare / '.opencode' / 'opencode.jsonc', :exist?
  end
end
