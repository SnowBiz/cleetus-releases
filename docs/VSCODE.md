# Use Cleetus in VS Code

Keep VS Code as your editor. The Cleetus extension adds project context, agent
conversations, crew, tasks, workflows, connection setup and review to the editor
you already use. Explorer, file tabs, Source Control, debugging, terminals,
installed extensions, themes and editor shortcuts remain VS Code features.

## Start with the Cleetus sidebar

Open **Cleetus: Open Cleetus** from the Command Palette or the Cleetus status-bar
item. The native sidebar contains:

- **Projects:** folders currently open in this VS Code window. Select a project
  to reveal it in Explorer. Feature pages retain their own explicit project
  selector; revealing a folder does not retarget a running conversation.
- **Agents:** stored and live conversations belonging to open projects. Select a
  conversation to open its existing transcript. Opening a view does not send a
  prompt, create a session or resume execution.
- **Crew:** existing saved and running teams with member status. Open crew
  configuration to choose templates, create teams and review explicit starts.
  The stored team format and existing commands remain compatible.
- **Tasks:** local goal, epic, story and task records, assigned crew work and
  observed agent tasks. These are separate sources, with their actual status.
- **Reports & output:** reports and output actually produced by crew members.

**Work** opens chat, crew, workflows, work tracking and pull-request review,
Design, and Memory & Rules. Feature pages reuse the existing Cleetus tools in a
focused editor panel. They omit the extra application sidebar and provide a
**Cleetus** link back to the native sidebar. Use VS Code to resize, move, split or
close these panels. The retained feature panel preserves its existing drafts
when switching areas.

## Save and review local tasks

Use the **+** action on Tasks or **Cleetus: Create Local Task** to choose a type
and enter a title, description and acceptance criteria. Saving creates pending
local work. It does not start an agent or require provider sign-in.

Select a local task to inspect its stored details. Right-click a pending task and
choose **Edit Pending Task** to edit its title, description or text acceptance
criteria. Existing structured criteria stay intact; this compact editor does not
rewrite them. Parent links, dependencies, assignments, ownership and evidence are
preserved. Concurrent board changes reject stale edits instead of overwriting
another window's work. A create, edit or review action also retires when its
original workspace context changes or trust is lost. Reopen the action after
returning to the project; restoring the same folder does not revive it.

For work in Review, choose **Review Reported Task**. Inspect the actual delivery
packet in VS Code before choosing approval or returning work for changes. Agent
claims, check receipts and human decisions keep their existing provenance. The
existing host approval then asks for the exact task decision. A missing or denied
approval does not complete work.

## Configure and run a task

Right-click pending local work and choose **Configure & Run Task**. Choose a
registered engine, a reported model and its supported effort. The backend shown
comes from that engine's current host configuration. Registration alone does not
confirm authentication or readiness. If model metadata is unknown, choose the
explicit refresh action or connect the provider first. Unknown metadata never
silently chooses a model. Some adapters also require an explicit refresh for the
selected model's scoped options.

Choose **Review and start task** to open the existing exact host approval. The
run uses the same Core task execution, ownership and evidence rules as other
clients. Cancellation, stale board revisions, lost Workspace Trust, removed or
changed projects, and denied approvals prevent a new run. A configuration retired
by a workspace change must be configured again even if the original folder is
reopened. This compact flow runs in the selected open project; it does not create
an isolated worktree. Choose a suitable workspace before reviewing execution.
Completed engine work requests review; it does not approve its own task.

## Connect only when needed

**Connections & settings** opens Providers, coding-agent setup, tools and MCP
connectors, existing phone/computer control, your account, and settings. Providers
is collapsed initially and can be expanded or pinned using VS Code's native view
controls. Opening the Cleetus launcher does not check credentials, initiate
sign-in or start a provider. Connection checks and execution are separate actions.

Local files, saved work and task authoring remain usable while providers are
disconnected. Unknown connection or model metadata is not readiness. Some
features require an installed runtime, account, explicit permission or the
separately distributed host capability; setup reports its actual availability.

## Existing installations

Previous commands, settings, shortcuts, conversation history and storage formats
are retained. **Cleetus: Open Workspace**'s command identifier
`cleetus.openControlCenter` now opens the native Cleetus sidebar. Use
**Cleetus: Open Legacy Workspace** under Advanced for the previous complete
workspace panel and its tools. The Cleetus standalone IDE retains its own native
layout and commands.

Workspace Trust is required for execution and local task mutations. Opening a
view never grants approval for a later action. Stopping agents and crew retains
its explicit confirmation and current-workspace validation.

## What ships in the extension

Treat every VSIX file as readable. The extension's public Apache-2.0 code includes
thin VS Code adapters and existing shared Core capabilities; it is not a place to
hide proprietary product logic. Packaging excludes the separately licensed native
Studio overlay, private enterprise implementations, optional Remote package,
repository-generated Design systems, internal engineering documents and secrets.
Only explicitly curated public documentation is included. Existing Apache and
third-party rights remain unchanged.

The extension does not embed the proprietary standalone IDE or promise private
capabilities through a new service. Optional features use their existing host or
service interfaces and report unavailable when the required capability is absent.
See [Licenses](LICENSES.md) and the notices shipped with your build.
