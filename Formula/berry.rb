# typed: false
# frozen_string_literal: true

class Berry < Formula
  desc 'A memory storage system for AI tooling with MCP support'
  homepage 'https://github.com/geoffjay/berry'
  url 'https://registry.npmjs.org/@hlfbkd/berry/-/berry-1.9.0.tgz'
  sha256 'ef5dfa22643bdc8e1f41f34022579d716089266c390527a06bc845f736b7a829'
  license 'MIT'

  depends_on 'node'

  def install
    system 'npm', 'install', *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/berry --version")
  end
end
