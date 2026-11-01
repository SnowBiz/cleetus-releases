# Cleetus

**Herding models. Shipping code.**

One workspace for Claude and Codex conversations, agent teams, developer tools, work tracking, and your design studio.

This is the public download and documentation home for Cleetus. Development source is maintained separately; you do not need source-repository access to install a release.

**[Download Cleetus](https://github.com/SnowBiz/cleetus-releases/releases) · [Install and update](docs/INSTALL.md) · [User guide](docs/README.md)**

| Product | Availability |
| --- | --- |
| **Cleetus VS Code extension 1.11.3** | [Latest stable VSIX](https://github.com/SnowBiz/cleetus-releases/releases/latest) for ordinary VS Code. |
| **Cleetus IDE 0.1.0** | macOS Apple Silicon: [signed and notarized DMG](https://github.com/SnowBiz/cleetus-releases/releases/download/ide-v0.1.0-macos-arm64/cleetus-ide-0.1.0-macos-arm64.dmg) · [release notes and checksums](https://github.com/SnowBiz/cleetus-releases/releases/tag/ide-v0.1.0-macos-arm64). |

[Cleetus IDE and Studio](docs/IDE.md) covers its compact source/preview editor, central Agent Command, orbital team view, tasks, workflow canvas, split/unified review, and live Design component controls. The existing extension remains maintained and independently distributed.

## Build with a crew

Resume conversations, choose available models and effort, review tool requests/diffs, and give a prebuilt team a shared goal. Nine templates cover delivery, UI design, design extraction, review, debugging, security, refactoring, documentation, and a lean pair.

![Cleetus workspace with illustrative data](docs/screenshots/conversation.png)

[Workspace guide](docs/GUIDE.md) · [Prebuilt teams](docs/TEAMS.md)

Builds with **Cleetus: Connect coding agents** can also connect your independently installed Copilot, Kiro V3, Gemini CLI, OpenCode or a custom ACP stdio agent. Follow [coding-agent connections](docs/CODING_AGENTS.md) for native sign-in, launch approvals and capability limits; check feature availability in your installed build.

Cleetus 1.11.2 adds [opt-in LAN collaboration](docs/COLLABORATION.md): pair two teams on the same private IPv4 subnet over TLS 1.3, compare matching eight-digit codes, and approve both sides. Outgoing proposals and incoming imports each need local approval. Accepted tasks stay pending; approved messages go to a separate inbox.

## Design with a studio

![Cleetus Design promotional banner](docs/images/cleetus-design-cowboy.png)

Extract tokens, components, pages, assets and rules from a codebase. Render real reusable blocks with controlled stories, inspect pages at device widths, refine components with agents, and link repository systems into a product library.

[Design guide](docs/DESIGN.md) · [Web and Apple adapters](docs/ADAPTERS.md) · [Product libraries](docs/LIBRARIES.md)

## Connect your work

Use GitHub Issues, Jira or a custom REST tracker. Prepare tasks with acceptance criteria, let authorized agents claim custom-tracker leases, and inspect PR check/review evidence—including published SonarQube results. MCP assignments and a generic developer-tool catalog connect local CLI, container and hosted tools.

[Work tracking](docs/WORK_TRACKING.md) · [Tools and PR flow](docs/TOOLS.md) · [Local service](docs/SERVICE.md)

## Install

**Cleetus IDE:** download the [Apple Silicon DMG](https://github.com/SnowBiz/cleetus-releases/releases/download/ide-v0.1.0-macos-arm64/cleetus-ide-0.1.0-macos-arm64.dmg) and `SHA256SUMS` from the [same release](https://github.com/SnowBiz/cleetus-releases/releases/tag/ide-v0.1.0-macos-arm64), verify the checksum, open the DMG, and drag **Cleetus.app** to **Applications**. Launch Cleetus and open your project. The editor is included.

**VS Code extension:** download the [latest stable universal VSIX](https://github.com/SnowBiz/cleetus-releases/releases/latest) and its `SHA256SUMS`, verify the checksum, then choose **Extensions → Install from VSIX…** in VS Code. [Version 1.11.3](https://github.com/SnowBiz/cleetus-releases/releases/tag/v1.11.3) has its own release channel.

Engine setup uses Node.js 22+ and npm; the release-pinned Claude runtime and a supported Codex executable are separate installs. The [installation guide](docs/INSTALL.md) includes account setup and the self-contained runtime installer. Neither product requires private source access.

Startup update checks offer an explicit download/install choice. Account access, model usage, native toolchains and third-party charges remain separate.

## Licensing and availability

Apache-licensed Cleetus extension portions retain their accompanying license and notices. Cleetus IDE 0.1.0 identifies its proprietary portions under the Preview License, which permits personal and commercial use without a software license fee; future editions/services may charge prospectively. Existing Apache rights and already-granted preview builds are not retroactively relicensed or charged.

[License details](docs/LICENSES.md) · [Apache-2.0](docs/licenses/Apache-2.0.txt) · [IDE preview terms](docs/licenses/IDE-PREVIEW-LICENSE.txt)

The browser developer host is a separate development pathway from the native IDE. Extension screenshots use illustrative data. The native guide shows actual Cleetus IDE 0.1.0 candidate captures of an isolated CleetusGuide01 sample project: ready, unstarted members, a pending task, a saved workflow with no runs, a real local Git diff and live source previews. Models, activity and cost are not simulated as live execution. No providers were started for these captures; they do not establish live account work, customer extraction or physical two-computer LAN acceptance. Cleetus is independent of Anthropic and OpenAI and uses your own provider accounts.
