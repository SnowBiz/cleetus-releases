# Cleetus IDE and Studio

Cleetus IDE combines a Code OSS editor with Cleetus Agent Command, teams, tasks, workflows, review, and Design. The existing Cleetus extension remains a separate product for ordinary VS Code.

| Distribution | Availability |
| --- | --- |
| **Cleetus VS Code extension** | Stable public VSIX. Follow [Install and update](INSTALL.md). |
| **Cleetus IDE 0.1.0-dev.1** | Unreleased local development build. The current macOS app is unsigned and unnotarized. A signed public IDE installer is **not available yet**. |

This guide describes the current development interface. Do not treat a development app or unsigned archive as a signed public release. Public installation instructions will accompany a signed, published IDE package when one is available.

## Open your workspace

If you have an authorized development build:

1. Open Cleetus and choose a project folder. Use the normal Explorer, editor, integrated terminal, source control, and compatible language/debug extensions alongside your agents.
2. Connect Claude or Codex through Cleetus **Get started**. Their runtimes and accounts are separate installs; use the same [engine setup](INSTALL.md#connect-your-engines) as the extension.
3. Open the Command Palette and run **Cleetus: Open Studio**. **Cleetus: Focus Agent Command** opens the Cleetus conversation surface. The IDE shortcut is **Ctrl+Alt+I**, or **Ctrl+Cmd+I** on macOS.
4. Select the opened project in Studio before creating work. Its tabs are **Agent Command**, **Teams**, **Tasks**, **Workflows**, **Review & Ship**, and **Design**.

Cleetus provides the IDE's agent experience. The upstream vendor chat/runtime is omitted from this development distribution; Copilot is a possible future engine, not an available Cleetus engine today. Claude and Codex remain the current supported choices.

The IDE uses its own application identity, settings, extension directories, and launch profiles. It can coexist with VS Code without moving your VS Code settings or credentials automatically. Install compatible extensions from Open VSX or a reviewed VSIX. Availability and licensing vary by extension; installing one does not supply a model subscription.

## Start with one goal

1. In **Agent Command**, choose a connected engine, a discovered model or **Engine default**, and an effort offered by that engine.
2. Describe the outcome, relevant constraints, and how you will check the result. Submitting the goal saves a goal and a linked execution task before requesting a run.
3. Read the native approval dialog, especially its project and working directory. Allow only the work you intend to run.
4. Inspect actual output and tool requests. Agent progress and team communication come from observed events; a requested model setting is not proof of provider-reported execution metadata.

Use a conversation for a focused question. Use a task when you want durable acceptance criteria, ownership, and a separate review decision. A stopped run retains source changes already made.

## Keep tasks reviewable

![Studio task settings with local test data; provider transport is mocked](screenshots/ide-tasks.png)

In **Tasks**, use **+ New goal** or **+ New task**. Give tasks a concrete title, description, acceptance criteria, and an appropriate parent. Select a card to read its report and ownership details. The board separates pending, running, review, and completed work.

Choose **Run task** for a pending task, inspect the engine and working directory in its approval, then follow the result. Dependencies must be completed and approved before a dependent task can be claimed. Claims have an owner, expiry, and fencing generation: an expired or replaced owner cannot submit work using an old claim.

An agent report or ended turn sends work to **review**; it does not approve its own changes. Inspect the actual files, diff, checks, and reported evidence, then choose **Approve result** or **Request changes**. Completion is your review decision, not a claim that every check passed automatically.

### Choose isolation explicitly

**Review & Ship → Owned worktrees → + New worktree** creates a separate checkout and branch from the current committed HEAD. Associate it with an existing task and review the native approval. Uncommitted changes in the primary checkout stay there.

Select the task in **Tasks** and choose its engine/model, effort and working directory. The checkout menu offers the current project and ready owned worktrees associated with that exact task. Creating a worktree alone does not redirect a run; choose it explicitly, then confirm its path in the approval dialog. Follow the execution receipt, use **Stop execution** when needed, and inspect the saved session output before review.

Task ownership remains on the primary project's board even when an authorized run uses an isolated checkout. Stale leases, changed Git identity, or another task's worktree do not grant access. Worktree bindings are not restored automatically from session history.

A worktree separates checkout files; it is not an operating-system sandbox. Existing engine tool permissions and project trust still apply.

## Give a team a bounded goal

![Ready agent settings and MCP assignments with local test data](screenshots/ide-agent-settings.png)

Open **Teams → + New team**, choose one of the [nine prebuilt teams](TEAMS.md#which-team-should-i-choose), and inspect its members before creating it. Templates cover delivery, UI design, design extraction, review, debugging, security, refactoring, documentation, and a lean pair.

Review each role, task, system prompt, engine, model, effort, and supervisor setting. Models come from the connected provider catalog; missing choices are unavailable, not substitutes. A blank member effort uses the team setting. A supervised team needs a Claude supervisor.

Creating a team does not start it. Choose **Start team** and approve its actual configuration. Inspect the communication graph, messages, member output, and reports; send direction to the selected member when needed. Pipelines wait for explicit reports, parallel members need separate file ownership or deliberate isolation, and supervisors direct their members.

Saved history retains results and messages. A live team remains owned by its launching coordinator. Historical or interrupted work is read-only, and restarting the editor does not replay queued handoffs or reattach arbitrary processes. Review the retained changes before starting new work.

## Define a workflow, then inspect its runs

![Recipe catalog rendered from the actual profile store using local test data](screenshots/ide-workflow-catalog.png)

1. Open **Workflows → Recipes** and choose a starter for feature development, bug investigation, review, documentation, tests or deployment preparation. Enter your goal and choose a discovered model/effort, then create its saved DAG. Use **Advanced JSON** for a custom definition; give each step a unique ID, supported action, input and `dependsOn` list.
2. Use **agent-task** for a bounded Claude/Codex request or **design-extract** for source Design extraction. The editor validates actions and rejects missing or circular dependencies.
3. Save the definition and inspect its graph. Independent steps may run in parallel; a dependent step waits for its predecessors.
4. Choose **Run workflow** and approve the displayed steps. Inspect the resulting run journal and node states separately from the saved definition.

Editing a definition does not rewrite earlier runs. Failed predecessors block dependent steps. The current agent and Design actions do not retry side effects automatically. Cancellation and timeouts request a stop; noncooperative work remains uncertain until it settles. An interrupted run is not replayed after restart.

For a first definition, adapt this read-only request to an engine you have connected:

```json
{
  "name": "Inspect a component",
  "steps": [{
    "id": "inspect",
    "action": "agent-task",
    "input": {
      "engine": "codex",
      "prompt": "Inspect an existing component and its tests. Report file references and gaps; do not change files."
    },
    "dependsOn": [],
    "timeoutMs": 300000,
    "maxAttempts": 1
  }]
}
```

### Scheduled and named-event automation

The shared host supports approved intervals of **60 seconds to 7 days** and allowlisted named events: **project.changed**, **task.reviewed**, and **manual**. These names are explicit host events; a file edit or task review does not implicitly emit one merely because its name matches.

Automation requires a separate human authorization for the exact workflow revision and trigger configuration. Workflow edits invalidate that authorization. Missed intervals are skipped after restart, overlapping runs are skipped, and failed or uncertain dispatches stop further automation for review. Event deliveries use durable identities to prevent duplicate execution.

Open **Workflows → Automation → + Add automation**, choose a saved workflow, and configure an interval or named event. New automation starts disabled. Enabling or changing it opens the host approval for that exact revision. Use **Disable automation** or **Remove automation** to stop future dispatch.

**Emit an event** is an explicit, approved action. Reusing the same event ID returns its existing receipts; choose **New event ID** for a separate intended delivery. Inspect dispatch history and its linked run journal. Closing a trigger service stops future dispatches; accepted work keeps its runtime cancellation/recovery behavior.

![Automation and deduplicated dispatch receipts from a local application fixture](screenshots/ide-automation.png)

## Review changes before shipping

![Actual temporary Git checkout diff; this example shows a declined cleanup and retained changes](screenshots/ide-worktree-review.png)

In **Review & Ship**, choose the evidence you need:

- **Owned worktrees:** select a checkout, use **Refresh checkout**, inspect its branch, recorded base, task association, and changed files, then **Load tracked diff**. Truncated output is marked. Untracked and ignored files are listed by name; their content is not part of the tracked diff.
- **Pull requests:** choose a configured GitHub tracker and PR. Review checks, review state, and merge evidence for the current head. Missing, skipped, stale, or unavailable checks stay distinct from a pass. Open the provider link for the repository's normal review and merge process.

Cleanup asks for explicit approval and removes only a verified clean Cleetus-owned checkout. Tracked, untracked, and ignored files block removal. The branch is retained, and unrelated worktrees are outside this ledger. Review & Ship does not automatically merge or cherry-pick changes.

## Keep Design beside the source

![Cleetus Design promotional artwork, not a native IDE capture](images/cleetus-design-cowboy.png)

Open **Design** in Studio to use the shared Design viewer without leaving the editor. Extract a system, inspect tokens/assets/rules, render registered components and pages, and prepare an agent refinement task with source-linked context. Opening a draft does not send it or start agents.

Web previews use real source adapters and fixtures. Apple previews use an actual Xcode Debug story build and Apple Device Hub/Simulator for iOS or watchOS. Install the required toolchain and Simulator runtime first. Discovery is not proof of a successful build or render; inspect build logs and the actual result. Android source discovery currently has no native preview renderer.

[Design workflow](DESIGN.md) · [Web and Apple adapters](ADAPTERS.md) · [Product libraries](LIBRARIES.md)

## Accounts, approvals, and updates

Connect accounts locally. Secure credentials stay in the host's credential store or the provider's supported runtime configuration; copying a profile does not transfer secure login state. Heavy Design jobs and tracker/PR work use the local service. Normal engine tool permissions and explicit host approvals still apply.

The stable extension updater uses public release metadata, verifies VSIX size and SHA-256, and offers an explicit installation choice. It does not update the native IDE application. The IDE checks its own platform-specific public releases separately. A notarized Developer ID installation can stage a newer signed installer after verifying its checksum, publisher, bundle identity and notarization, then rechecks it before your explicit **Open installer** choice. Unsigned development builds can view published release notes but cannot use that verified installer path. No signed public native installer has been published yet. See [installation](INSTALL.md), [local service](SERVICE.md), and [licenses](LICENSES.md).

This page uses approved promotional artwork only. Existing guide screenshots show illustrative extension/local-fixture data; they are not native IDE captures or evidence that your project has passed validation.
