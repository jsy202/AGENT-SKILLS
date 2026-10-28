# agent-skills

Registry of skill GitHub repos for Claude Code, Codex and Antigravity. No skill code lives here;
`skills.txt` lists where each one comes from and the installer fetches them.

## Install

    git clone https://github.com/jsy202/agent-skills && cd agent-skills
    ./install.sh            # or: .\install.ps1   (Windows)
    ./install.sh claude     # one target: claude | codex | antigravity

Shallow-clones each repo in `skills.txt` and copies the skill folder into `~/.claude/skills`,
`~/.codex/skills`, `~/.gemini/antigravity/skills` (`all` only touches agents whose home dir exists).
Existing skills of the same name are overwritten. Skills always track the upstream default branch.

## Skills

| Skill | Source |
|---|---|
| ppt-master | https://github.com/hugohe3/ppt-master |
| reverse-engineer-anything (needs the `rea` MCP server) | https://github.com/morluto/rea |
| ponytail, ponytail-audit/-debt/-gain/-help/-review | https://github.com/DietrichGebert/ponytail |
| ui-ux-pro-max, design, design-system, brand, slides, ui-styling, banner-design | https://github.com/nextlevelbuilder/ui-ux-pro-max-skill |

Add a skill: append a `repo path` line to `skills.txt`.
