# homebrew-agent-canvas-pro

Homebrew tap for installing the `agent-canvas` CLI from `git54496/agent-canvas-pro`.

## Usage

```bash
brew tap git54496/agent-canvas-pro
brew install agent-canvas
agent-canvas doctor
```

Upgrade after a new formula version is published:

```bash
brew update
brew upgrade agent-canvas
```

## Release Flow

1. In `git54496/agent-canvas-pro`, bump CLI version and push a tag such as `v0.13.1`.
2. Source repo workflow `.github/workflows/publish.yml` builds archive and syncs this tap automatically.
3. Users run `brew update && brew upgrade agent-canvas`.

Manual fallback if tap sync is unavailable:

```bash
./scripts/update_agent_canvas_formula.sh 0.13.1
git add Formula/agent-canvas.rb dist/
git commit -m "Update agent-canvas 0.13.1"
git push origin main
```

## Notes

- Formula file: `Formula/agent-canvas.rb`
- Formula update helper: `scripts/update_agent_canvas_formula.sh`
- Source repository: `https://github.com/git54496/agent-canvas-pro`
- `agent-canvas` is also published on npm; if npm global binaries come before Homebrew in PATH, run `which -a agent-canvas` and remove `npm -g` installs as needed.
