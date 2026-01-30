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
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  def post_install
    # Create log and state directories
    (var/"log/berry").mkpath
    (var/"berry").mkpath

    # Create config directory and default config if it doesn't exist
    config_dir = etc/"berry"
    config_dir.mkpath

    config_file = config_dir/"config.jsonc"
    return if config_file.exist?

    config_file.write <<~JSON
      {
        "server": {
          "url": "http://localhost:4114",
          "timeout": 5000
        },
        "defaults": {
          "type": "information",
          "createdBy": "user"
        }
      }
    JSON
  end

  service do
    run [opt_bin/"berry", "serve", "--foreground", "--port", "4114"]
    keep_alive true
    working_dir var/"berry"
    log_path var/"log/berry/server.log"
    error_log_path var/"log/berry/server.error.log"
    environment_variables CHROMA_PROVIDER: "local", CHROMA_URL: "http://localhost:8000"
  end

  def caveats
    <<~EOS
      Berry has been installed!

      To start the berry server as a background service:
        brew services start #{full_name}

      Before starting, you need ChromaDB running. The easiest way:
        docker run -d -p 8000:8000 chromadb/chroma

      For cloud ChromaDB, create a service override file:
        #{etc}/berry/service.env

      With contents:
        CHROMA_PROVIDER=cloud
        CHROMA_API_KEY=your-api-key
        CHROMA_TENANT=your-tenant
        CHROMA_DATABASE=your-database

      Then restart the service:
        brew services restart #{full_name}

      Configuration: #{etc}/berry/config.jsonc
      Logs:          #{var}/log/berry/

      Verify the server is running:
        curl http://localhost:4114/health
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/berry --version")
  end
end
