# Agent instructions — fund-os-deployments

Read [`README.md`](https://github.com/fund-os/fund-os-deployments/blob/main/README.md) before changing environment config or workflows.

## Role

Per-instance Helm/env config and **dispatch workflows** (`d1-deploy`, create-release) that call `fund-os-ci-cd` reusable workflows.

## Instance layout

```
environments/<tier>/<instance>/
├── cluster.yaml      # From env-control-panel create/start (manual copy)
├── instance.yaml     # env_prefix, gateway.* flags
├── env-values.yml    # Service config + helm (avoid hardcoded gateway DNS if host_from_cluster)
├── release-patch.yml
└── README.md
```

## Laptop instance (`dev/local`)

[`environments/dev/local`](https://github.com/fund-os/fund-os-deployments/blob/main/environments/dev/local) is Rancher Desktop (`fundoslocal`), not EKS. Lifecycle and Loop C image build are in `fund-os-local-env`. Do not run `d1-deploy` against that namespace. `gateway.sync_after_deploy` is false.

## cluster.yaml

Source of truth for EKS `cluster_name`, `aws_region`, `kubernetes_namespace`, and `infrastructure.*` (VPC, `gateway_alb_dns`, target groups, node SG). Refreshed after Control Environment create/start — **commit manually** to this repo.

Public URL: `infrastructure.gateway_alb_dns` (not the kubectl Ingress hostname).

## instance.yaml gateway block

```yaml
gateway:
  host_from_cluster: true       # deploy injects ingressHost / UI_ORIGIN
  sync_after_deploy: true       # run sync_gateway_alb after Helm
  listener_managed_by: terraform
```

## Workflows

Pin `fund-os-ci-cd` at a semver tag in `d1-Deploy.yml` (`uses:` and `engine_ref` must match). GitHub Environment per instance (e.g. `dev-d1`) holds `AWS_ROLE_ARN` and `RELEASE_TAG_TOKEN`.
