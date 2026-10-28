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
| superpowers (planning, debugging, TDD, code review and collaboration workflows) | https://github.com/obra/superpowers |
| graphify (also needs the `graphifyy` Python CLI) | https://github.com/Graphify-Labs/graphify |
| context7-cli (current library documentation; also needs the `ctx7` CLI) | https://github.com/upstash/context7 |
| humanizer (rewrite AI-sounding prose) | https://github.com/blader/humanizer |
| planning-with-files (persistent task plans, findings and progress) | https://github.com/OthmanAdi/planning-with-files |

For Graphify, install its CLI separately with `uv tool install graphifyy` (or `pipx install graphifyy`).
For Context7, install its CLI separately with `npm install -g ctx7` (requires Node.js 22.13+).
The shell installer also accepts upstream `skill.md` files and creates `SKILL.md` for agent discovery.

Add a skill: append a `repo path` line to `skills.txt` (path may be a parent dir holding many skills).

