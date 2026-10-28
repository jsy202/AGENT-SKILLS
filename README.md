# agent-skills

Skill repo shared by Claude Code, Codex and Antigravity. Each skill is `skills/<name>/SKILL.md`.

## Install

    git clone https://github.com/jsy202/agent-skills && cd agent-skills
    ./install.sh            # or: .\install.ps1   (Windows)
    ./install.sh claude     # one target: claude | codex | antigravity

Copies every skill into `~/.claude/skills`, `~/.codex/skills`, `~/.gemini/antigravity/skills`
(`all` only touches agents whose home dir already exists).

## Skills

- `ppt-master` - editable PPTX deck generation
- `reverse-engineer-anything` - reverse engineering with the `rea` MCP server

Not included: plugin-managed skills (`ui-ux-pro-max`, `ponytail`) - install them from their own marketplaces.
