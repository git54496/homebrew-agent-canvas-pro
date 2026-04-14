class AgentCanvas < Formula
  desc "Excalidraw canvas CLI for AI agents"
  homepage "https://github.com/git54496/agent-canvas"
  url "https://github.com/git54496/agent-canvas/releases/download/v0.13.0/agent-canvas-0.13.0-homebrew.tar.gz"
  version "0.13.0"
  sha256 "ec13ac047bd1f6b03bfc8848c405db1002d7ec16c8c0ea3e26f0d72cfeff0fce"
  license "MIT"
  head "https://github.com/git54496/agent-canvas.git", branch: "main"

  depends_on "node"

  def install
    libexec.install Dir["*"]

    (bin/"agent-canvas").write_env_script(
      libexec/"bin/agent-canvas.js",
      PATH => "#{Formula["node"].opt_bin}:#{ENV["PATH"]}"
    )
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/agent-canvas --version").strip
  end
end
