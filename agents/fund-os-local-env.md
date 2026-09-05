# Agent instructions — fund-os-local-env

Read the repo [`README.md`](https://github.com/fund-os/fund-os-local-env/blob/main/README.md) and workspace `FUND-OS.md` before changing this service.

## Role

Laptop **Rancher Desktop** control panel. Namespace is always **`fundoslocal`**. It is **not** a catalog microservice: do not add this repo to `fund-os-deployments/deployable-services.txt`.

Helm values live in sibling `fund-os-deployments/environments/dev/local/`. Chart + `render_helm_values.py` come from sibling `fund-os-ci-cd`.

This path never uses AWS, ECR, OIDC, or `d1-deploy`. Do not run `aws eks update-kubeconfig`. Do not Helm-install into `fundosd1`.

## Safety

Scripts abort unless:

- `kubectl` context is `rancher-desktop`
- cluster API is not EKS
- target namespace is `fundoslocal`

Destroy: `CONFIRM=fundoslocal ./scripts/destroy.sh`

## Three loops (pick one)

`./mvnw package` on the host does **not** update a Helm pod.

| Loop | When | How |
|------|------|-----|
| A — host hot | Daily UI/BFF coding | `fund-os-ui-router` `./mvnw spring-boot:run` + `fund-os-ui` `npm start` |
| B — hybrid | Real Postgres/AMQ, apps still hot | `./scripts/bootstrap.sh` → `install-infra.sh` → `port-forward-infra.sh` |
| C — deploy parity | Same Helm path as AWS | `./scripts/deploy-apps.sh` (Docker build + `helm upgrade`) |

Loop C is minutes, not hot reload. Rebuild images after code changes; do not expect JVM/npm hotswap inside the pod.

## Loop C — local image build

`scripts/deploy-apps.sh` builds catalog images from **sibling checkouts on disk** (uncommitted files included) and `helm upgrade`s into `fundoslocal`.

```bash
./scripts/deploy-apps.sh
./scripts/deploy-apps.sh --service fund-os-ui-router
./scripts/deploy-apps.sh --release-tag d1-2026-09-03
```

- Default: build `${FUND_OS_ROOT}/<service>` as it sits on disk.
- `--release-tag`: clone that git tag into a temp directory, then build.
- Images are tagged `local-<sha>-<epoch>`, `imagePullPolicy: Never`.
- Prefer Rancher Desktop **dockerd (Moby)** so `docker build` is visible to Kubernetes. With containerd, the script loads via `nerdctl`.
- Ingress: Traefik, host `fundos.local` (add `127.0.0.1 fundos.local` to `/etc/hosts`).

Do not push these images to ECR. Do not set `gateway.sync_after_deploy` on the local instance.

## Infra

`k8s/postgres.yaml` and `k8s/amq.yaml` install in-cluster Postgres 16 and ActiveMQ Classic. Secrets `db` and `amq` use the same JSON field names as AWS Secrets Manager.

In-cluster DNS: `postgres.fundoslocal.svc.cluster.local:5432`, `amq.fundoslocal.svc.cluster.local:61616`.

## Agent checklist

- [ ] Context is Rancher Desktop, namespace `fundoslocal`
- [ ] Local Helm values, not `environments/dev/d1`
- [ ] `helm.ingressClassName: traefik` (ci-cd skips ALB annotations when class is not `alb`)
- [ ] Tell the operator which loop they are in; do not mix host-hot with expecting Helm pods to refresh
