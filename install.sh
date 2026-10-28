#!/bin/sh
# Usage: ./install.sh [claude|codex|antigravity|all]   (default: all targets whose root dir exists)
target="${1:-all}"
src="$(cd "$(dirname "$0")" && pwd)/skills"

for pair in "claude:$HOME/.claude/skills" "codex:$HOME/.codex/skills" \
            "antigravity:$HOME/.gemini/antigravity/skills"; do  # antigravity path unverified
  name="${pair%%:*}"; dst="${pair#*:}"
  [ "$target" = all ] || [ "$target" = "$name" ] || continue
  [ "$target" != all ] || [ -d "$(dirname "$dst")" ] || continue
  mkdir -p "$dst" && cp -R "$src"/. "$dst"/ && echo "installed -> $dst"
done
