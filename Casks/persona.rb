# typed: false
# frozen_string_literal: true

cask 'persona' do
  version '0.2.0'

  on_arm do
    url "https://github.com/geoffjay/persona/releases/download/v#{version}/Persona-aarch64-apple-darwin.zip"
    sha256 'PLACEHOLDER_ARM64_SHA256'
  end

  on_intel do
    url "https://github.com/geoffjay/persona/releases/download/v#{version}/Persona-x86_64-apple-darwin.zip"
    sha256 'PLACEHOLDER_X86_64_SHA256'
  end

  name 'Persona'
  desc 'A framework for stateful AI-assisted conversations with persistent memory'
  homepage 'https://github.com/geoffjay/persona'

  app 'Persona.app'
  binary "#{appdir}/Persona.app/Contents/MacOS/persona"

  zap trash: [
    '~/Library/Application Support/persona',
    '~/.config/persona'
  ]
end
