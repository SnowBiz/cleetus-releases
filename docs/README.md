# How Cleetus works

_Read this guide on [cleetus.dev](https://cleetus.dev/docs/)._

Cleetus is an agentic development environment: a Code - OSS editor with Claude and Codex agents, reviewable tasks and a design studio built in. These guides explain each feature the way you'd want a colleague to: what it does, how it works underneath, and exactly what it will and won't do on your behalf.

**Get Cleetus:** [Cleetus IDE 0.1.0 for macOS Apple Silicon](https://github.com/SnowBiz/cleetus-releases/releases/download/ide-v0.1.0-macos-arm64/cleetus-ide-0.1.0-macos-arm64.dmg) ([release notes and checksums](https://github.com/SnowBiz/cleetus-releases/releases/tag/ide-v0.1.0-macos-arm64)) is a complete editor that replaces VS Code. Staying in VS Code? The [Cleetus VS Code extension 1.11.3](https://github.com/SnowBiz/cleetus-releases/releases/latest) brings the same agents to it. Their versions and updates are independent; start with [installation](INSTALL.md).

![How Cleetus fits together: the IDE host, the core, engines, the local service and your profile](images/diagram-architecture.png)

## The short version

- **Everything runs on your machine.** Cleetus drives the Claude and Codex runtimes you install, signed in with your own accounts. Your profile, transcripts and task records stay in `~/.cleetus/profile`.
- **Agents ask; you decide.** Every edit, command and tool call goes through one permission flow, and team handoffs, imports and automation each have their own explicit approval.
- **Records are evidence, not claims.** Cards show saved state. A completed task, a green check or a "staged" receipt each mean one specific thing, and the guides say exactly what.
- **Nothing replays behind your back.** After a restart, interrupted work is marked interrupted. Cleetus never resends a remote write or restarts an agent turn on its own.

## Feature guides

| Guide                                                   | What you'll learn                                                                          |
| ------------------------------------------------------- | ------------------------------------------------------------------------------------------ |
| [Agent Command and conversations](GUIDE.md) | Give a goal, pick an engine, model and effort, follow a run, resume history                |
| [Agent teams](TEAMS.md)                             | Pipeline, parallel and supervised teams, the nine prebuilt crews, handoff tools and limits |
| [Tasks](TASKS.md)                                   | Acceptance criteria, fenced execution leases, dependencies and your review decision        |
| [Workflows and automation](WORKFLOWS.md)            | Saved DAGs, run journals and approved interval or event triggers                           |
| [Review & Ship](REVIEW.md)                          | Owned worktrees, tracked diffs and safe cleanup                                            |
| [Work tracking and PR evidence](WORK_TRACKING.md)   | GitHub Issues, Jira, custom REST trackers, atomic claims and head-bound PR checks          |
| [Encrypted LAN collaboration](COLLABORATION.md) | Pair two teams over pinned TLS 1.3 and exchange approved proposals                         |
| [Cleetus Design](DESIGN.md)                         | Extract a design system into your repo and refine real components                          |
| [Live previews](ADAPTERS.md)                        | Web sandboxes, iOS and watchOS in Simulator, product libraries                             |
| [Tools, MCP and approvals](TOOLS.md)                | Per-member MCP, developer tooling and the permission flow                                  |
| [Local service and agent jobs](SERVICE.md)          | Background jobs, ownership and recovery                                                    |
| [Product libraries](LIBRARIES.md) | Link the design systems of several repositories into one product |
| [Memory and rules](MEMORY.md)                       | `CLAUDE.md`, `AGENTS.md`, rules files and how they reach your agents                       |

## Under the hood

[Architecture](ARCHITECTURE.md) walks through a request from the chat to an engine and back. [Security model](SECURITY_MODEL.md) lists every trust boundary. To extend Cleetus with your own tools, commands, hooks or engines, see [Plugins and hooks](PLUGINS.md).

New here? [Install Cleetus](INSTALL.md), then take the [IDE tour](IDE.md). Stuck? See [troubleshooting](TROUBLESHOOTING.md). Licensing is in [licenses](LICENSES.md).

These guides are also published at [cleetus.dev](https://cleetus.dev/docs/). The native captures show an isolated CleetusGuide01 sample project with ready, unstarted members; no providers were started for them, and they don't demonstrate live account work or a physical two-computer LAN session.
