# Security model

_Read this guide on [cleetus.dev](https://cleetus.dev/docs/security-model/)._

Cleetus launches coding engines and hands them tools that read, edit and run your project. That's the point, and it's also why every boundary is spelled out here: what each part can reach, what stops it, and what Cleetus does **not** protect against.

## Trust boundaries

| Boundary          | What protects it                                                                                                                            | What it doesn't do                                                              |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| **Engines**       | Every tool request goes through [the permission flow](TOOLS.md#the-permission-flow). Pending requests are denied when a turn ends.      | Bypass modes and trusted hooks can allow without asking.                        |
| **Tool bridge**   | Binds `127.0.0.1`, rejects browser origins, and needs a per-session token revoked on close. Team capabilities are bound to member identity. | It can't stop arbitrary code already running as you.                            |
| **Plugins**       | Start disabled, declare API permissions, and their contributions are removed on disable.                                                    | Plugins are Node.js in the host, not a sandbox. Trust them like any local code. |
| **MCP servers**   | Per-member assignment limits which agents see them.                                                                                         | Assignment doesn't sandbox the server, and its credentials are its own.         |
| **Local service** | Private IPC with no network port; job ownership comes from the host.                                                                        | It runs with your privileges; separation is for reliability.                    |
| **Project code**  | Cleetus is off in Restricted Mode and virtual workspaces; you trust a folder first.                                                         | Builds, previews and engine commands execute project code as you.               |
| **LAN peers**     | Pinned TLS 1.3, matching codes, two approvals and strict frames. Pairing grants nothing.                                                    | A substituted invitation is outside the model, which is why you compare codes.  |

## Data that leaves your machine

"Local profile" doesn't mean everything stays offline. Data leaves when you use a feature that needs it:

- **Engines** receive prompts, attached context, tool results and configured instructions.
- **MCP servers** receive their tool inputs.
- **Browser and Design site extraction** contact the sites and resources you point them at.
- **SonarQube and other tools** contact their configured servers; command tools can reach networks themselves.
- **Trackers** receive the requests and writes you make.
- **The update check** reads public Cleetus release metadata, without credentials or project data.

## Data on your machine

The profile holds prompts, transcripts, native engine sessions, configuration and possibly environment values. Cleetus writes it atomically with restrictive permissions where supported, but **doesn't encrypt it**. Tokens for trackers and tooling stay in the secure credential store or environment references, and are read by the host rather than copied into the UI or job records. MCP configuration is written with mode `0600`.

## Untrusted content

Some text is evidence, never instructions, and Cleetus labels it that way when it reaches an agent:

- issue and pull request content from trackers,
- messages and proposals from paired LAN teams,
- browser page text,
- reports from earlier pipeline stages and workflow steps.

None of it can override your instructions, project rules or approvals.

## Updates

The IDE's updater verifies the installer's checksum, publisher, bundle identity and notarization before staging it, then waits for you to choose **Open installer**. Nothing installs silently, and Gatekeeper is never bypassed. Checksums detect a corrupt or substituted download relative to the release; they can't independently authenticate a compromised publisher account.

## Report a vulnerability

Follow [Security and disclosure](https://cleetus.dev/docs/security/) to report a vulnerability privately, with steps to reproduce. Please don't open a public issue for it.

[Architecture](ARCHITECTURE.md) · [Tools, MCP and approvals](TOOLS.md) · [Encrypted LAN collaboration](COLLABORATION.md)
