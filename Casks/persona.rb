# typed: false
# frozen_string_literal: true

cask 'persona' do
  version '0.3.0'

  on_arm do
    url "https://github.com/geoffjay/persona/releases/download/v#{version}/Persona-aarch64-apple-darwin.zip"
    sha256 '6c78ee7ebdd2d070fff194f5162d9cfa5df266ac6b736833260198154c3d1fe3'
  end

  on_intel do
    url "https://github.com/geoffjay/persona/releases/download/v#{version}/Persona-x86_64-apple-darwin.zip"
    sha256 '2f014cea7018460d633f202dfe4cb1143331ac52513b3c3250d54ae89deaf6c1'
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
