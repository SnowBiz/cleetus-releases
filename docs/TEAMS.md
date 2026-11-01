# Choose and run a prebuilt team

Prebuilt teams give a shared goal to agents with defined roles, detailed system
prompts, and an execution plan. They use the same configured engines as ordinary
conversations, including [connected ACP agents](CODING_AGENTS.md) where offered.
Choose a template in **Workflows → Team templates**, inspect **View layout**,
and choose **Create team** when it fits your task.

In native IDE **0.1.0**, use the **Teams** action on the native rail, then **+ New team**, or run **Cleetus: Open Studio**. Choose the same template, review its detailed member instructions and discovered model/effort choices, create it, then explicitly **Start team**. Creating a team or opening a Design draft does not start agents. See [IDE availability and Studio](IDE.md).

![Current workflow and team-template catalog](screenshots/workflows.png)

A mixed team is scheduled by Cleetus, with explicit member identities, reports,
messages and handoffs. In native Studio, workflow recipes can instead create a
saved definition with explicit steps and dependencies; creating it does not run
it. Beta 4 builds keep each workflow agent step in its own private
session owned by its workflow execution, so ordinary chat cannot alter its
prompt queue or resume that work independently. See [workflow execution and
recovery](TOOLS.md#workflow-execution-and-recovery).

## Which team should I choose?

| Team | Choose it when… | Members and execution | Example goal |
| --- | --- | --- | --- |
| **Software development team** | Building a feature across planning, implementation, review, and tests. | Supervised: Claude tech lead directs a Claude planner, Codex implementer, Claude reviewer, and Codex tester. | “Add account notification preferences, preserve existing defaults, and test save/error behavior.” |
| **Design squad** | Implementing or refining UI using the saved design system and approved references. | Supervised: Claude design lead directs a Codex UI builder and Claude design reviewer. | “Refine the account settings block, reuse its tokens, and review all consumers at mobile and desktop widths.” |
| **Design System Extraction** | Building or hardening the design library from existing source or a permitted website. | Pipeline: Claude discovery lead → Claude tokens/assets → Codex component curator → Codex page/platform builder → Claude rules librarian → Claude auditor. | “Extract this repository's design system, register real previews, and report unresolved runtime coverage.” |
| **Code review squad** | Reviewing an existing change from several perspectives without assigning a feature build. | Parallel: Claude correctness/security reviewers and Codex test/maintainability reviewers. | “Review the current diff for authorization defects, regressions, missing tests, and maintainability concerns.” |
| **Bug hunt** | Reproducing and fixing a concrete defect with an independent verification stage. | Pipeline: Codex reproducer → Claude root-cause analyst → Codex fixer → Claude verifier. | “Reproduce the lost form state after navigation, fix its cause, and verify the original reproduction.” |
| **Security audit** | Investigating the code's security risks and producing a prioritized report. | Pipeline: Claude threat modeler → Codex code auditor → Claude security reporter. | “Audit file uploads and tenant boundaries; include concrete code evidence and remediation priorities.” |
| **Refactor crew** | Improving structure while preserving behavior. | Pipeline: Claude analyst → Codex refactorer → Claude regression checker. | “Separate persistence from UI logic without changing behavior; demonstrate existing checks still pass.” |
| **Docs and research** | Investigating repository behavior, writing documentation, and checking its claims. | Pipeline: Claude researcher → Claude writer → Codex fact checker. | “Document installation and provider configuration with commands checked against this repository.” |
| **Lean pair (cost-efficient)** | A small, well-defined implementation with a separate review. | Pipeline: Codex implementer → Claude reviewer; Low effort preset. | “Add the missing empty-state message and review the diff for regressions.” |

These are starting roles, not guaranteed outcomes or fixed vendor/model requirements. Inspect the actual template before starting; saved template edits can change its settings. Security reviews are code investigations, not certifications. Detailed roles and tool permissions remain important even when all members use the same engine.

## Configure and start

1. Open the target project and connect the engines you intend to use.
2. Select the template and write a concrete goal: desired behavior, scope, constraints, and acceptance checks.
3. Inspect the workflow mode and each member's role, task, system prompt, engine, model, effort, and MCP access.
4. Keep engine-default models or choose available catalog models. Whole-team choices are grouped by engine/backend; individual members can override them. A supervised team requires a coordination-capable supervisor: Claude or a connected ACP engine where supported. Codex can participate as a member.
5. Set team effort and any per-agent overrides. Blank per-agent effort inherits the team setting. Extraction recommends High; the lean pair presets Low. Other templates can have their own member settings.
6. In native team setup, review the delivery limit (1–50). The default is 10; Design System Extraction presets 20. It bounds task/message handoffs.
7. Create the team and start its workflow. Extraction offers **Create & start extraction** or **Create without starting**.
8. Review messages, approvals, output, reports, and actual artifacts in **Agents & Teams**.

**Beta 5:** use **Refresh agent models** (or the named member’s refresh control) to discover models for that member without launching every connected provider. Passive lists retain the last approved catalog; stale explicit choices need refresh. Draft prompts and choices stay intact.


![Current extraction team setup; all specialist prompts remain editable](screenshots/extraction-team.png)

Agent details in a template layout let you inspect and save its model, effort, system prompt, and MCP settings. Ready-team agent settings can also be edited before launch; started agents cannot be reconfigured through that pre-start editor. Refresh/reopen when another window has changed the saved settings.

## Current teammate ownership

Beta 6 rechecks the live project, team owner, member execution and checkout before
launching a hosted Claude Code teammate or accepting its Cleetus tools/channel
traffic. If that authority changes, old requests are retired and new work needs
current approval. Normal supervisor assignments and inbox handoffs still work.
Already dispatched changes remain real evidence to inspect; a rejected response
is not a rollback.

When Claude Code reports that its native session ended, Cleetus marks it
disconnected and retains the conversation for review. Reconnect is explicit;
closing or reopening a view does not replay the previous prompt.

Beta 7 applies the same host lifecycle boundary to ordinary conversations and
rejects stale native narration after authority is lost. Explicit reconnect obtains
fresh grants; opening a view or reopening a folder does not restore an old grant.
Cancelled or limited ACP turns do not complete workflow work successfully, and
queued follow-ups discarded by a stop are reported as not sent. Review and resend
any still-relevant instruction rather than expecting automatic replay.

In Beta 8, hosted Claude Code history keeps the observed order of messages and
visible narration, including distinct Stop-only replies. Saved reply links stay
bound to their launch, so reconnect cannot associate an old reply with a new
message that reuses its ID. Partial narration remains marked.

Beta 9 also reconciles final narration when Claude’s completion and display
notifications arrive out of order. The same final message appears once; equal
answers on separate turns remain separate. Saved journals are preserved.

Ended or disabled conversations stay readable in the conversation dock. Their
saved questions and permissions are history, not active decisions. **Review in
Claude Code** focuses the exact existing ordinary agent terminal when one is
available. It does not open a second chat or silently launch/resume an agent.
If no live terminal exists, reconnect explicitly with fresh approval. Team and
workflow work continues through its own ownership controls.

## Work through a blocked teammate

Beta 9 distinguishes an **active turn** from a saved result. A worker can report
blocked while its supervisor or parallel peers still have active work. Those
active agents retain their own inbox, questions, tool approvals and coordination;
one blocked worker does not disconnect the rest of the team. Once no active turn
remains, the team pauses for review. Cancelled, revoked or completed attempts do
not regain authority through a saved status or by reopening the view.

A teammate’s retained conversation remains readable. When it has no active turn,
its composer and old decisions are read-only. Start fresh work through Tasks or
Teams with current approval. This applies across hosted Claude Code, API/cloud
Claude, Codex and connected ACP agents. Ordinary shared chat cannot take over a
team-owned session by its saved ID. Native failures produce one coordinator
result while preserving the failed turn and any partial output.

For a paused Claude API or Codex teammate, send a bounded follow-up to that
member and explicitly review its delivery through Teams. This admits a current
private turn; automatic delivery stays paused while review is needed. Cancelled,
historical or revoked runs are not restarted. A live native Claude Code teammate
receives an inbox handoff; Cleetus does not type it into the terminal or silently
launch another native turn.

A supervisor’s explicit Remote Control disable remains an owned cleanup action
after its turn ends. It grants no new execution rights. If enable is still
pending, cleanup waits for it to settle and then requests off; disconnected is
reported only after that request is acknowledged. A provider error is not proof
that remote access was revoked; inspect the provider when confirmation is absent.
This does not claim automatic remote shutdown on every stop or transport loss.

While sending a Studio message, **Sending…** stays visible through conversation
refreshes. You can keep writing the next draft; acceptance of the earlier message
does not erase it. A rejected send retains its draft. An explicit retry of the
unchanged message keeps its delivery identity; Cleetus does not silently replay
failed or uncertain work.

## Recognize agent specialties

Each of the 33 distinct roles in the prebuilt teams and workflow recipes has its own Cleetus robot portrait. This includes separate portraits for reproducer, root-cause analyst, fixer, verifier, each review specialty, and each extraction specialist. The full set has 40 artwork identities, retaining the original domain portraits plus a generalist robot for unspecified or unrecognized roles. Cleetus resolves exact prebuilt roles before broad specialty aliases, so a design lead and a design reviewer do not share an image. The same role keeps its portrait across team cards, messages, topology views, native agent lists and shared team views opened inside the IDE.

Portraits describe specialties, not authority or progress. The separate engine, model, effort and status labels show the agent’s actual configuration and recorded state. Change its instructions and tool assignments through agent settings; changing a role label alone does not change its permissions.

## Understand the execution mode

- **Pipeline:** stages run in order. An explicit completed report hands results to the next stage. An ended turn without that report pauses for review.
- **Parallel:** members run independently in the same working tree. Divide file ownership or use separate worktrees where necessary.
- **Supervised:** only the configured supervisor starts initially. It assigns work, starts members, reviews results, and reports back. Use its message controls to give direction.

![Current team layout and communication panel](screenshots/teams.png)

Use **Output** to inspect actual work, **Message** to provide direction, and approval controls to answer tool requests. A blocked member needs a concrete recovery action. **Accept & hand off** is your explicit review decision; use it after inspecting the result. Stop a team to interrupt its agents. Delivery limits prevent unlimited task/message loops.

Ready teams can be reopened for editing. In Beta 4 builds, stale edits from another window are rejected and a live team belongs to its launching coordinator. Saved completed, cancelled, failed, and interrupted history retains output/messages; stopped-owner work becomes interrupted and queued handoffs are cancelled without replay. Historical records are read-only. Saved records are never proof of process reattachment. See [IDE tasks and recovery](IDE.md#give-a-team-a-bounded-goal) and the [service guide](SERVICE.md).

## Design squad or extraction team?

Use **Design System Extraction** to discover and curate what the product already has: tokens, assets, composed components, pages, platform fixtures, contracts, and rules. Starting from Design fills the repository/scope into normal team setup. Its **View design system** action returns to that project's saved artifacts.

Use the **Design squad** to implement or refine an interface against those decisions and approved references. A component/page studio task can prepare a focused team or Conversation draft with source, fixtures, contracts, rules, and acceptance criteria. Preparing a draft does not send it or start agents automatically.

[Design extraction](DESIGN.md#extract-a-design-system) · [Component refinement](DESIGN.md) · [Workspace operations](GUIDE.md)


## Collaborate across computers

Extension 1.11.2 or later and Cleetus IDE 0.1.0 support opt-in **Collaborate on LAN**. Select an existing local team in this project. Pair with another person’s team on the same private IPv4 subnet over TLS 1.3 using a copied one-use invitation and matching eight-digit codes approved by both people. Starting a team is not required to pair it.

Each outgoing proposal and incoming import needs local approval. Accepted tasks become pending local tasks; approved messages stay in a separate team inbox, available through scoped agent tools rather than automatically becoming an agent prompt. Pairing grants no files, commands, provider accounts or credentials. See [network collaboration](COLLABORATION.md) for setup, scoped agent tools and reconnection behavior.
