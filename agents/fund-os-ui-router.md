# Agent instructions — fund-os-ui-router

Read [`Fund-os-ui-router.md`](https://github.com/fund-os/fund-os-ui-router/blob/main/Fund-os-ui-router.md) and the workspace `FUND-OS.md` before changing this service.

This is a **BFF**, not an API gateway proxy. Public JSON is `/v1/**`. Downstream targets are only `user-management` and `common-data` from config. Cookies are HttpOnly; never return `accessToken` in JSON.

Container contract (EKS): multi-stage `Dockerfile`, `env-application.properties`, `entrypoint.sh`. See [`rules/fund-os-project-template.mdc`](../rules/fund-os-project-template.mdc).
