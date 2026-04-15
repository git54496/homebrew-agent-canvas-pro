class AgentCanvas < Formula
  desc "Excalidraw canvas CLI for AI agents"
  homepage "https://github.com/git54496/agent-canvas-pro"
  url "https://raw.githubusercontent.com/git54496/homebrew-agent-canvas-pro/main/dist/agent-canvas-0.13.0-homebrew.tar.gz"
  version "0.13.0"
  sha256 "ec13ac047bd1f6b03bfc8848c405db1002d7ec16c8c0ea3e26f0d72cfeff0fce"
  license "MIT"
  head "https://github.com/git54496/agent-canvas-pro.git", branch: "main"

  depends_on "node"

  def install
    libexec.install Dir["*"]

    (bin/"agent-canvas").write_env_script(
      libexec/"bin/agent-canvas.js",
      PATH => "#{Formula["node"].opt_bin}:#{ENV["PATH"]}"
    )
  end

  def caveats
    <<~EOS
      If `agent-canvas` does not resolve to this Homebrew install, run:
        which -a agent-canvas

      If a Node global install appears first in PATH, remove it:
        npm uninstall -g @agent-canvas/cli
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/agent-canvas --version").strip
  end
end
