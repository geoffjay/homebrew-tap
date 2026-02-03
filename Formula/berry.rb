# typed: false
# frozen_string_literal: true

class Berry < Formula
  desc 'Memory storage system for AI tooling with MCP support'
  homepage 'https://github.com/geoffjay/berry-rs'
  version '0.1.0'
  license 'MIT'

  on_macos do
    on_arm do
      url 'https://github.com/geoffjay/berry-rs/releases/download/v0.1.0/berry-darwin-arm64.tar.gz'
      sha256 '05163ae4586becba16db68125c8edc83b6d33d8268e32f23a8c645a8dc0b58c2'
    end

    on_intel do
      url 'https://github.com/geoffjay/berry-rs/releases/download/v0.1.0/berry-darwin-amd64.tar.gz'
      sha256 '5ca64977aacf0bed7eb07c75cdc5add36b682924c75c510b3361b3f40a5ced62'
    end
  end

  on_linux do
    on_arm do
      url 'https://github.com/geoffjay/berry-rs/releases/download/v0.1.0/berry-linux-arm64.tar.gz'
      sha256 'bb974f70e0afba6f9e0581dde783a6e71cf96e696b69810a04ed260cef6d0f91'
    end

    on_intel do
      url 'https://github.com/geoffjay/berry-rs/releases/download/v0.1.0/berry-linux-amd64.tar.gz'
      sha256 '438ffe490f2d57c12e7679dd98c846884c29957806f70892ef1b5cc2f25bea19'
    end
  end

  def install
    bin.install 'berry'

    # Create a wrapper script that loads environment variables before starting the server
    (libexec / 'berry-server').write <<~SH
      #!/bin/bash
      set -e

      # Load environment variables from config file if it exists
      ENV_FILE="#{etc}/berry/server.env"
      if [ -f "$ENV_FILE" ]; then
        set -a
        source "$ENV_FILE"
        set +a
      fi

      exec "#{opt_bin}/berry" serve --port "${PORT:-4114}"
    SH
    (libexec / 'berry-server').chmod 0o755

    bin.install_symlink libexec / 'berry-server'
  end

  def post_install
    # Create log and state directories
    (var / 'log/berry').mkpath
    (var / 'berry').mkpath

    # Create server environment config directory and default env file
    (etc / 'berry').mkpath
    env_file = etc / 'berry/server.env'
    unless env_file.exist?
      env_file.write <<~ENV
        # Berry server environment configuration
        # Uncomment and configure for your ChromaDB setup

        # Berry server log level (default: info)
        BERRY_LOG=info

        # Server port (default: 4114)
        PORT=4114

        # Local ChromaDB (default)
        CHROMA_PROVIDER=local
        CHROMA_URL=http://localhost:8000

        # Cloud ChromaDB (uncomment and configure to use instead of local)
        # CHROMA_PROVIDER=cloud
        # CHROMA_URL=https://api.trychroma.com
        # CHROMA_API_KEY=your-api-key
        # CHROMA_TENANT=your-tenant
        # CHROMA_DATABASE=berry # or your preferred database name
        # CHROMA_COLLECTION=memories # or your preferred collection name

        # Embedding configuration (using local Ollama)
        EMBEDDING_PROVIDER=openai
        EMBEDDING_MODEL=all-minilm
        EMBEDDING_BASE_URL=http://localhost:11434/v1
      ENV
    end

    # Create user CLI config directory and default config if it doesn't exist
    config_dir = Pathname.new(Dir.home) / '.config/berry'
    config_dir.mkpath

    config_file = config_dir / 'config.jsonc'
    return if config_file.exist?

    config_file.write <<~JSON
      {
        "server": {
          "url": "http://localhost:4114",
          "timeout": 5000
        },
        "defaults": {
          "type": "information",
          "createdBy": "#{ENV['USER']}"
        }
      }
    JSON
  end

  service do
    run [opt_bin / 'berry-server']
    keep_alive true
    working_dir var / 'berry'
    log_path var / 'log/berry/server.log'
    error_log_path var / 'log/berry/server.error.log'
  end

  def caveats
    <<~EOS
      Berry has been installed!

      To start the berry server as a background service:
        brew services start #{full_name}

      Before starting, you need ChromaDB running. The easiest way:
        docker run -d -p 8000:8000 chromadb/chroma

      For cloud ChromaDB, edit the server environment file:
        #{etc}/berry/server.env

      Then restart the service:
        brew services restart #{full_name}

      Files:
        Server config: #{etc}/berry/server.env
        CLI config:    ~/.config/berry/config.jsonc
        Logs:          #{var}/log/berry/

      Verify the server is running:
        curl http://localhost:4114/health
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/berry --version")
  end
end
