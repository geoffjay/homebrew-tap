# typed: false
# frozen_string_literal: true

class Berry < Formula
  desc "Memory storage system for AI tooling with MCP support"
  homepage "https://github.com/geoffjay/berry"
  url "https://registry.npmjs.org/@hlfbkd/berry/-/berry-1.9.0.tgz"
  sha256 "ef5dfa22643bdc8e1f41f34022579d716089266c390527a06bc845f736b7a829"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args

    # Create a wrapper script that loads environment variables before starting the server
    (libexec / "bin/berry-server").write <<~SH
      #!/bin/bash
      set -e

      # Load environment variables from config file if it exists
      ENV_FILE="#{etc}/berry/server.env"
      if [ -f "$ENV_FILE" ]; then
        set -a
        source "$ENV_FILE"
        set +a
      fi

      exec "#{opt_libexec}/bin/berry" serve --foreground --port "${PORT:-4114}"
    SH
    (libexec / "bin/berry-server").chmod 0755

    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  def post_install
    # Create log and state directories
    (var / "log/berry").mkpath
    (var / "berry").mkpath

    # Create server environment config directory and default env file
    (etc / "berry").mkpath
    env_file = etc / "berry/server.env"
    unless env_file.exist?
      env_file.write <<~ENV
        # Berry server environment configuration
        # Uncomment and configure for your ChromaDB setup

        # Server port (default: 4114)
        PORT=4114

        # Local ChromaDB (default)
        CHROMA_PROVIDER=local
        CHROMA_URL=http://localhost:8000

        # Cloud ChromaDB (uncomment and configure to use instead of local)
        # CHROMA_PROVIDER=cloud
        # CHROMA_API_KEY=your-api-key
        # CHROMA_TENANT=your-tenant
        # CHROMA_DATABASE=your-database
      ENV
    end

    # Create user CLI config directory and default config if it doesn't exist
    config_dir = Pathname.new(Dir.home) / ".config/berry"
    config_dir.mkpath

    config_file = config_dir / "config.jsonc"
    return if config_file.exist?

    config_file.write <<~JSON
      {
        "server": {
          "url": "http://localhost:4114",
          "timeout": 5000
        },
        "defaults": {
          "type": "information",
          "createdBy": "#{ENV["USER"]}"
        }
      }
    JSON
  end

  service do
    run [opt_bin / "berry-server"]
    keep_alive true
    working_dir var / "berry"
    log_path var / "log/berry/server.log"
    error_log_path var / "log/berry/server.error.log"
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
