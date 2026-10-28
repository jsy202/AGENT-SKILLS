# Agent instructions

This repo is only a registry of skill GitHub links (`skills.txt`). Never copy skill code into it.

## When the user asks to add a skill

1. Find the skill's upstream GitHub repo: the link the user gave, else the `official_repository`/repo URL in its
   `SKILL.md`, else the plugin marketplace config (e.g. `~/.claude/plugins/known_marketplaces.json`).
   If you cannot find it, ask the user. Do not guess.
2. Check it exists: `git ls-remote https://github.com/<repo> HEAD`.
3. Shallow-clone it to a temp dir and find the folder holding the skill's `SKILL.md`.
   Use the parent dir if the user wants all skills in it; use the single skill dir if the parent holds
   unrelated skills.
4. Skip it if `skills.txt` already covers that repo and path.
5. Append `<owner>/<repo> <path>` to `skills.txt` and add a row to the README table.
6. Commit and push to `main`.

## External skills only

Add only third-party skills the user installed themselves (plugins, marketplaces, cloned repos).
Never add skills that ship with the agent: Claude Code built-ins and `anthropic-skills:*`, Codex `.system`,
or similar bundled ones. If asked to "add all my skills", list the installed ones, drop built-ins, and add the rest.

## Checks

Do not store secrets, `.env` files or tokens here. The installers (`install.sh`, `install.ps1`) read `skills.txt`
and need no edits when a skill is added.
