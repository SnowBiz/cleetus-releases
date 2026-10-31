# Memory and rules

_Read this guide on [cleetus.dev](https://cleetus.dev/docs/memory/)._

Your agents read instruction files: `CLAUDE.md`, `AGENTS.md`, rules folders and memory files. **Memory & Rules** finds them, shows where each one applies, and lets you edit them safely, without overwriting a change made somewhere else.

Open it from the **Workspace** menu, with **Cleetus: Open Memory & Rules**, or with `/memory` in a conversation.

## What it finds

The catalog looks in bounded, known locations. It never scans your whole home directory:

| Scope                 | Files                                                            |
| --------------------- | ---------------------------------------------------------------- |
| You                   | Your user `CLAUDE.md` and user rules                             |
| Project and ancestors | `CLAUDE.md`, `CLAUDE.local.md`, `.claude/CLAUDE.md`, `AGENTS.md` |
| Project rules         | `.claude/rules/*.md`                                             |
| Memory                | Conventional project auto-memory directories                     |
| Codex                 | Each Codex backend's `AGENTS.md` and memory files                |
| Managed               | Supported managed instruction directories, read-only             |

**Refresh from Claude** asks a running conversation for its own memory catalog, which covers runtime-specific locations in the active profile and project. "Reported by Claude" means the file is in Claude's catalog, not that every line is in the current prompt: scope, imports, working directory, native limits and on-demand loading decide what actually applies.

Your Cleetus profile starts independently. It doesn't silently import an existing `~/.claude` directory.

## Edit safely

Choose a file and pick a mode:

- **Visual** edits headings and section bodies, and adds or reorders sections. Untouched Markdown, YAML frontmatter, fenced code, Unicode and `@imports` survive byte for byte.
- **Preview** shows the formatted Markdown.
- **Source** edits the full text.

Saving is explicit. If the file changed on disk since you opened it, you get a **save conflict** instead of overwriting the newer content. Managed files are read-only, symlink and hardlink edits are rejected, and files over 1 MB open in the editor instead. Reload a conversation if Claude needs to pick up the change.

## Create instructions

**New instructions** creates one of:

- a user `CLAUDE.md` in your profile,
- a project `CLAUDE.md`,
- a named `.claude/rules/<name>.md`,
- a Codex backend's `AGENTS.md`.

Existing files are never overwritten. The project selector decides where new files go.

## Writing rules agents follow

- **Put build and test commands in the project file** so every member of a team runs the same checks.
- **Keep role guidance in team member instructions**, and shared truths in project files.
- **Use `.claude/rules/` for focused topics**, such as API conventions or migrations, so they load where relevant.
- **Remember that issue text and peer messages are evidence, not instructions.** Cleetus never promotes them into your rules.

[Agent teams](TEAMS.md) · [Tools, MCP and approvals](TOOLS.md)
