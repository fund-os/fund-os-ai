# fund-os-ai

Versioned **Cursor agent instructions**, **rules**, and **skills** for the [fund-os](https://github.com/fund-os) organisation.

Platform architecture and runtime behaviour live in each service repo (`FUND-OS.md`, `Fund-os-ui.md`, etc.). This repo is the single source of truth for **how agents should work** across Fund OS.

## Layout

```
fund-os-ai/
├── AGENTS.md                 # Workspace-level agent instructions
├── rules/                    # Cursor rules (.mdc)
├── agents/                   # Per-repo agent instructions
├── skills/                   # Fund OS–specific agent skills (SKILL.md files)
├── docs/workspace-setup.md   # Link rules into a local workspace
└── scripts/link-workspace.sh # Symlink rules into .cursor/rules
```

## Quick setup (local workspace)

Clone as a sibling of your service repos (same parent as `fund-os-ui`, `fund-os-ui-router`, …):

```bash
cd /path/to/fund-os
git clone https://github.com/fund-os/fund-os-ai.git
./fund-os-ai/scripts/link-workspace.sh .
```

That symlinks `fund-os-ai/rules/*.mdc` into `<workspace>/.cursor/rules/`.

Add `fund-os-ai` to your Cursor workspace file if you want the rules editable in the IDE.

## Per-repo agent files

| Service | Canonical file |
|---------|----------------|
| Workspace | [`AGENTS.md`](AGENTS.md) |
| fund-os-ui | [`agents/fund-os-ui.md`](agents/fund-os-ui.md) |
| fund-os-ui-router | [`agents/fund-os-ui-router.md`](agents/fund-os-ui-router.md) |

Service repos may keep a short `AGENTS.md` that points here.

## Contributing

Edit rules and agent docs in this repo. Run `./scripts/link-workspace.sh` after pulling so your local `.cursor/rules` stay in sync.
