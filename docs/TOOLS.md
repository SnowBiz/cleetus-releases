# Tools, MCP and approvals

_Read this guide on [cleetus.dev](https://cleetus.dev/docs/tools/)._

Agents work through tools: file edits, commands, MCP servers, Cleetus's own tools and your developer tooling. This guide covers how tools reach each agent, and the single permission flow every tool request goes through.

## The permission flow

![Hooks, then session rules, then your approval card](images/diagram-approvals.png)

When an engine wants to edit a file, run a command or call a tool:

1. **Hooks.** Trusted plugins' `permission.decide` hooks can allow or deny without asking you.
2. **Session rules.** If you chose **always allow** for this tool earlier in the session, it's allowed. That memory lives only for the session.
3. **You.** Otherwise a team's handler or your approval card decides: **allow once**, **always allow** or **deny**. Diff review can hand the engine an edited input.

The decision goes back to the engine. Two rules always hold: when a turn ends, anything still pending is **denied**, and **Stop** interrupts work but never rolls back files already written.

The engine's own permission mode and persistent rules also apply. Persistent allow and deny rules are the engine runtime's settings; managed policy isn't editable from Cleetus. Bypass modes skip prompts entirely, so enable them only where you mean to.

## MCP servers

![Tools & integrations: MCP servers with status and per-agent assignment](screenshots/mcp.png)

**Tools** lists your configured MCP servers with their status and which engines can use them. A configured connection and an engine-reported live connection are different states, and Cleetus shows both.

Assign servers **per team member** from the member's settings, so each role gets only what it needs. Assignment controls exposure; it doesn't sandbox the server, which keeps its own credentials and permissions. MCP environment fields can hold secrets, and the MCP config file is written with mode `0600`.

## Cleetus's own tools

Cleetus exposes its tools to Claude and Codex identically, as one local MCP server per session:

- **Team tools:** `team_roster`, `team_send`, `team_inbox`, `team_report`. See [Agent teams](TEAMS.md#handoff-tools).
- **Work tracking:** `work_tracker_*`. See [Work tracking](WORK_TRACKING.md#agent-tools).
- **Service jobs:** `cleetus_job_*`. See [Local service](SERVICE.md).
- **Peer collaboration:** `cleetus_peer_*`. See [LAN collaboration](COLLABORATION.md#let-agents-use-it).

The bridge listens on `127.0.0.1` only, rejects browser origins and requires a token that exists only while the session is open. Team capabilities are bound to each member's identity and revoked when the team is cancelled. Engines may prefix the tool names through MCP.

## Developer tooling

![Developer-tool catalog with SonarQube, Snyk, Wiz and custom tools](screenshots/dev-tools.png)

Start from a catalog preset (SonarQube, Snyk or a configurable Wiz API starter) or define your own: a local CLI, a container or a hosted API.

- Commands run as an executable plus an argument array, **never through a shell**. Check the executable, arguments and working directory you configure.
- Keep tokens in environment variables or secure references. The host reads them, and they're never copied into the UI.
- Configured commands don't run on their own. Reading SonarQube's latest published analysis doesn't start a new scan.
- Changing connected tools or instructions may need an engine reconnect.

To see tooling results on a pull request, have the tool report to GitHub as a check, then use [PR evidence](WORK_TRACKING.md#pull-request-evidence).

## Plugins and hooks

Cleetus plugins can add tools, slash commands, panels, hooks and even engines. They start disabled and declare permissions, but they run as ordinary Node.js in the host, so treat them as trusted local code. See [Plugins and hooks](PLUGINS.md).

[Security model](SECURITY_MODEL.md) · [Plugins and hooks](PLUGINS.md)
