#!/bin/sh
# Usage: ./install.sh [claude|codex|antigravity|all]   (default: all targets whose root dir exists)
target="${1:-all}"
here="$(cd "$(dirname "$0")" && pwd)"
tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT

dsts=""
for pair in "claude:$HOME/.claude/skills" "codex:$HOME/.codex/skills" \
            "antigravity:$HOME/.gemini/antigravity/skills"; do  # antigravity path unverified
  name="${pair%%:*}"; dst="${pair#*:}"
  if [ "$target" = "$name" ] || { [ "$target" = all ] && [ -d "$(dirname "$dst")" ]; }; then
    dsts="$dsts $dst"
  fi
done

grep -v '^[[:space:]]*\(#\|$\)' "$here/skills.txt" | while read -r repo path; do
  dir="$tmp/$(echo "$repo" | tr / _)"
  [ "$path" != . ] || dir="$tmp/${repo##*/}"
  [ -d "$dir" ] || git clone -q --depth 1 "https://github.com/$repo" "$dir"
  skill_path="$dir/$path"
  [ "$path" != . ] || skill_path="$dir"
  for d in $dsts; do
    mkdir -p "$d"
    for s in "$skill_path" "$skill_path"/*/; do
      if [ -f "$s/SKILL.md" ] || [ -f "$s/skill.md" ]; then
        cp -R "$s" "$d/" || exit 1
        installed="$d/$(basename "$s")"
        [ -f "$installed/SKILL.md" ] || cp "$s/skill.md" "$installed/SKILL.md" || exit 1
        echo "$(basename "$s") -> $d"
      fi
    done
  done
done

