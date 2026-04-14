# homebrew-agent-canvas

Homebrew tap for installing the `agent-canvas` CLI from `git54496/agent-canvas`.

## Usage

```bash
brew tap git54496/agent-canvas
brew install agent-canvas
```

Upgrade after a new formula version is published:

```bash
brew update
brew upgrade agent-canvas
```

## Release Flow

1. In `git54496/agent-canvas`, bump the CLI version and push a tag such as `v0.13.0`.
2. Build/package in source repo to get `release/agent-canvas-0.13.0-homebrew.tar.gz`.
3. In this tap repo, run:

   ```bash
   ./scripts/update_agent_canvas_formula.sh 0.13.0
   ```

4. Commit and push the updated formula and `dist/` archive.

## Notes

- Formula file: `Formula/agent-canvas.rb`
- Formula update helper: `scripts/update_agent_canvas_formula.sh`
- Source repository: `https://github.com/git54496/agent-canvas`
