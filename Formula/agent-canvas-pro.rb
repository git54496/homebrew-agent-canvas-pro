class AgentCanvasPro < Formula
  desc "Excalidraw canvas CLI for AI agents"
  homepage "https://github.com/git54496/agent-canvas-pro"
  url "https://raw.githubusercontent.com/git54496/homebrew-agent-canvas-pro/main/dist/agent-canvas-pro-0.13.0-homebrew.tar.gz"
  version "0.13.0"
  sha256 "334f275244139a9424bc3b5e979e16c51a39e2b18a104860cfef6bc67044f296"
  license "MIT"
  head "https://github.com/git54496/agent-canvas-pro.git", branch: "main"

  depends_on "node"

  def install
    libexec.install Dir["*"]
    chmod 0555, libexec/"bin/canvas.js"

    (bin/"canvas").write_env_script(
      libexec/"bin/canvas.js",
      PATH => "#{Formula["node"].opt_bin}:#{ENV["PATH"]}"
    )
  end

  def caveats
    <<~EOS
      If `canvas` does not resolve to this Homebrew install, run:
        which -a canvas

      If a Node global install appears first in PATH, remove it:
        npm uninstall -g @agent-canvas/cli
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/canvas --version").strip
  end
end
