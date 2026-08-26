#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AI_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
WORKSPACE_ROOT="$(cd "${1:-$(cd "${AI_ROOT}/.." && pwd)}" && pwd)"
RULES_SRC="${AI_ROOT}/rules"
RULES_DEST="${WORKSPACE_ROOT}/.cursor/rules"

if [ ! -d "${RULES_SRC}" ]; then
  echo "Rules directory not found: ${RULES_SRC}" >&2
  exit 1
fi

mkdir -p "${RULES_DEST}"

linked=0
for rule in "${RULES_SRC}"/*.mdc; do
  [ -e "${rule}" ] || continue
  name="$(basename "${rule}")"
  ln -sf "${rule}" "${RULES_DEST}/${name}"
  echo "Linked ${RULES_DEST}/${name} -> ${rule}"
  linked=$((linked + 1))
done

if [ "${linked}" -eq 0 ]; then
  echo "No .mdc rules found in ${RULES_SRC}" >&2
  exit 1
fi

echo "Done. ${linked} rule(s) linked into ${RULES_DEST}"
