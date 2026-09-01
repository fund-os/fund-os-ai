# Agent instructions — fund-os-env-control-panel

Read the repo [`README.md`](https://github.com/fund-os/fund-os-env-control-panel/blob/main/README.md) and [`docs/aws-setup.md`](https://github.com/fund-os/fund-os-env-control-panel/blob/main/docs/aws-setup.md) before changing this service.

## Role

Standalone **cluster Create / Start / Stop / Destroy** via Terraform and GitHub Actions (`Control Environment` workflow). Does **not** call `fund-os-ci-cd` for lifecycle.

## Gateway ALB (Terraform)

Each EKS stack provisions:

- Public gateway ALB (`fund-os-<tier>-<name>-gw`)
- Target groups `fund-os-<name>-gw-ui` (80) and `fund-os-<name>-gw-router` (8080, health 8081)
- Listener: default → UI TG; rule `/v1*` → router TG
- Node SG ingress: gateway ALB SG → pods TCP 80–8081

Pod targets are **empty** until post-deploy sync in `fund-os-ci-cd` (`sync_gateway_alb.py`).

## cluster.yaml export

After **create** or **start**, the workflow exports `cluster.yaml` (artifact + stack summary in logs). Operators **manually copy** it to `fund-os-deployments/environments/<tier>/<name>/cluster.yaml`. There is no auto-push to deployments.

`export-cluster-yaml.sh` includes `gateway_alb_dns`, target group names, `node_security_group_id`, `ingress_group`, and `gateway_listener_managed_by: terraform`.

## Secrets (GitHub Environment per tier)

`AWS_ROLE_ARN`, `TF_STATE_BUCKET`, `TF_LOCK_TABLE` only — no AWS access keys, no deployments PAT.

## Container / app contract

This repo is Terraform + scripts only. New **Java/Angular** services follow [`rules/fund-os-project-template.mdc`](../rules/fund-os-project-template.mdc) in their own repos.
