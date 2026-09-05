---
name: local-env-build
description: >-
  Build and Helm-install Fund OS catalog services into the laptop Rancher
  Desktop namespace fundoslocal (Loop C). Use when the user wants a local
  cluster deploy, docker/nerdctl image build, deploy-apps.sh, Traefik /
  fundos.local, or parity with AWS Helm without ECR.
---

# Local env image build (Loop C)

Read workspace `FUND-OS.md` and [`fund-os-local-env/README.md`](https://github.com/fund-os/fund-os-local-env/blob/main/README.md). Canonical agent notes: [`agents/fund-os-local-env.md`](../../agents/fund-os-local-env.md).

## When to use this skill

The user wants pods in **`fundoslocal`** that match the production fat JAR / container contract — not `mvn spring-boot:run` / `npm start`.

Host hot-reload (Loop A) and infra-only port-forward (Loop B) are **not** this skill.

## Preconditions

From `fund-os-local-env`:

```bash
./scripts/preflight.sh
./scripts/bootstrap.sh
./scripts/install-infra.sh
```

`kubectl` context must be `rancher-desktop`. Abort if the cluster is EKS.

Helm values: sibling `fund-os-deployments/environments/dev/local/`. Chart + renderer: sibling `fund-os-ci-cd`.

## Build and deploy

```bash
cd /path/to/fund-os/fund-os-local-env
./scripts/deploy-apps.sh
./scripts/deploy-apps.sh --service fund-os-ui-router
./scripts/deploy-apps.sh --release-tag <git-tag>
```

Default builds sibling folders **as they sit on disk** (dirty tree included). `--release-tag` clones that tag into a temp dir.

Prefer Rancher **dockerd** so images are visible to k8s. After deploy: `http://fundos.local/` (`127.0.0.1 fundos.local`).

```bash
./scripts/status.sh
```

## Do not

- Run GitHub `d1-deploy` or `aws eks update-kubeconfig`
- Push images to ECR
- Install into namespace `fundosd1`
- Add `fund-os-local-env` to `deployable-services.txt`
- Tell the user that `./mvnw package` refreshed the Helm pod
