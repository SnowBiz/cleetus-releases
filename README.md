# Cleetus

**Herding models. Shipping code.**

One workspace for Claude and Codex conversations, agent teams, developer tools, work tracking, and your design studio.

This is the public download and documentation home for Cleetus. Development source is maintained separately; you do not need source-repository access to install a release.

**[Download Cleetus](https://github.com/SnowBiz/cleetus-releases/releases) · [Install and update](docs/INSTALL.md) · [User guide](docs/README.md)**

| Product | Availability |
| --- | --- |
| **Cleetus VS Code extension** | [Latest stable VSIX](https://github.com/SnowBiz/cleetus-releases/releases/latest) for ordinary VS Code. |
| **Cleetus IDE 0.1.0-dev.4** | Unreleased local, unsigned and unnotarized development app built from official Code - OSS source. A signed public IDE installer is not available yet. |

[Cleetus IDE and Studio](docs/IDE.md) covers its compact source/preview editor, central Agent Command, orbital team view, tasks, workflow canvas, split/unified review, and live Design component controls. The existing extension remains maintained and independently distributed.

## Build with a crew

Resume conversations, choose available models and effort, review tool requests/diffs, and give a prebuilt team a shared goal. Nine templates cover delivery, UI design, design extraction, review, debugging, security, refactoring, documentation, and a lean pair.

![Cleetus workspace with illustrative data](docs/screenshots/conversation.png)

[Workspace guide](docs/GUIDE.md) · [Prebuilt teams](docs/TEAMS.md)

Cleetus 1.11.2 adds [opt-in LAN collaboration](docs/COLLABORATION.md): pair two teams on the same private IPv4 subnet over TLS 1.3, compare matching eight-digit codes, and approve both sides. Outgoing proposals and incoming imports each need local approval. Accepted tasks stay pending; approved messages go to a separate inbox.

## Design with a studio

![Cleetus Design promotional banner](docs/images/cleetus-design-cowboy.png)

Extract tokens, components, pages, assets and rules from a codebase. Render real reusable blocks with controlled stories, inspect pages at device widths, refine components with agents, and link repository systems into a product library.

[Design guide](docs/DESIGN.md) · [Web and Apple adapters](docs/ADAPTERS.md) · [Product libraries](docs/LIBRARIES.md)

## Connect your work

Use GitHub Issues, Jira or a custom REST tracker. Prepare tasks with acceptance criteria, let authorized agents claim custom-tracker leases, and inspect PR check/review evidence—including published SonarQube results. MCP assignments and a generic developer-tool catalog connect local CLI, container and hosted tools.

[Work tracking](docs/WORK_TRACKING.md) · [Tools and PR flow](docs/TOOLS.md) · [Local service](docs/SERVICE.md)

## Install

Download the stable universal VSIX and `SHA256SUMS`, verify the checksum, then choose **Extensions → Install from VSIX…** in VS Code. Install the release-pinned Claude runtime separately through npm if using Claude. The [installation guide](docs/INSTALL.md) includes normal commands and the self-contained runtime installer; no private source checkout is required.

Startup update checks offer an explicit download/install choice. Account access, model usage, native toolchains and third-party charges remain separate.

## Licensing and availability

Apache-licensed Cleetus extension portions retain their accompanying license and notices. Future proprietary IDE previews explicitly distributed under the preview license permit personal and commercial use without a software license fee; future editions/services may charge prospectively. Existing Apache rights and already-granted preview builds are not retroactively relicensed or charged.

[License details](docs/LICENSES.md) · [Apache-2.0](docs/licenses/Apache-2.0.txt) · [Future IDE preview terms](docs/licenses/IDE-PREVIEW-LICENSE.txt)

The browser developer host is a separate development pathway from the native IDE. Extension screenshots use illustrative data. The IDE guide includes actual native dev.3 captures, with Teams refreshed from dev.4, of a disposable AccountWorkspace project with four ready, unstarted members and pending tasks, a real local Git diff and a source-rendered component. No provider was started for these captures, and they do not establish live account work or two-computer LAN pairing. Cleetus is independent of Anthropic and OpenAI and uses your own provider accounts.
