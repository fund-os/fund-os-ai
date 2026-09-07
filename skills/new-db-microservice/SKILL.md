---
name: new-db-microservice
description: >-
  Scaffold a new Fund OS database-backed microservice from fund-os-microservice
  (Flyway, hybrid JPA+JDBC, SET ROLE tenancy, internal JWT, catalog + env-values).
---

# New DB microservice

1. `gh repo create fund-os/<name> --template fund-os/fund-os-microservice --private`
2. Clone under `/Users/deepak/Projects/fund-os/<name>`
3. Rename `fund-os-microservice` / `com.fundos.ms` (see template README)
4. Catalog line in `fund-os-deployments/deployable-services.txt`
5. `services.<name>` in `environments/dev/local/env-values.yml` and `dev/d1/env-values.yml` with `helm.ingressEnabled: false`
6. Typed router client — no catch-all proxy
