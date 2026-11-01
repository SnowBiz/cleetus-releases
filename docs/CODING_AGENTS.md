# Connect coding agents

Use your own installed GitHub Copilot, Amazon Q / Kiro, Gemini CLI or OpenCode in
Cleetus through the Agent Client Protocol (ACP). ACP connects a compatible
coding agent to Cleetus conversations and agent workflows over its documented
stdio interface.

This guide applies to builds with **Cleetus: Connect coding agents** in the
Command Palette. If that command is absent, your installed build does not include
this connection flow; check its release notes before updating. Extension and IDE
releases remain independent. The release links in the [installation guide](INSTALL.md)
do not by themselves establish ACP feature availability.

Claude API/cloud, Codex, and the Claude Code **Terminal agents** preview retain
their [existing setup](INSTALL.md#connect-your-engines). Connecting an ACP agent
does not convert those engines or their saved conversations.

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

If installation changed the PATH, restart the editor so it receives the updated
environment, or use an absolute executable path. No shell expansion is applied:
`~`, environment assignments, pipelines and combined command strings are not
executable paths. Windows `.cmd`, `.bat` and `.ps1` launch wrappers are unsupported
by this direct-executable connection path; Windows provider execution needs
separate verification.

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
running provider's advertised support. This connection does not provide image
input, session forks, rewind, client-side file access or client terminal tools.
MCP support depends on the provider's negotiated capabilities and your explicit
assignments. An agent can still have its own native tools and configuration.

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
`--allow-all-tools` and `--dangerously-skip-permissions`, as well as credentials
and environment overrides. Complete authentication through the provider instead.

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
Up to 16 connection profiles can be saved. Arguments are limited to 32 strings,
4096 bytes each and 16 KiB in total.

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

This guide describes implemented connection behavior and provider documentation.
It does not report successful real-account inference or tool execution for every
listed CLI. Validate your own provider/version with a bounded request and inspect
the actual output and changes. For other problems, see [troubleshooting](TROUBLESHOOTING.md).

## Hosted Claude Code UI preview

Hosted Claude Code follows a separate integration from ACP. It uses your own
unmodified interactive Claude Code installation. The ordinary **Terminal agents**
mode keeps interaction in Claude Code and shows reported activity in Cleetus.

For the opt-in **local development** channel experiment in compatible beta builds:

1. Open Cleetus **Settings → Preferences** (in native Studio, use the
   **Workspace → Settings** menu).
2. Enable `terminalAgentsPrototype` and set `terminalAgentsChannelMode` to
   `development`. Save preferences, then run **Developer: Reload Window**.
3. Select **Terminal agents** in the grouped model list and start a bounded
   conversation or a reviewed team member.
4. When Cleetus offers **Complete native setup**, open Claude Code and complete
   its own sign-in, folder trust, initial MCP consent and development-channel
   confirmation. These steps cannot be answered by the Cleetus channel.
5. After the channel connects, use the Cleetus agent workspace and conversation
   dock for messages, replies and supported one-time tool decisions. A connected
   channel and a received agent reply are shown as separate observations.
6. Use **Open Claude Code** for unsupported native prompts, or reconnect an
   ordinary disconnected conversation explicitly. Task/team work must restart
   through its own authorized execution path.

This requires a Claude Code version with the documented
[channels feature](https://code.claude.com/docs/en/channels) and any applicable
organization permission. Custom development channels require Claude Code's own
explicit confirmation. Both Cleetus experiment settings default to off;
production channel allowlisting and publisher requirements are not established
by enabling them. Existing API/cloud and Codex conversations are retained and
are not converted between provider modes.
