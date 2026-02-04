# typed: false
# frozen_string_literal: true

# CLI-only installation. For the GUI app, use: brew install --cask geoffjay/tap/persona
class Persona < Formula
  desc 'A framework for stateful AI-assisted conversations with persistent memory'
  homepage 'https://github.com/geoffjay/persona'
  version '0.3.0'
  license 'MIT'

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/geoffjay/persona/releases/download/v#{version}/persona-aarch64-apple-darwin.tar.gz"
      sha256 '1598e3dfd1b0565699cc63c2aa2f2960081ae5ea4a4248d70a39d8ba8b12f911'
    elsif Hardware::CPU.intel?
      url "https://github.com/geoffjay/persona/releases/download/v#{version}/persona-x86_64-apple-darwin.tar.gz"
      sha256 '3063355a38b36b07e0bc8eca90714017135dd25793b27fda95b71cc73009bf38'
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
