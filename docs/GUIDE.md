# Agent Command and conversations

**Available now:** Cleetus IDE 0.2.0 and extension 1.12.1 are published. See [installation and release notes](INSTALL.md) for downloads, provider setup and capability limits. IDE and extension releases remain independent.

_Read this guide on [cleetus.dev](https://cleetus.dev/docs/agent-command/)._

Agent Command is where work starts. You describe an outcome, pick an engine, model and effort, and follow the run: plan, active agents, live execution, tasks and the files agents report. Conversations are the same engines in a chat you can attach context to, search and resume.

![Agent Command's goal composer with codebase, design docs and team context, model and effort pickers and Run agent](screenshots/detail-agent-command-composer.png)

## Give a goal

1. Connect your own coding agent in **Get started** or **Agents**. See [installing engines](INSTALL.md#connect-your-engines).
2. Describe the outcome, the constraints and how you'll check it. _"Improve the account settings layout with accessible controls, reuse the saved design system, and verify the responsive behaviour"_ beats _"fix settings"_.
3. Choose a discovered model or **Engine default**, and an effort that engine supports. Models come from the engine's own capability list, never a free-form name.
4. Choose **Run agent**. Cleetus saves the goal and a linked execution task, then asks before starting the run. The approval shows the project and working directory.

Builds with **Cleetus: Connect coding agents** also offer enabled ACP agents in supported engine pickers. See [Connect coding agents](CODING_AGENTS.md) for Copilot, Kiro V3, Gemini, OpenCode and custom stdio setup. Their model and effort choices depend on actual provider metadata; permission requests use one-time approvals.

Inspect actual tool requests and proposed diffs. Permissions may come from session rules, native engine modes, hooks or an explicit approval card. Stop interrupts execution; it does not undo earlier writes. Review the result and validate the changed project.

**Plan with team** opens team setup instead. See [Agent teams](TEAMS.md).

![Execution plan, active agents, live execution and current tasks for a ready team](screenshots/detail-agent-command-plan.png)

_A ready team: queued members, an empty live execution panel and no tasks yet. Nothing has started._

## What the cards mean

Agent Command shows saved local state and nothing else:

- **Requested models are configuration.** What actually ran shows up only once the engine reports it.
- **Cost and activity are never inferred** from a template or a ready team. A ready team with no runs shows "Cost unavailable", not a guess.
- **Agent logs** are actual execution output. **Reported files** are artifacts an agent explicitly reported, linked back to source.

Opening a draft, choosing a template or viewing the dashboard never starts an agent.

## Conversations

![Conversation workspace with history, chat and team view](screenshots/conversation.png)

Open a conversation from Agent Command, the action rail or **Cleetus: Open Studio**. Choose the engine, model, effort and permission mode, then attach files, selections, images or editor context.

- **Tool requests and diffs** appear inline. Approve, deny or edit them; see [approvals](TOOLS.md#the-permission-flow).
- **Stop** interrupts the engine. It doesn't undo earlier writes; review the project after stopping.
- **History** lets you search, group, bookmark, archive and export sessions. **Continue conversation** resumes the exact saved project session with its native engine identity.

![History drawer with search and grouped conversations](screenshots/history.png)

## How resume works

Each conversation is a core **session** with an engine ID, working directory, model, effort and permission mode. Final messages and tool and permission events are appended to a JSONL transcript in your profile; transient streaming frames aren't stored.

An explicitly approved ordinary reconnect reloads that transcript and recreates
the supported engine adapter with its own saved session ID. ACP resume requires
the provider to advertise that capability. It doesn't revive a suspended process, and changing engines never moves a session between vendors. A transcript is a record, not a running agent.

Task and team history remains read-only outside its owning workflow. Sessions
created for fenced task work offer **Inspect saved output** instead of continuing. New work on that task goes through its own run flow, so its [execution lease](TASKS.md#execution-leases-and-fencing) stays valid.

For a settled native teammate with a queued handoff, use the owning Teams view
and [Reconnect teammate](TEAMS.md#reconnect-a-native-teammate-for-a-queued-handoff).
Only its newly reviewed request starts a fresh turn; opening saved chat does not
restore old execution authority.

Your [Cleetus account](ACCOUNTS.md) is separate from all coding-agent sign-ins.
It does not supply provider subscriptions or change your existing free tools.

## Keyboard and commands

| Do this                    | How                                               |
| -------------------------- | ------------------------------------------------- |
| Focus Agent Command        | **Ctrl+Cmd+I** on macOS, **Ctrl+Alt+I** elsewhere |
| Open the full Studio       | **Cleetus: Open Studio**                          |
| Back to source and preview | **Cleetus: Open Development Workspace**           |
| Preview the current file   | **Cleetus: Preview Current File**                 |

[Agent teams](TEAMS.md) · [Tasks](TASKS.md) · [Tools, MCP and approvals](TOOLS.md)
