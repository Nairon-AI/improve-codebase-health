#!/usr/bin/env bash
set -euo pipefail

platform="${1:-agents}"
scope="${2:-global}"

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

usage() {
  cat <<'USAGE'
Usage: ./scripts/install.sh <platform> [--project]

platform:
  agents   ~/.agents/skills or .agents/skills
  codex    ~/.codex/skills or .agents/skills
  claude   ~/.claude/skills or .claude/skills
  cursor   ~/.cursor/skills or .agents/skills

Examples:
  ./scripts/install.sh agents
  ./scripts/install.sh claude --project
USAGE
}

if [[ "${platform}" == "-h" || "${platform}" == "--help" ]]; then
  usage
  exit 0
fi

case "${platform}" in
  agents)
    if [[ "${scope}" == "--project" ]]; then target=".agents/skills"; else target="${HOME}/.agents/skills"; fi
    ;;
  codex)
    if [[ "${scope}" == "--project" ]]; then target=".agents/skills"; else target="${HOME}/.codex/skills"; fi
    ;;
  claude)
    if [[ "${scope}" == "--project" ]]; then target=".claude/skills"; else target="${HOME}/.claude/skills"; fi
    ;;
  cursor)
    if [[ "${scope}" == "--project" ]]; then target=".agents/skills"; else target="${HOME}/.cursor/skills"; fi
    ;;
  *)
    echo "Unknown platform: ${platform}" >&2
    usage
    exit 1
    ;;
esac

mkdir -p "${target}"
rm -rf "${target}/improve-codebase-health"
cp -R "${repo_root}/skills/improve-codebase-health" "${target}/improve-codebase-health"

echo "Installed improve-codebase-health to ${target}/improve-codebase-health"
