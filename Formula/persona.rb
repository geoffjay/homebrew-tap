# typed: false
# frozen_string_literal: true

class Persona < Formula
  desc 'A framework for stateful AI-assisted conversations with persistent memory'
  homepage 'https://github.com/geoffjay/persona'
  version '0.1.0'
  license 'MIT'

  on_macos do
    if Hardware::CPU.arm?
      url 'https://github.com/geoffjay/persona/releases/download/v0.1.0/persona-aarch64-apple-darwin.tar.gz'
      sha256 '29c196d2ce623ac90a204c94a64e63aadcd38ae9d1bdf5e49dace713a0f868b6'
    elsif Hardware::CPU.intel?
      url 'https://github.com/geoffjay/persona/releases/download/v0.1.0/persona-x86_64-apple-darwin.tar.gz'
      sha256 '24fca2f8ceb55f36ea71fd5109ae81ee046abf91006b7ddedf5f918fc0f9a8fa'
    end
  end

  depends_on :macos

  def install
    bin.install 'persona'
  end

  test do
    assert_predicate bin/'persona', :exist?
  end
end
