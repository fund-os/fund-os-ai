# Agent instructions — Fund OS workspace

Before changing code, read `FUND-OS.md` in the workspace root (parent folder of service repos when using the multi-repo layout). It is the source of truth for architecture, tenancy, security, and what is stubbed vs implemented.

Then open the repo-specific doc for the area you are editing:

- UI: `fund-os-ui/Fund-os-ui.md` and [`agents/fund-os-ui.md`](agents/fund-os-ui.md)
- BFF: `fund-os-ui-router/Fund-os-ui-router.md` and [`agents/fund-os-ui-router.md`](agents/fund-os-ui-router.md)
- Cluster lifecycle: [`agents/fund-os-env-control-panel.md`](agents/fund-os-env-control-panel.md)
- Deploy engine: [`agents/fund-os-ci-cd.md`](agents/fund-os-ci-cd.md)
- Environment config / deploy workflows: [`agents/fund-os-deployments.md`](agents/fund-os-deployments.md)

Cursor rules for this org live in [`rules/`](rules/). Link them with [`scripts/link-workspace.sh`](scripts/link-workspace.sh).

The parent `fund-os` folder is **not** a git repository. Commit and push inside the child repo you changed (`fund-os-ui`, `fund-os-ui-router`, `fund-os-ci-cd`, `fund-os-deployments`, `fund-os-env-control-panel`, `fund-os-ai`).

Do not introduce a catch-all HTTP proxy on the UI-router. Do not put JWTs in browser `sessionStorage`. Do not omit `X-Tenant-Name` on downstream calls once a tenant is bound.
