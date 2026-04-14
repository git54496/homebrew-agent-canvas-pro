#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "usage: $0 <version>" >&2
  echo "example: $0 0.13.0" >&2
  exit 1
fi

VERSION="${1#v}"
TAG="v${VERSION}"
REPO="git54496/agent-canvas"
URL="https://github.com/${REPO}/releases/download/${TAG}/agent-canvas-${VERSION}-homebrew.tar.gz"
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
FORMULA_PATH="${ROOT_DIR}/Formula/agent-canvas.rb"
TMP_ARCHIVE="$(mktemp "${TMPDIR:-/tmp}/agent-canvas-${VERSION}.XXXXXX.tar.gz")"
trap 'rm -f "${TMP_ARCHIVE}"' EXIT

curl -fL "${URL}" -o "${TMP_ARCHIVE}"
SHA256="$(shasum -a 256 "${TMP_ARCHIVE}" | awk '{print $1}')"

cat > "${FORMULA_PATH}" <<EOF
class AgentCanvas < Formula
  desc "Excalidraw canvas CLI for AI agents"
  homepage "https://github.com/${REPO}"
  url "${URL}"
  version "${VERSION}"
  sha256 "${SHA256}"
  license "MIT"
  head "https://github.com/${REPO}.git", branch: "main"

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
EOF

echo "Updated ${FORMULA_PATH}"
echo "version=${VERSION}"
echo "sha256=${SHA256}"
