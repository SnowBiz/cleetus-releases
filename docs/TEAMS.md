# Agent teams

_Read this guide on [cleetus.dev](https://cleetus.dev/docs/teams/)._

A team gives one goal to several agents with explicit roles, each with its own engine, model, effort, instructions and MCP servers. Cleetus schedules them, carries their messages and handoffs, and stops when a limit is reached. Claude and Codex can sit on the same team.

![The orbital Teams view: a tech lead supervising a planner, implementer, reviewer and tester](screenshots/detail-teams-topology.png)

## Three ways to run a team

![Pipeline, parallel and supervised execution](images/diagram-team-modes.png)

- **Pipeline.** Stages run in order. A stage hands off when its turn ends successfully **and** it calls `team_report` with `completed`. If a turn ends without a report, the pipeline pauses for your **Accept & hand off**. A `blocked` or `failed` report, a runtime error or a disconnect stops automatic progress.
- **Parallel.** Members run independently in the **same working tree**. Split file ownership in the goal, or give members separate [worktrees](REVIEW.md).
- **Supervised.** Only the supervisor starts. It assigns work, starts members, reviews their results and reports back. Supervisors must be Claude.

## Which team should I choose?

| Team                      | Mode       | Members                                                                             | Reach for it when                               |
| ------------------------- | ---------- | ----------------------------------------------------------------------------------- | ----------------------------------------------- |
| Software development team | Supervised | Claude tech lead → Claude planner, Codex implementer, Claude reviewer, Codex tester | A feature across plan, build, review and tests  |
| Design squad              | Supervised | Claude design lead → Codex UI builder, Claude design reviewer                       | UI work against your saved design system        |
| Design System Extraction  | Pipeline   | Six specialists, Claude and Codex                                                   | Building the design library from existing code  |
| Code review squad         | Parallel   | Claude correctness and security, Codex tests and maintainability                    | Reviewing an existing diff from several angles  |
| Bug hunt                  | Pipeline   | Codex reproducer → Claude root-cause analyst → Codex fixer → Claude verifier        | A concrete defect with independent verification |
| Security audit            | Pipeline   | Claude threat modeler → Codex code auditor → Claude reporter                        | A prioritized, evidence-backed risk report      |
| Refactor crew             | Pipeline   | Claude analyst → Codex refactorer → Claude regression checker                       | Restructuring without behaviour change          |
| Docs and research         | Pipeline   | Claude researcher → Claude writer → Codex fact checker                              | Docs whose claims are checked against the repo  |
| Lean pair                 | Pipeline   | Codex implementer → Claude reviewer, Low effort                                     | Small, well-defined changes                     |

These are starting points. Every role, prompt, engine, model, effort and MCP assignment is editable before launch, and a security audit is a code investigation, not a certification.

## Create and start a team

![Create team: template, execution mode, effort, delivery limit and each agent's role, provider, model, effort and assigned task](screenshots/detail-team-create-roles.png)

1. **Teams → + New team**, then choose a template or start blank.
2. Write a concrete goal with the behaviour you want, its scope, constraints and acceptance checks.
3. Review every member: role, assigned task, system prompt, engine, model, effort and MCP access. A blank member effort inherits the team's.
4. Set the **delivery limit**, 1–50 handoffs and messages (default 10; extraction presets 20).
5. **Create** saves the team without starting anything. **Start team** is separate, and shows you the exact configuration to approve.

![Member settings: discovered model, effort, additional instructions and MCP access](screenshots/detail-teams-member-settings.png)

Ready members can be edited until launch. If another window changed the saved team, your stale edit is rejected rather than overwriting theirs.

## Handoff tools

Every member gets four tools, bound to its identity by the engine adapter:

| Tool                                           | What it does                                                                          |
| ---------------------------------------------- | ------------------------------------------------------------------------------------- |
| `team_roster({})`                              | The goal, members, engines, roles, task IDs and status                                |
| `team_send({to, body, kind?, correlationId?})` | Queue a message or handoff to another member                                          |
| `team_inbox({})`                               | The last 50 messages addressed to this member                                         |
| `team_report({outcome, summary})`              | Report `completed`, `blocked` or `failed`, with artifacts and real validation results |

```json
{
  "to": "recipient-member-uuid",
  "kind": "handoff",
  "body": "Implemented src/api.ts. npm test passes. Review validation and authorization before accepting."
}
```

The sender is set by the adapter, never by the model: supplying `from`, addressing another team or citing an unknown correlation ID is rejected. Messages are context; they can't override your instructions, project rules or backend policy.

## How messages move

Each message is a versioned envelope with a UUID, a team-local sequence number, sender, recipient, kind and body. It moves `queued → delivering → delivered`, or ends `failed` or `cancelled`. A delivery receipt is written only after the engine accepts the input.

- Pipelines hold messages for future stages until that stage runs.
- Busy members get new messages after their current turn.
- Automatic delivery pauses when the team is blocked, awaiting review or at its delivery limit. You can inspect queued context and deliver it yourself.

| Limit                   | Value                             |
| ----------------------- | --------------------------------- |
| Members per team        | 8                                 |
| Delivery limit          | 1–50 turns, including first turns |
| Message and report size | 16,000 characters                 |
| History                 | 1,000 messages                    |

## Portraits

Each of the 33 distinct prebuilt roles has its own Cleetus portrait, and unrecognized roles get a generalist. Portraits describe a specialty. They don't grant permissions or show progress; the engine, model, effort and status labels next to them do.

## After a restart

Completed, cancelled, failed and interrupted runs keep their output and messages, read-only. Work owned by a stopped coordinator becomes **interrupted**, and queued handoffs are cancelled rather than replayed. Saved history never means an agent process was reattached.

[Tasks](TASKS.md) · [Encrypted LAN collaboration](COLLABORATION.md) · [Tools, MCP and approvals](TOOLS.md)
