# Agent instructions — fund-os-ui

Read [`Fund-os-ui.md`](https://github.com/fund-os/fund-os-ui/blob/main/Fund-os-ui.md) and the workspace `FUND-OS.md` before changing this app.

The browser talks **only** to `/v1` (proxied locally to fund-os-ui-router). Do not store access tokens in `sessionStorage`. Use `withCredentials` and Angular XSRF. Bind tenant via `POST /tenants/select` when `mockAuth` is false. Components must not call `HttpClient` directly — use `ApiClientService` and `api-endpoints.ts`.

Container contract (EKS): `env-application.properties`, `entrypoint.sh`, `Dockerfile` at repo root; runtime config via `env.js`. See [`rules/fund-os-project-template.mdc`](../rules/fund-os-project-template.mdc).
