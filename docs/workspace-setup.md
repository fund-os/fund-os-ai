# Workspace setup

## 1. Clone layout

```
fund-os/                      # workspace root (not a git repo)
├── fund-os.code-workspace
├── FUND-OS.md
├── fund-os-ai/               # this repo
├── fund-os-ui/
├── fund-os-ui-router/
├── fund-os-ci-cd/
├── fund-os-deployments/
├── fund-os-env-control-panel/
└── fund-os-local-env/
```

## 2. Link Cursor rules

From the workspace root:

```bash
./fund-os-ai/scripts/link-workspace.sh .
```

This creates symlinks in `.cursor/rules/` pointing at `fund-os-ai/rules/*.mdc`.

Re-run after `git pull` in `fund-os-ai` if rules were added or renamed.

## 3. Open in Cursor

Open `fund-os.code-workspace` (or add folders individually). Include the `fund-os-ai` folder so rules and agent docs are editable in one session.

## 4. Per-repo AGENTS.md

Service repos keep a short `AGENTS.md` that points to the canonical copy under `fund-os-ai/agents/`. Update the canonical file first, then adjust the stub if needed.
