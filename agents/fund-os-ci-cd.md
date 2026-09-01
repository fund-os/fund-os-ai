# Agent instructions — fund-os-ci-cd

Read [`README.md`](https://github.com/fund-os/fund-os-ci-cd/blob/main/README.md) and [`docs/aws-oidc.md`](https://github.com/fund-os/fund-os-ci-cd/blob/main/docs/aws-oidc.md) before changing workflows or scripts.

## Role

Reusable **create-release** and **deploy-release** workflows. Called from `fund-os-deployments` (not from env-control-panel).

Pin callers at a **semver tag** (e.g. `v0.1.11`); bump tag when workflow or script behaviour changes.

## deploy-release

1. Checks out `fund-os-deployments` for `env-values.yml`, `instance.yaml`, `cluster.yaml`
2. Builds/pushes ECR images, `helm upgrade` per catalog service
3. **`render_helm_values.py`**: with `instance.yaml` `gateway.host_from_cluster: true`, sets `ingressHost` / `UI_ORIGIN` from `cluster.yaml` `gateway_alb_dns`
4. **`sync_gateway_alb.py`**: copies Ingress pod IPs to Terraform gateway target groups; reads names from `cluster.yaml`; skips listener changes when `gateway.listener_managed_by: terraform` or `gateway_listener_managed_by: terraform` in cluster

## Scripts

| Script | Purpose |
|--------|---------|
| `read_cluster_config.py` | EKS cluster name, region, namespace from `cluster.yaml` |
| `read_gateway_config.py` | Gateway flags from `cluster.yaml` + `instance.yaml` |
| `render_helm_values.py` | Service block → Helm values |
| `sync_gateway_alb.py` | Post-Helm gateway target sync |

## Secrets

Deploy callers need `AWS_ROLE_ARN` and `RELEASE_TAG_TOKEN` (private repo clone + ECR).
