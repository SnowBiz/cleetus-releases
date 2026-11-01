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

## Review native questions and plans

Beta 4 builds can show structured Claude Code questions and plan
reviews in the agent workspace and dock, after the maintainer-only local channel
setup. Questions support single choice, multiple choices and non-secret Other
answers, with nothing preselected. Sending answers or approving a plan requires
host review of that exact request. Plan approval does not approve later tool
calls or change permission rules. The Cleetus window expires after 110 seconds;
**Review in Claude Code** remains the explicit native fallback.

Visible assistant narration is separate from terminal output, hidden reasoning
and a reply linked to a channel message. Authentication, folder trust and native
channel consent stay with the provider. Released beta 3 does not include these
structured interactions. See [coding agent connections](CODING_AGENTS.md#visible-narration-questions-and-plan-review)
for the preview boundaries and controls.

## Workflow execution and recovery

The following repairs are Beta 4 preview behavior. They do
not change the feature set of the released beta 3 build.

Workflow agent steps use private sessions owned by their workflow execution.
Ordinary chat cannot queue a new prompt into a step or resume it as an
independent conversation. The run journal retains bounded failure categories and
references to service jobs or sessions actually created by that step. These
references help inspect work; they do not certify its result or accept an
arbitrary reported job ID. Select a run's step and use **Owned execution
references → Inspect** to open its recorded evidence. Session references show
recent transcript events; service-job references show limited status and a
failure category. This is read-only inspection, not a retry or provider resume,
and the project/reference association is checked.

Unreadable workflow records remain on disk and produce recovery warnings. Valid
history remains available, but new work is blocked for an affected project;
unknown record scope can block all projects until reconciled. Nothing uncertain
is replayed automatically. Inspect the warning, retained run and actual external
effects before repairing storage or approving a separate new run.

Design extraction also refuses damaged saved Design JSON before replacing its
records. A malformed session-history index is retained rather than treated as an
empty history and overwritten. These errors preserve existing bytes and explain
that recovery is required; they do not silently rebuild, delete or quarantine
data. Preserve a copy and reconcile the original record before retrying. Valid
locked Design tokens and components remain protected during extraction.

For the actual automation events and their scope, see
[workflow automation](IDE.md#optional-automation). For worker cancellation and
cleanup uncertainty, see [service recovery](SERVICE.md#recovery).

Local MCP grants are checked again while reading a request, after asynchronous
policy hooks, immediately before tool dispatch and before returning a result.
A revoked grant or lost workflow owner cannot dispatch a waiting tool. If an
already-started handler loses authority, Cleetus withholds its result; that does
not undo effects already made. Closing the Core bridge also closes its pending
connections. Authentication and permissions remain separate from chat text.
