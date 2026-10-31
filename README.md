# Cleetus

**Herding models. Shipping code.**

Cleetus is an agentic development environment: a Code - OSS editor with Claude and Codex agent teams, reviewable tasks, workflows and a source-linked design studio built in.

This is the public download and documentation home for Cleetus. Development source is maintained separately; you don't need source access to install a release.

**[Download Cleetus IDE](https://github.com/SnowBiz/cleetus-releases/releases/download/ide-v0.1.0-macos-arm64/cleetus-ide-0.1.0-macos-arm64.dmg) · [Install and update](docs/INSTALL.md) · [Guides](docs/README.md) · [cleetus.dev](https://cleetus.dev)**

| Product | Availability |
| --- | --- |
| **Cleetus IDE 0.1.0** | macOS Apple Silicon: [signed and notarized DMG](https://github.com/SnowBiz/cleetus-releases/releases/download/ide-v0.1.0-macos-arm64/cleetus-ide-0.1.0-macos-arm64.dmg) · [release notes and checksums](https://github.com/SnowBiz/cleetus-releases/releases/tag/ide-v0.1.0-macos-arm64). A complete editor that replaces VS Code. |
| **Cleetus VS Code extension 1.11.3** | [Latest stable VSIX](https://github.com/SnowBiz/cleetus-releases/releases/latest), for people who stay in VS Code. Maintained and released independently. |

![Cleetus IDE with source, a live preview and the agent team](docs/screenshots/ide-native-editor.png)

## Build with a crew

Give Agent Command a goal, or a team of Claude and Codex agents a shared one. Teams run as pipelines, in parallel or under a supervisor, with fenced handoffs and delivery limits. Nine prebuilt teams cover delivery, UI design, design extraction, review, debugging, security, refactoring, documentation and a lean pair. Tasks carry acceptance criteria and finish only when you approve the result.

[Agent Command](docs/GUIDE.md) · [Agent teams](docs/TEAMS.md) · [Tasks](docs/TASKS.md) · [Workflows](docs/WORKFLOWS.md) · [Review & Ship](docs/REVIEW.md)

Pair two teams on the same private network with [encrypted LAN collaboration](docs/COLLABORATION.md): pinned TLS 1.3, a one-use invitation and matching eight-digit codes. Every outgoing proposal and incoming import needs local approval.

## Design with a studio

![Cleetus Design promotional banner](docs/images/cleetus-design-cowboy.png)

Extract tokens, components, pages, assets and rules from a codebase into your repository. Render real components with controlled stories, review pages at device widths, refine with agents, and link repository systems into a product library.

[Cleetus Design](docs/DESIGN.md) · [Live previews](docs/ADAPTERS.md) · [Product libraries](docs/LIBRARIES.md)

## Connect your work

Use GitHub Issues, Jira or a custom REST tracker; let authorized agents take fenced custom-tracker claims; and read PR check and review evidence bound to the head commit. Assign MCP servers per agent and connect local, container and hosted developer tools.

[Work tracking](docs/WORK_TRACKING.md) · [Tools, MCP and approvals](docs/TOOLS.md) · [Local service](docs/SERVICE.md) · [Memory and rules](docs/MEMORY.md)

## How it works

[Architecture](docs/ARCHITECTURE.md) · [Security model](docs/SECURITY_MODEL.md) · [Plugins and hooks](docs/PLUGINS.md)

## Install

**Cleetus IDE:** download the [Apple Silicon DMG](https://github.com/SnowBiz/cleetus-releases/releases/download/ide-v0.1.0-macos-arm64/cleetus-ide-0.1.0-macos-arm64.dmg) and `SHA256SUMS` from the [same release](https://github.com/SnowBiz/cleetus-releases/releases/tag/ide-v0.1.0-macos-arm64), verify the checksum, open the DMG and drag **Cleetus.app** to **Applications**. Launch Cleetus and open your project. The editor is included.

**VS Code extension:** download the [latest stable universal VSIX](https://github.com/SnowBiz/cleetus-releases/releases/latest) and its `SHA256SUMS`, verify the checksum, then choose **Extensions → Install from VSIX…** in VS Code. [Version 1.11.3](https://github.com/SnowBiz/cleetus-releases/releases/tag/v1.11.3) has its own release channel.

Engine setup uses Node.js 22+ and npm; the release-pinned Claude runtime and a supported Codex executable are separate installs. The [installation guide](docs/INSTALL.md) covers account setup and the self-contained runtime installer.

Update checks offer an explicit download and install choice; nothing installs silently. Account access, model usage, native toolchains and third-party charges remain separate.

## Licensing and availability

Apache-licensed Cleetus extension portions keep their accompanying license and notices. Cleetus IDE 0.1.0 identifies its proprietary portions under the Preview License, which permits personal and commercial use without a software license fee; future editions or services may charge prospectively. Existing Apache rights and already-granted preview builds aren't retroactively relicensed or charged.

[License details](docs/LICENSES.md) · [Apache-2.0](docs/licenses/Apache-2.0.txt) · [IDE preview terms](docs/licenses/IDE-PREVIEW-LICENSE.txt)

The native captures show an isolated CleetusGuide01 sample project: ready, unstarted members, a pending task, a saved workflow with no runs, a real local Git diff and live source previews. No providers were started for them, and they don't demonstrate live account work, customer extraction or a physical two-computer LAN session. Cleetus is independent of Anthropic and OpenAI and uses your own provider accounts.
