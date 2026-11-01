# Connect coding agents

**Available now:** Cleetus IDE 0.2.0 and extension 1.12.1 are published. See [installation and release notes](INSTALL.md) for downloads, provider setup and capability limits. IDE and extension releases remain independent.

Connect your own installed coding agent to Cleetus through the Agent Client
Protocol (ACP). The catalog includes GitHub Copilot, Amazon Q / Kiro, Gemini CLI,
OpenCode and the additional profiles listed below. ACP connects
a compatible coding agent to Cleetus conversations and agent workflows over its
documented stdio interface.

Use the [installation guide](INSTALL.md) for accepted downloads. A documented
launch profile does not establish real-account inference or every optional
provider capability. Install and sign in with each provider independently.

This guide applies to builds with **Cleetus: Connect coding agents** in the
Command Palette. If that command is absent, your installed build does not include
this connection flow; check its release notes before updating. Extension and IDE
releases remain independent. The release links in the [installation guide](INSTALL.md)
do not by themselves establish ACP feature availability.

Your [Cleetus account](ACCOUNTS.md) is separate from coding-agent access and
billing. Claude API/cloud and Codex retain their [existing setup](INSTALL.md#connect-your-engines).
Claude Code uses the separate [guided setup](#connect-your-own-claude-code) below.
Connecting an ACP agent does not convert those engines or their saved conversations.

The catalog has sixteen opt-in ACP profiles, including Kilo Code. The guide also
explains reviewed native teammate reconnects and pending-request ownership.
The setup and continuation steps below distinguish opening an existing native
terminal from approving a new connection or handoff.

## Install and sign in with your own CLI

Install each provider's CLI using its official instructions, outside your project
directory. Cleetus does not bundle or automatically install these runtimes. Your
account, provider access, subscription requirements and usage charges remain with
the provider.

| Connection | Official installation | ACP launch used by Cleetus | Native sign-in |
| --- | --- | --- | --- |
| GitHub Copilot | [Copilot CLI setup](https://docs.github.com/en/copilot/how-tos/copilot-cli/set-up-copilot-cli) | `copilot --acp --stdio` | `copilot login` |
| Amazon Q / Kiro | [Kiro installation](https://kiro.dev/docs/getting-started/installation/) | `kiro-cli acp --agent-engine=v3` | `kiro-cli login` |
| Gemini CLI | [Gemini CLI installation](https://geminicli.com/docs/get-started/installation/) | `gemini --acp` | Start `gemini` and follow its sign-in flow |
| OpenCode | [OpenCode setup](https://opencode.ai/docs/) | `opencode acp` | `opencode auth login` |

These profiles use the same connection flow:

| Connection | Official installation | ACP launch used by Cleetus | Native sign-in or setup |
| --- | --- | --- | --- |
| Cursor | [Cursor CLI installation](https://cursor.com/docs/cli/installation) | `agent acp` | `agent login` |
| Auggie CLI | [Auggie installation](https://docs.augmentcode.com/cli/setup-auggie/install-auggie-cli) | `auggie --acp` | `auggie auth login` |
| Mistral Vibe | [Vibe installation/setup](https://docs.mistral.ai/vibe/code/cli/install-setup) | `vibe-acp` | `vibe --setup`, a separate executable |
| Factory Droid | [Droid setup](https://docs.factory.com/ide-integrations) | `droid exec --output-format acp` | Start `droid` and complete its native setup |
| Goose | [Goose installation](https://goose-docs.ai/docs/getting-started/installation/) | `goose acp` | `goose configure` |
| Kimi Code CLI | [Kimi installation](https://github.com/MoonshotAI/kimi-code) | `kimi acp` | `kimi login` |
| Cline | [Cline CLI setup](https://docs.cline.bot/usage/cli-overview) | `cline --acp` | `cline auth` |
| Junie | [Junie CLI setup](https://junie.jetbrains.com/docs/junie-cli.html) | `junie --acp true` | Start `junie` and complete its welcome authentication |
| Qwen Code | [Qwen Code setup](https://github.com/QwenLM/qwen-code#installation) | `qwen --acp` | Start `qwen`, then use `/auth` |
| Qoder CLI | [Qoder installation](https://docs.qoder.com/cli/installation) | `qoder --acp` | Start `qoder` and complete its native authentication |

These commands refer to independently installed executables. The new profiles
keep their exact documented ACP arguments; choose models and effort through
negotiated session controls. Do not substitute a package launcher or add flags
to change authentication, transport or approval policy. Cursor's executable is
named `agent`; review its absolute path rather than assuming the name identifies
the vendor. Mistral's setup needs the full `vibe` CLI as well as `vibe-acp`.

The ACP column is a launch reference. An ACP command waits for protocol messages
from its client; it is not the CLI's ordinary interactive chat or login command.

GitHub marks [Copilot ACP](https://docs.github.com/en/copilot/reference/copilot-cli-reference/acp-server)
as public preview. AWS has [rebranded Amazon Q Developer CLI to Kiro](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/upgrade-to-kiro.html);
this connection uses Kiro V3, not a legacy `q` executable or the V2 private API.
Kiro documents the [explicit V3 launch and CLI-owned authentication](https://kiro.dev/docs/cli/v3/acp-migration/).
Gemini's current [configuration reference](https://geminicli.com/docs/reference/configuration/)
documents `--acp`; OpenCode documents [ACP stdio support](https://opencode.ai/docs/acp/).
Use a provider version that supports its documented command.

## Connect in VS Code or Cleetus IDE

1. Open the project folder you intend to work in.
2. Run **Cleetus: Connect coding agents** from the Command Palette. In the VS Code
   extension, **Get started → Connect more coding agents** opens the same flow.
   In the native IDE, **Agents** in Studio's top bar opens it.
3. On the provider card, choose **Installation guide** if needed, then
   **Refresh installed agents**. **Installed** means Cleetus found a usable local
   executable. It does not establish sign-in or model access.
4. If the editor cannot find your CLI, expand **Executable and launch arguments**
   and enter its absolute executable path. Arguments are a JSON array of separate
   strings. Keep the provider's default ACP arguments.
5. Choose **Sign in with provider** when needed. Review the launch approval, then
   finish the provider's native sign-in in the editor terminal and its browser
   flow. Cleetus does not collect the credentials or copy them into an SDK.
6. Choose **Connect**. Review the exact executable, resolved path, arguments and
   project in the approval dialog. **Enabled** means the connection is registered
   for use in Cleetus.
7. Optionally choose **Check protocol**. This starts the CLI to check its ACP
   handshake. Refresh models in the conversation or agent settings, then send a
   small, bounded request and review its actual result.

**Refresh installed agents** performs filesystem discovery without starting a
CLI. **Check protocol** and model discovery can start an ACP process and may
encounter authentication requirements. A successful handshake does not establish
that inference, a particular model, or a provider tool call will succeed.

Protocol checks and model discovery require a
separate host review of the exact executable, arguments and project before
launch. Discovery can load the provider's project configuration, startup hooks
or MCP connections; it is not a read-only filesystem check. Cleetus sends no
inference prompt for metadata discovery. Declining the review leaves metadata
unknown. A changed executable, configuration or project requires fresh review.

### Browse models without starting providers

Passive browsing is separate from explicit discovery. Opening Studio,
the conversation dock, chat, Design or team settings reads the last approved
ACP catalog without starting a provider. Choose **Refresh models** to discover
models for the selected engine/backend. Task, team-member and workflow setup
have refresh controls beside their own choices. Each active discovery still
requires fresh review; approving discovery never approves a later work session.

Effort choices and resume support use the same guarded project metadata.
An effort list from one model is not offered for a different model. When a
provider does not report the current model’s choices, keep **Engine default**;
Cleetus does not guess. An already-live chat can show its own session’s reported
efforts. Saved unavailable overrides stay visible until you change them, and
team inheritance never takes an unrelated session’s settings.

Catalogs expire within five minutes and are scoped to the opened project,
connection settings and executable identity. Symlink and canonical paths to the
same folder share its catalog; removed or retargeted paths invalidate it. Changed settings, a replaced
binary, denial, failed cleanup or project removal invalidates them. Saved model
choices and drafts remain visible, but stale explicit models cannot start work.
Refresh or use **Engine default**. A cached catalog is not a connected-account,
model-entitlement or cost claim. Older builds may request discovery when a panel opens; check your installed
release notes.

If installation changed the PATH, restart the editor so it receives the updated
environment, or use an absolute executable path. No shell expansion is applied:
`~`, environment assignments, pipelines and combined command strings are not
executable paths. Windows `.cmd`, `.bat` and `.ps1` launch wrappers are unsupported
by this direct-executable connection path; Windows provider execution needs
separate verification.

## Connect Kilo Code

Connect **Kilo Code** using your independently installed CLI.
Install it using [Kilo's official CLI guide](https://kilo.ai/docs/code-with-ai/platforms/cli),
then complete `kilo auth login` in its own terminal flow. In Cleetus, open
**Agents**, refresh installed agents and choose **Connect** on the Kilo card.
Review the executable and project before enabling it. It starts disabled.

Cleetus launches exactly `kilo acp`; login remains a separate explicit action.
Keep those arguments unchanged. Use **Refresh models** to discover the configured
provider's current models and effort, then choose **Engine default** or an
advertised choice. Installed, signed in, model access and successful work are
separate observations. Cleetus does not copy Kilo credentials or configure its
provider on your behalf.

Kilo retains its native permission rules. Some actions can run without an ACP
approval request; startup can load native plugins and MCP tools, and background
work can outlive a conversation. Cleetus relays the one-time permission requests
Kilo sends, rather than intercepting every native action. Review Kilo's own
configuration and any remaining work when closing it.

This profile was checked against [Kilo CLI v7.8.18](https://github.com/Kilo-Org/kilocode/releases/tag/v7.8.18),
with an [MIT-licensed implementation](https://github.com/Kilo-Org/kilocode/blob/b81761530650f8ec7b071441f4f54d2514f1a244/LICENSE).
Controlled protocol fixtures cover client compatibility; they are not a live
Kilo sign-in, inference test or certification of provider cleanup.

## Docker Agent configuration and cleanup

**Docker Agent** uses an explicit local agent configuration. Install your own
[Docker Agent](https://github.com/docker/docker-agent/blob/v1.154.0/docs/getting-started/installation/index.md)
and complete `docker-agent setup` outside Cleetus. This profile runs exactly
`docker-agent serve acp <local-agent-file>`; it does not bundle a CLI, start a
package installer or accept an OCI/URL agent reference as that file.

Choose a local `.yaml`, `.yml` or `.json` agent configuration on its connection
card, check it, then connect. Review the canonical file, its SHA-256, executable
and project before launching. Configuration contents are not copied into Cleetus
settings. Native configuration can load hooks, MCP servers, containers or images
and can select native update behavior. The review is not a claim that Cleetus
has inspected every action the native agent may perform.

A changed file, binary or project invalidates the reviewed launch and cached
metadata. Cleetus requires Docker Agent to negotiate **strict** session mode;
missing support or a later mode change stops the connection instead of falling
back to a permissive mode. Model and effort choices still require actual metadata.

Every launch, including a protocol/model check, creates a private recovery receipt
before starting the process. Clean completion requires a negotiated session-close
acknowledgment and confirmed cleanup of the process Cleetus owns. If either is
uncertain, subsequent launches are blocked, including after an editor restart.
Inspect native work and cleanup first, then choose **Review cleanup** on the
connection card and review the exact record. Each review clears one saved launch
at a time. Recovery clears local uncertainty;
it does not kill a saved PID, undo native work or automatically restart an agent.
Corrupt recovery data is preserved and fails closed rather than being discarded.

## Understand an ACP turn result

Cancellation stays **Cancelled**; token limits, request limits, refusal
and unknown outcomes cannot become a successful workflow result. A stopped or
unsuccessful turn discards queued follow-ups and reports them as **not sent**.
Review the saved messages before sending again; Cleetus never silently replays
them. A completed provider turn still does not prove that the requested tests or
product work succeeded. Review its evidence.

ACP connections have no Cleetus context-usage meter unless that exact session
advertises the capability. Completing a turn does not trigger an unsupported
usage request or replace the draft with an error.

## Keep model and effort settings together

Model and effort changes are applied in order to the exact ACP
conversation. Changing a model clears the previous explicit effort; choose an
effort advertised for the new model, or keep Engine default. Cleetus records
acknowledged settings rather than allowing a late reply from the old model to
replace the current choices. If a later setting fails, earlier acknowledged
changes remain visible. This is configuration acceptance, not proof of model
quality, account access or task completion.

Discovery also belongs to the reviewed project directory. If that directory is
removed or replaced during approval or after discovery, cached choices become
unavailable. Refresh and review the current project before launching; an identical
path name does not restore the old approval.

## Review screenshots with a connected agent

Shared Cleetus chat supports negotiated ACP image input. Choose the
agent, then use **Refresh models** to review discovery for that connection.
**Attach image** becomes available only when the approved metadata, or the exact
live conversation, reports image input. Opening chat does not start discovery.

Attach up to **four PNG or JPEG images totaling 512 KiB**, write your request and
send. Cleetus validates the format, bytes and full request size. Unsupported,
invalid or oversized input is rejected locally; the composer retains a rejected
message draft. Larger screenshots need a smaller export. Input-format support
does not prove that the selected model has vision or that your account can use it.
Check the provider's own model capabilities.

For a saved disconnected ACP conversation, choose **Reconnect agent**. Review the
fresh native launch approval; reconnect sends no draft or inference prompt. The
provider must support resuming that conversation. Denial or unsupported resume
keeps the draft; start a new conversation explicitly when needed.

A submitted draft remains in the composer while launch approval and local
preparation are pending. Denial or preflight rejection preserves its text and
attachments. A late acceptance does not overwrite text you edited meanwhile.
Acceptance means the request was prepared or queued locally; it is separate from
provider delivery, a linked reply and successful task completion. Failed work is
never automatically replayed.

Approved Design references use this same live capability and image budget.
Cleetus checks the approved file's hash and path identity before attaching bytes.
A text-only connection still receives the source reference and guidance, with an
explicit note that image bytes were not attached. That reference does not imply
that the agent saw the mock. Claude API/cloud and Codex keep their existing image
interfaces. Hosted Claude Code image input remains in its native interface;
Cleetus does not invent an unsupported channel image transport.

## Copilot conversation actions

An already-live ordinary Copilot conversation can show
**Copilot · Compact** and **Copilot · Context** above the composer. Cleetus offers
only commands currently advertised by that exact provider session. No metadata
process or new work session starts when you open these controls, and your draft
stays intact. Actions use the normal session's permission and cancellation path.

If a command disappears, the provider removed it or the session disconnected.
Reconnect explicitly when needed. These ordinary-conversation controls do not
restart or take over task, team or workflow agents, and a generic response Retry
does not repeat a context command. Other providers keep their own supported
interfaces; Cleetus does not invent a universal slash-command transport.

## Use a connected agent

Choose the enabled engine in a conversation, team member, task or Design agent
setting where that engine is offered. Review the working directory and MCP
assignments before starting. Team templates provide starting settings; inspect
each member's engine and use **Engine default** when a model is not yet known.
Supervised teams require a supervisor engine that supports Cleetus coordination;
Claude and connected ACP engines support this path. Codex can join as a member.

Model and effort choices come from the running agent's advertised metadata.
They may vary with CLI version, provider, account and session. An absent choice
is not replaced with a guessed model name or High effort. A configured choice is
not evidence of what executed; rely on reported results. Account details remain
unknown when the provider does not report them. This ACP connection does not
supply a subscription usage or cost meter.

ACP does not guarantee feature parity between agents. Resume depends on the
running provider's advertised support. Use the bounded negotiated image input above. Session forks, rewind,
client-side file access and client terminal tools remain unavailable.
MCP support depends on the provider's negotiated capabilities and your explicit
assignments. An agent can still have its own native tools and configuration.
In particular,
[Cursor's question/plan extensions](https://cursor.com/docs/cli/acp) are not
implemented by this ACP client, and [Qoder's client filesystem/terminal
callbacks](https://docs.qoder.com/cli/acp) remain unavailable. A provider can
advertise features that this client does not offer. Goose's native keyring may
require OS interaction. Review provider startup configuration before connecting
or approving metadata discovery; native hooks and tools remain provider-owned.

## Review permissions and connection changes

Enabling a connection approves that exact local launch configuration. It does
not approve every later tool action. When an agent sends an ACP tool-permission
request, Cleetus offers a one-time approval. It does not return persistent
"allow always" choices. Missing approval UI, cancellation, timeout or an
unsupported permission request denies or cancels the request.

These approvals cover requests the provider sends through ACP. The CLI retains
its native access and configuration; a custom executable is not sandboxed by
Cleetus. Use a trusted provider executable and review its own tool policy.
Connection profiles reject known approval-bypass flags, including `--yes`,
`--allow-all-tools`, `--no-permissions` and `--dangerously-skip-permissions`, as well as credentials
and environment overrides. Complete authentication through the provider instead. Fast-agent’s `--no-home`
is also refused because that program documents it as disabling ACP tool prompts;
unrelated providers’ ordinary home-directory options are not treated as the same
flag. These checks do not sandbox an arbitrary trusted executable.

Choose **Disconnect** to disable a connection. Use **Close conversation** in the IDE agent workspace or **Close agent connection**
in VS Code chat to retain history while closing the provider. Close all live Cleetus
sessions before disabling it or changing its executable or arguments; an idle
open session still counts as live. Disconnecting retains saved conversations and
does not sign out of the provider. Changing engines does not migrate a native
session between vendors. Stop interrupts work; review any changes already made.

If settings or the executable change while an approval is open, Cleetus rejects
the stale request. Refresh the connection panel and review the new configuration.
Invalid external settings edits surface an error while retaining the previous
registered engines; repair the settings before making further connection changes.

Cleetus asks an ACP provider to close its session when that exact
connection advertises session-close support. Cleetus waits for a bounded reply,
then cleans up the child process it owns even if the optional close request
fails or times out. A reply or process exit does not certify cleanup of native
plugins, containers or background work. Docker Agent retains its stricter
[cleanup receipt and review](#docker-agent-configuration-and-cleanup) requirements.

## Use cloud or local models through OpenCode

The existing OpenCode connection can expose models from providers configured in
OpenCode, including local runners. Configure the provider in OpenCode first using
its [provider guide](https://opencode.ai/docs/providers/); keep API keys and native
sign-in there. Cleetus does not import that credential file. OpenCode documents
Ollama, LM Studio and OpenRouter among its provider options.

Then enable **OpenCode** in Cleetus and choose **Refresh models** for that project.
Select only a model that the approved ACP connection actually advertises; leave
Engine default when metadata is absent. Local model availability, tool behavior,
image support and account access still depend on that native configuration.
The documented transport remains [`opencode acp`](https://opencode.ai/docs/acp/).
This reuses one engine connection rather than creating fake model-specific agents.

## Connect another ACP agent

Expand **Custom ACP connection** and use the provider's documented stdio server:

| Field | Example to replace with your provider's actual configuration |
| --- | --- |
| ID | `acp-my-agent` |
| Name | `My coding agent` |
| Executable | An independently installed executable name or absolute path |
| Arguments (JSON array) | `["acp"]`, only if your provider documents that argument |

Choose **Review and connect** and inspect the exact launch approval. Custom ids
start with `acp-` and use lowercase alphanumeric segments separated by hyphens.
Cleetus accepts up to 32 saved connection profiles. Arguments are limited to 32 strings, 4096 bytes each and 16 KiB
in total.

Custom connections support ACP stdio only. An arbitrary terminal CLI, MCP server,
interactive text stream or shell script does not become an integrated coding
agent by adding a profile. Cleetus does not parse terminal text into chat or
install an ACP wrapper automatically. Use the custom provider's own login flow;
Cleetus cannot invent its authentication command or infer its account entitlement.

Executables inside the project are refused, including symlinks that resolve into
the project or project-local links to external programs. Relative or empty PATH
entries are ignored. Shells, shell builtins and command/package wrappers such as
`sh`, `env` and `npx` are not accepted as agent executables. Install the agent
independently and select its actual executable.

## Why some agents are not in the catalog

Cleetus checks more than an ACP handshake before adding a default connection.
The [current OpenHands CLI repository](https://github.com/OpenHands/OpenHands-CLI/blob/283c6ac3610f4299f405f7389f65766dcb83e12a/README.md) declares that active maintenance ended;
Agent Canvas consumes other agents rather than replacing it as an ACP server.
VT Code is maintained, but its [reviewed session implementation](https://github.com/vinhnx/VTCode/blob/07377ab34da87004ae39080e5640af7cb3676626/crates/codegen/vtcode-acp/src/zed/agent/session_state.rs) does not preserve
Cleetus's supplied MCP servers/working directory and does not establish drained
execution through its close acknowledgment. These remain deferred. A custom ACP
profile is not a certification of lifecycle or team coordination support.

Fast-agent and Mercury CLI are maintained candidates, but neither is advertised as
a new default coding connection here. Fast-agent’s [reviewed local-shell path](https://github.com/evalstate/fast-agent/blob/3d77d78eee2f9160ca6c290ded47fc47825d2b3d/src/fast_agent/tools/shell_runtime.py#L3041)
needs separate permission and persistent-process cleanup acceptance. Mercury’s
[reviewed ACP runner](https://github.com/Whq02/MercuryCLI/blob/6bdac28aa95ef3133d0ecd8ee907f86ec9908d6d/src/services/acp/childSession.ts#L396)
needs confirmed child cleanup and resumed-mode checks. Its third-party Claude
subscription sign-in is not endorsed as an Anthropic-authorized route. A custom
profile or successful handshake does not establish those guarantees.

## Troubleshooting

| Symptom | Next step |
| --- | --- |
| Command or provider cards are absent | Confirm your installed build includes **Connect coding agents**. Check that product's release notes; IDE and VSIX versions update independently. |
| Not installed, although the CLI works in a terminal | Check the editor's PATH, restart after installation, or enter an absolute executable path. Check file execute permissions and the project/symlink restrictions above. |
| Installed or Enabled, but requests fail | Complete native sign-in and verify the model/account with the provider CLI. File discovery and registration do not verify entitlement. |
| Check protocol fails or waits | Verify the provider version and default ACP argv. Complete login separately. Ordinary interactive commands and legacy launch flags do not satisfy the stdio contract. |
| Kiro fails to initialize | Use a Kiro CLI with V3 ACP support and keep `acp --agent-engine=v3`. Client-owned token authentication and the V2 private-method adapter are not supplied. |
| No model or effort choices | Refresh live metadata after signing in. Keep Engine default or leave effort unset when the agent advertises no supported values. Do not copy another provider's model ids. |
| Tool action is denied | Inspect the request and the host approval. Only one-time permission options are supported; do not add bypass flags to suppress the prompt. |
| Cannot change or disconnect an agent | Close its live sessions, then refresh and retry. Saved history can remain. |
| Settings changed during approval | Refresh and review the exact new launch configuration. Do not reuse the stale approval. |
| Custom CLI produces invalid output | Confirm it implements ACP stdio and reserves stdout for protocol messages. Use its own documentation for supported logging and authentication. |
| Claude Code sign-in does not open a browser or requests a code | Choose **Open native setup** in the Claude Code card and complete the provider's own terminal flow. Cleetus does not collect login URLs, tokens or verification codes. |
| Claude Code is installed but its authentication is unknown | Use **Refresh status** or explicit native setup. Installed, signed in and subscription entitlement are separate observations. |

This guide describes implemented connection behavior and provider documentation.
It does not report successful real-account inference or tool execution for every
listed CLI. Validate your own provider/version with a bounded request and inspect
the actual output and changes. For other problems, see [troubleshooting](TROUBLESHOOTING.md).

## Connect your own Claude Code

**Get started → Claude Code → Connect Claude Code** opens the shared
**Coding agent connections** dialog. You can also run **Cleetus: Connect coding
agents** or choose **Agents** in native Studio. The **Claude Code** card runs your
own unmodified Claude Code installation; this is separate from ACP and from the
Claude API/cloud SDK engine.

1. If the CLI is unavailable, choose **Installation guide** for
   [Claude Code's official setup instructions](https://code.claude.com/docs/en/setup).
   Install it independently, then choose **Refresh status**. Cleetus does not run
   an installer or bundle the CLI. You can check installation and sign in before
   opening a project.
2. Choose **Connect**. Cleetus checks the CLI's own authentication status. If it
   already reports a sign-in, Connect reuses it without starting another login.
   If sign-in is needed, review the exact native CLI launch approval.
3. **Sign in / change account** explicitly starts the CLI's `claude auth login`
   flow. A browser may open. Claude Code owns authentication and its callback;
   Cleetus supplies no OAuth page, captured login URL, token field or code
   collector. Starting that process does not prove sign-in completed.
4. If a browser does not open, cannot finish, or asks for a manual code, choose
   **Open native setup**. This explicitly opens Claude Code's own setup in an
   editor terminal. Complete any manual-code step there. **Cancel setup** stops
   the setup owned by this connection.
5. Choose **Enable hosted Claude Code** to review the separate settings opt-in,
   then choose **Reload Cleetus** when offered. This enables the **Terminal
   agents** engine; it does not complete authentication or enable custom channels.
   The channel setting remains unchanged and defaults to off.
6. Once the engine is enabled and the card reports sign-in, open your project
   and choose **Use in Cleetus**. This selects **Terminal agents** in the composer.
   It does not launch an agent, send a goal or perform inference. Starting work
   remains a separate action.

The card distinguishes **Installed**, **Signed in**, **Not signed in** and
**Sign-in status unknown**. It labels the reported authentication as **Claude
account**, **API credentials**, **Cloud provider** or **Authentication unknown**.
A displayed plan is a sanitized value reported by the CLI, not an entitlement
check. Your subscription is used only when Claude Code selects Claude account
authentication; native API or cloud configuration may take precedence. Cleetus
preserves that configuration and environment rather than stripping overrides.
These labels do not guarantee billing, usage allowances, model access or quotas
for parallel agents. Usage remains with the provider.

While setup is active, the open dialog checks status every four seconds, with
one polling read at a time, for at most ten minutes. Status updates preserve
unsaved ACP connection fields. **Cancel setup** and **Open native setup** do not
wait for an outstanding UI polling read before sending their control requests.
Closing the dialog stops its UI polling; it does not itself cancel the separately
bounded native setup. Reopen the dialog and choose **Cancel setup** if you want
to stop that setup. Native setup also has a ten-minute deadline.

The ordinary Terminal agents mode can still require interaction in Claude Code's
terminal. Guided sign-in does not make every native prompt available in Cleetus.
Existing Claude API/cloud and Codex conversations remain separate and are not
converted into hosted Claude Code sessions. The development-only structured
interaction flow below adds two supported native prompts; it does not replace
all native setup or tool interfaces.

### Continue an ordinary Claude Code conversation

**Complete native setup**, **Open Claude Code** and
**Review in Claude Code** focus the exact existing terminal when it is available.
Use it for sign-in, folder trust, channel consent or an unsupported native prompt.
A setup-pending connection is not a reason to launch another Claude Code process.

When an ordinary connection has retired, choose **Reconnect conversation** in
Studio and review the saved conversation and project. Reconnect opens a fresh
connection to its history without sending the composer draft or replaying its
previous prompt. While the review is pending, **Reconnecting…** stays disabled
through refreshes and your draft remains available. Repeated requests for the
same conversation share the pending review. If the existing transport connects
while you are reviewing, Cleetus keeps that connection instead of replacing it.
A changed project or connection requires a fresh decision.

Task and team conversations remain owned by those workflows. Use the owning
Tasks view or [reviewed teammate reconnect](TEAMS.md#reconnect-a-native-teammate-for-a-queued-handoff)
for new work; ordinary conversation reconnect cannot take them over. Native
setup and a connected transport still do not establish a correlated reply,
provider access or successful completion.

## Maintainer-only local channel preview

For maintainers developing and reviewing a Cleetus channel locally, compatible
beta builds expose an opt-in **local development** experiment. This is separate
from guided Claude Code setup. Production channel distribution and publisher
approval remain unconfirmed; enabling the experiment does not establish them.
To test a channel you are developing:

1. Open Cleetus **Settings → Preferences** (in native Studio, use the
   **Workspace → Settings** menu).
2. With hosted Claude Code explicitly enabled as described above, set
   `terminalAgentsChannelMode` to `development`. Save preferences, then run
   **Developer: Reload Window**. Guided setup never turns this setting on for you.
3. Select **Terminal agents** in the grouped model list and start a bounded
   conversation or a reviewed team member.
4. When Cleetus offers **Complete native setup**, open Claude Code and complete
   its own sign-in, folder trust, initial MCP consent and development-channel
   confirmation. These steps cannot be answered by the Cleetus channel.
5. After the channel connects, use the Cleetus agent workspace and conversation
   dock for messages, replies and supported one-time tool decisions. A connected
   local transport and a reply linked to a channel message are separate
   observations; only the latter establishes a working channel round trip.
   **Sent to channel** means transport delivery. **Reply linked** means the agent
   explicitly associated a reply with that message; it does not mean the task is
   complete. Expired Cleetus approval windows and reused request IDs retain a
   **Review in Claude Code** action. They cannot grant a new approval or prove
   that the native prompt closed.
6. Use **Open Claude Code** for unsupported native prompts, or reconnect an
   ordinary disconnected conversation explicitly. Task/team work must restart
   through its own authorized execution path.

### Visible narration, questions and plan review

This section describes the local development preview. It requires the native
setup and channel consent above; the platform release does not establish
production channel approval.

Cleetus can display assistant text that Claude Code makes visible through its
native display hook, including streamed narration. It does not scrape terminal
text, read hidden reasoning or reconstruct tool output. Incomplete or truncated
narration remains marked; inspect Claude Code when delivery is incomplete.

Cleetus reconciles final narration when Claude’s completion and display
notifications arrive out of order. The same final message appears once; equal
answers on separate turns remain separate. Saved journals are preserved.
Narration alone does not establish channel readiness: **Reply linked** still
requires a response correlated with a specific channel message. Neither state
establishes task completion.

Two structured native tools can appear in the agent workspace and dock:

- **Questions** (`AskUserQuestion`): choose the requested single or multiple
  options, or write a non-secret Other answer. No option is preselected. Answer
  every question, choose **Send answers**, then review the exact questions,
  answers, agent and project in the host's **Allow / Deny** dialog.
- **Plan review** (`ExitPlanMode`): inspect the plan, choose **Approve plan**, then
  review that exact plan in the host dialog. This does not approve ordinary
  tools, save permission rules or change the agent's permission mode.

**Decline** rejects the request. **Review in Claude Code** explicitly hands it
back to the provider. A Cleetus interaction expires after 110 seconds; stale,
duplicate, cancelled or expired requests cannot grant a fresh response. An
expired window does not prove the provider's prompt closed. Keep passwords,
API keys, sign-in codes, folder trust and initial MCP/channel consent in the
provider's own setup. Unsupported native prompts also remain there. These two
Claude Code tools do not add support for other vendors' private ACP extensions.

This requires a Claude Code version with the documented
[channels feature](https://code.claude.com/docs/en/channels) and any applicable
organization permission. Custom development channels require Claude Code's own
explicit confirmation. Hosted mode and custom channels default to off; native
consent and production approval are separate requirements. This preview does not
promise that downloaded production channels can use the development path or that
all Claude Code interactions can move into Cleetus.

### Reviewed installed-channel deployment

For administrators and maintainers, Cleetus also has a separate
**plugin** channel mode. It uses the ordinary `--channels plugin:<exact-id>`
path and an already installed, enabled Cleetus channel. It never uses the
local-development flag as a production fallback or installs a plugin for you.

Before selecting it, obtain the reviewed channel artifact and its independently
trusted `artifact.json` SHA-256. Complete the provider's normal installation,
enablement and applicable organization/public approval process. Then set these
Cleetus preferences and reload:

- `terminalAgentsChannelMode`: `plugin`.
- `terminalAgentsChannelPlugin`: an object with exactly `directory` (canonical
  installed directory), `manifestHash` (reviewed SHA-256), and `pluginId` (the exact
  installed `cleetus-ui@marketplace` identity).
- `terminalAgentsChannelNode`: the absolute canonical path to your independently
  installed Node executable.

Every launch and resume verifies the exact artifact contents and fresh CLI
installation metadata, including identity, loaded path, version, scope and
project. Failed checks prevent that launch. Only the current private Cleetus
channel grant and Node binding are added to its terminal; provider authentication
variables remain inherited. **Installed** and **enabled** describe installation
metadata, not Anthropic approval. Claude Code still enforces its policy and
native consent, and Cleetus reports readiness only after a linked reply.

This path has local fixture and packaging validation. Production public-channel
approval and a live administrator-approved installation have not been verified
for Cleetus. Keep channel mode **off** unless you are developing the channel or
have completed the applicable reviewed deployment prerequisites.

Native connection checks, sign-in subprocesses and ACP launches preserve the
host's original launch environment before Cleetus applies SDK-specific provider
settings. They do not copy credentials into connection profiles, terminal
options, MCP configuration or logs. Shell profiles and editor terminal-specific
environment settings can still differ; use **Open native setup** to inspect the
provider's own current sign-in when needed.
