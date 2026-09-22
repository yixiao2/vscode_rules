#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: setup-codex-links.sh [--dry-run] [--help]

Link shared Codex customizations into the local Codex home.

Options:
  --dry-run  Print actions without changing files
  --help     Show this help message

Environment:
  CODEX_HOME  Codex config directory, defaults to "$HOME/.codex"
EOF
}

DRY_RUN=0

for arg in "$@"; do
  case "$arg" in
    --dry-run)
      DRY_RUN=1
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      echo "error: unknown option: $arg" >&2
      usage >&2
      exit 2
      ;;
  esac
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CUSTOM_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
AGENTS_ROOT="$CUSTOM_ROOT/agents"
SKILLS_ROOT="$CUSTOM_ROOT/skills"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
CODEX_SKILLS_DIR="$CODEX_HOME/skills"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"

say() {
  printf '%s\n' "$*"
}

run() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    say "dry-run: $*"
  else
    "$@"
  fi
}

ensure_dir() {
  local dir="$1"

  if [[ -d "$dir" ]]; then
    say "ok: directory exists: $dir"
    return
  fi

  say "create: directory: $dir"
  run mkdir -p "$dir"
}

link_target() {
  local source="$1"
  local target="$2"
  local backup
  local current

  if [[ ! -e "$source" ]]; then
    say "skip: source missing: $source"
    return
  fi

  if [[ -L "$target" ]]; then
    current="$(readlink "$target")"
    if [[ "$current" == "$source" ]]; then
      say "ok: link exists: $target -> $source"
      return
    fi

    say "replace: symlink: $target -> $source"
    run rm "$target"
    run ln -s "$source" "$target"
    return
  fi

  if [[ -e "$target" ]]; then
    backup="$target.backup.$TIMESTAMP"
    say "backup: $target -> $backup"
    run mv "$target" "$backup"
  fi

  say "link: $target -> $source"
  run ln -s "$source" "$target"
}

main() {
  local global_agents="$AGENTS_ROOT/global/AGENTS.md"
  local skill_dir
  local skill_name

  ensure_dir "$CODEX_HOME"
  ensure_dir "$CODEX_SKILLS_DIR"

  link_target "$global_agents" "$CODEX_HOME/AGENTS.md"

  if [[ ! -d "$SKILLS_ROOT" ]]; then
    say "skip: skills directory missing: $SKILLS_ROOT"
    return
  fi

  for skill_dir in "$SKILLS_ROOT"/*; do
    [[ -d "$skill_dir" ]] || continue
    [[ -f "$skill_dir/SKILL.md" ]] || continue

    skill_name="$(basename "$skill_dir")"
    link_target "$skill_dir" "$CODEX_SKILLS_DIR/$skill_name"
  done
}

main
