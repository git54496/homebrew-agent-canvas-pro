#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "usage: $0 <version> [archive_path]" >&2
  echo "example: $0 0.13.0 /tmp/agent-canvas-0.13.0-homebrew.tar.gz" >&2
  exit 1
fi

VERSION="${1#v}"
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
FORMULA_PATH="${ROOT_DIR}/Formula/agent-canvas.rb"
DIST_DIR="${ROOT_DIR}/dist"
ARCHIVE_NAME="agent-canvas-${VERSION}-homebrew.tar.gz"
ARCHIVE_PATH="${2:-${ROOT_DIR}/../agent-canvas-pro/release/${ARCHIVE_NAME}}"
REPO="git54496/agent-canvas-pro"
TAP_REPO="git54496/homebrew-agent-canvas-pro"
URL="https://raw.githubusercontent.com/${TAP_REPO}/main/dist/${ARCHIVE_NAME}"

if [[ ! -f "${ARCHIVE_PATH}" ]]; then
  echo "archive not found: ${ARCHIVE_PATH}" >&2
  exit 1
fi

mkdir -p "${DIST_DIR}"
cp "${ARCHIVE_PATH}" "${DIST_DIR}/${ARCHIVE_NAME}"
SHA256="$(shasum -a 256 "${DIST_DIR}/${ARCHIVE_NAME}" | awk '{print $1}')"

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

  def caveats
    <<~EOS
      If \`agent-canvas\` does not resolve to this Homebrew install, run:
        which -a agent-canvas

      If a Node global install appears first in PATH, remove it:
        npm uninstall -g @agent-canvas/cli
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/agent-canvas --version").strip
  end
end
EOF

echo "Updated ${FORMULA_PATH}"
echo "archive=${DIST_DIR}/${ARCHIVE_NAME}"
echo "version=${VERSION}"
echo "sha256=${SHA256}"
