# Tools, MCP and developer checks

## MCP connections

Tools presents configured MCP servers with their status and engine availability. A configured connection and an engine-reported live connection are different states. Assign servers to individual team members from agent details, so each role receives the tools it needs.

![Shared MCP management](screenshots/mcp.png)

External servers retain their own credentials and permissions. Assignment controls exposure; it does not sandbox the server. Claude CLI plugins/hooks and Cleetus plugins are distinct integration mechanisms.

## Developer-tool catalog

Start from a catalog preset or define a custom tool. The model supports local CLI executables, containerized tools, and hosted APIs. Presets include SonarQube, Snyk, and a configurable Wiz API starter. Keep credentials in environment/secure references, and inspect the selected executable, arguments and working directory.

![Developer-tool catalog](screenshots/dev-tools.png)

A configured command does not run automatically. Reading SonarQube's latest published analysis does not start a fresh scan. Changes to connected tools/instructions may require reconnecting the engine.

## Visual PR flow

Connect a GitHub repository in [Work tracking](WORK_TRACKING.md) and open Pull requests. The flow separates source, tooling checks, review, and merge evidence. Generic GitHub check runs/status contexts can report SonarQube or any other integrated tool.

![Visual PR tooling evidence](screenshots/pull-request-flow.png)

Evidence is tied to the current PR head commit. Missing expected results, skipped/neutral checks, pending runs, unavailable review data, and a changed head remain visible instead of becoming a pass. Configure exact expected check names when needed. GitHub remains authoritative for branch policies and merge permission; this view does not merge the PR or certify all repository rules.
