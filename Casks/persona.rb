# typed: false
# frozen_string_literal: true

cask 'persona' do
  version '0.2.0'

  on_arm do
    url "https://github.com/geoffjay/persona/releases/download/v#{version}/Persona-aarch64-apple-darwin.zip"
    sha256 '8d4f7a2158969a935de9dc5ea2e84f3af9af936b78d8bbf9e4d09b97f7bce2ee'
  end

  on_intel do
    url "https://github.com/geoffjay/persona/releases/download/v#{version}/Persona-x86_64-apple-darwin.zip"
    sha256 '3c03304409a060b4c681b9e35450911f6b8a6c23d55e38d51f51fab4d677007f'
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
