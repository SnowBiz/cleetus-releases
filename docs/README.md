# Cleetus user guide

Cleetus brings Claude and Codex conversations, agent teams, tools, work tracking, and a Design studio into one workspace. Start with installation, then choose the guide for your task.

Choose **Cleetus IDE 0.1.0** for macOS Apple Silicon ([DMG](https://github.com/SnowBiz/cleetus-releases/releases/download/ide-v0.1.0-macos-arm64/cleetus-ide-0.1.0-macos-arm64.dmg) · [release notes and checksums](https://github.com/SnowBiz/cleetus-releases/releases/tag/ide-v0.1.0-macos-arm64)), or the **Cleetus VS Code extension 1.11.3** for ordinary VS Code ([latest stable VSIX](https://github.com/SnowBiz/cleetus-releases/releases/latest)). Their versions and updates are independent. Start with [installation](INSTALL.md), then use the [IDE and Studio guide](IDE.md) or [workspace guide](GUIDE.md).

| Guide | What it covers |
| --- | --- |
| [Install and update](INSTALL.md) | Install the Apple Silicon IDE or a verified VSIX, set up separate engines, and update |
| [Cleetus IDE and Studio](IDE.md) | Native editor and Studio, goals/tasks, teams, workflow runs, owned worktrees and Design |
| [Workspace and conversations](GUIDE.md) | Chat, history, review, navigation, models and effort |
| [LAN collaboration](COLLABORATION.md) | Pair two local teams over TLS 1.3 and review message/task proposals |
| [Prebuilt teams](TEAMS.md) | All nine teams, their purpose, setup and execution |
| [Cleetus Design](DESIGN.md) | Extraction, tokens, components, page review, assets and rules |
| [Preview adapters](ADAPTERS.md) | Real web stories, iOS/watchOS Simulator previews and platform requirements |
| [Product libraries](LIBRARIES.md) | Keep design systems in repositories and link systems across deployments |
| [Tools and integrations](TOOLS.md) | MCP assignment, local/container/hosted tooling and PR checks |
| [Work tracking](WORK_TRACKING.md) | GitHub Issues, Jira, custom tracker APIs and agent ownership |
| [Local service](SERVICE.md) | Background jobs, agent tools, recovery and host boundaries |
| [Licensing and distribution](LICENSES.md) | Apache components, free personal/commercial IDE preview terms and provider costs |
| [Troubleshooting](TROUBLESHOOTING.md) | Installation, account, preview, service and update problems |

[Download releases](https://github.com/SnowBiz/cleetus-releases/releases)

The extension screenshots use illustrative local data. The native guide shows actual Cleetus IDE 0.1.0 candidate captures of an isolated CleetusGuide01 sample project: ready, unstarted members, a pending task, a saved workflow with no runs, a real local Git diff and live source previews. Models, activity and cost are not simulated as live execution. No providers were started for these captures; they do not establish live account work, customer extraction or physical two-computer LAN acceptance. The Design cowboy banner is promotional artwork. Native previews require your actual Xcode build and Simulator runtime.
