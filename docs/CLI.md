# Cleetus CLI

Cleetus in your terminal: choose a role, assemble a crew, review tasks and run a
headless host for your own coding agents. The CLI reuses Cleetus Core; it does not
start another orchestration system or include provider executables.

![Cleetus CLI in its western workshop](https://raw.githubusercontent.com/SnowBiz/cleetus-releases/main/docs/images/cleetus-cli-workshop.png)

## Choose your installation

Download a **Cleetus CLI** release from [Cleetus Releases](https://github.com/SnowBiz/cleetus-releases/releases).
CLI tags start with `cli-v`; IDE installers and VSIX files are separate products.
Use the version and filename on that release, and verify it against its
`CLI_SHA256SUMS` before installing.

The `.tgz` npm package and `-node22.tar.gz` portable archive contain the same
reviewed JavaScript tree. **Neither contains Node.js or a standalone native
executable.** For direct downloads, install Node.js 22 or newer and npm first; Homebrew
installs its own Node dependency. Linux x64 has a release CI gate, and the public
Linux ARM64 package and guided systemd setup have separate fixture acceptance.
macOS CLI remains a preview.

### Install with Homebrew

With [Homebrew](https://brew.sh/) installed:

```sh
brew tap snowbiz/cleetus https://github.com/SnowBiz/cleetus-releases
brew install snowbiz/cleetus/cleetus-cli
cleetus setup --workspace /absolute/project
cleetus --workspace /absolute/project
```

Homebrew installs Node 22 and the available CLI tools. On Linux, Cleetus offers
one local setup wizard when a working keyring is missing. Review any required
official OS packages and protected host installation; starting the host is a
separate approval. You can open that wizard directly with
`cleetus setup --workspace /absolute/project`.

Use `brew upgrade snowbiz/cleetus/cleetus-cli` for the terminal client. A protected
background host pins its own reviewed installation and needs a separate explicit
update; [Advanced](ADVANCED_LINUX.md) describes that procedure. Account sign-in,
provider CLIs, models and phone/LAN access are separate choices.

### Install and open your workspace

After downloading and verifying the `.tgz`, replace `X.Y.Z` with its actual
version. Install as your ordinary account:

```sh
npm install -g --ignore-scripts ./cleetus-cli-X.Y.Z.tgz
cleetus --workspace /absolute/project
```

npm installs the frozen TypeScript and Playwright Core libraries. It does not
install a browser, coding agent, model or provider SDK.

CLI 0.2.0 or newer offers the Linux setup wizard from the first terminal launch
or `cleetus setup --workspace /absolute/project`. Older builds must use their
matching release instructions.

A Linux desktop can use its unlocked Secret Service. A supported Ubuntu/Debian
server can use the [guided protected host](HEADLESS_CLI.md). There is no plaintext
fallback. macOS preview uses Keychain and Apple Command Line Tools; Windows is
not a supported CLI host. Node.js and provider requirements remain separate.

For portable archives, manual system/user units, updates and recovery, see
[Advanced](ADVANCED_LINUX.md).

Install coding agents through their own official instructions and sign in there.
Provider access, subscription restrictions, model/API charges and engine consent
remain separate. Local models use the configured server and its own resources.
For optional Design capture, install a supported Chrome/Chromium; esbuild belongs
in the project being rendered. See [coding agents](CODING_AGENTS.md) and
[Design](DESIGN.md).

## Start with a role or crew

```sh
cleetus roles --json
cleetus templates --json
cleetus --workspace /absolute/project --profile ~/.cleetus/cli
```

The terminal interface supports arrow keys, search and Enter. Review the selected
role’s prompt, engine, model and effort before launching. The shipped catalog
contains the shared 54 roles and nine prebuilt teams, with their actual pipeline,
parallel or supervisor behavior. Listing them starts no provider.

Run `cleetus signin` in an attached terminal. The CLI shows a short device code
and the fixed Cleetus verification page. Open that page in a browser on your
computer or phone, sign in, and explicitly approve the device details. The CLI
uses its private PKCE verifier to complete sign-in; no SSH callback forwarding is
needed. The code expires, so start a new sign-in if it times out.

You can review and revoke the device’s Cleetus account access from Account →
Devices. Revoking account access does not stop existing local agents, remove
phone pairings, or sign you out of independently installed coding agents. Engine
sign-in still belongs to each provider’s native flow.

`cleetus signin-loopback` is a separate legacy PKCE fallback. On SSH, forward the
callback port shown by that command (currently localhost:47615). That connection
is not represented as a managed CLI device in Account → Devices.

## Choose the Codex account for new conversations

Cleetus account sign-in and coding-agent sign-in are separate. To use an existing
Codex CLI account on this host, open **Codex account · existing CLI or isolated
profile** in the local Cleetus terminal menu. This setup requires the local
owner; it is not a phone or remote API account-switch command.

1. Choose **Status and cached model/auth metadata** to inspect the current choice.
   Metadata remains advisory or unknown until checked; a model list alone does
   not prove that the selected account can run a turn.
2. Choose **Use an existing native Codex CLI account for new conversations** and
   review its canonical, owned Codex home. Confirm the complete local account
   choice. Cleetus records a local binding; it does not read or copy credential
   bytes, sign the provider in or out, or import them into your Cleetus account.
3. Choose **Explicitly check selected Codex account (no inference)** to verify the
   selected runtime's current account metadata. If native sign-in is needed, do
   it in the independently installed Codex CLI using that same home, then check
   again. This check is not a completed model turn.

The existing profile's settings, instructions, hooks, plugins and MCP servers may
be loaded by official Codex. Inspect that profile before selecting it. Normal
provider operation may refresh its own credentials and write native history;
this is not a read-only clone of the profile.

For Cleetus-managed turns, the native account path uses fixed first-party OpenAI
routing selected from the authentication mode reported by official Codex. It
does not silently try another account or custom endpoint. Cleetus keeps
on-request approvals, the reviewed project scope and its workspace sandbox (or
read-only plan scope). An existing provider login does not automatically approve
commands. An unknown or changed authentication mode blocks dispatch rather than
guessing a route.

The choice affects **new conversations only**. Existing live and saved
conversations retain their pinned account home and runtime; changing the menu
does not migrate them. **Use isolated Codex for new conversations (saved pins
remain)** switches new work back to the isolated profile without copying native
credentials. This chooser does not reconfigure other engines or their sign-ins.

If the approved home/configuration changes or cannot be verified, inspect it
locally and explicitly review a new choice before new work. Preserve saved
sessions and their original profiles; do not edit pin records or automatically
replay an uncertain launch. Account checks, provider compatibility and actual
inference remain separate validation steps.

## Use managed roles and prebuilt teams

Open **Agents and prebuilt roles** in the terminal menu. **Browse managed role
prompts** shows each role’s complete instructions and catalog source/revision.
To work with one, choose **New conversation with a managed role**, select a
registered engine and backend, then an advertised model and supported effort.
You can keep the host default; the launch resolves it. Enter your goal and
constraints, then review the exact host request before execution.

Open **Teams and prebuilt crews** to inspect full templates or create a managed
team. The bundled catalog includes 54 roles and nine teams. A signed-in account
can explicitly refresh its published catalog; its source and revision remain
visible. Cached catalog data is a draft reference, not permission to run it.

Configure every indexed team member before creation. Inspect the member’s prompt
and task, choose its engine/backend/model/effort, and use **Preview complete
template and current overrides** to review the roster. **Create team** requires
an exact owner review and saves the team without starting agents. Later choose
**Inspect / start / chat / cancel a saved team** for the corresponding action.
Existing permissions, membership and provider support are checked at execution.

### Team chat

Open a saved team’s chat room to read its recorded messages and turn outcomes.
Send to the saved supervisor when the team has exactly one, or choose to send
sequentially to every member. The latter runs a separate model turn per member
and requires typing `ALL` to acknowledge that it may use paid tokens. Pending or
unknown operations block a new message until their outcome is inspected; the
CLI does not automatically resend one.

## Configure server-local models

Choose **Server-local Ollama / LM Studio model engine** to review a fixed
loopback server, explicitly discover its advertised models and save your
selection. This adapter uses your independently installed Codex CLI; verify that
it is available on the host. Cleetus does not install the server or download
models. Several
eligible discovered models can be available on one host, and individual agent
or team selections keep their actual chosen model rather than silently following
later default changes.

Unknown model capabilities stay unknown. Unsupported selections fail before
launch, and a turn without a completed assistant reply is reported as failed.
An installed server or visible model list does not prove a completed inference.
Provider sign-in and local model server resources remain your responsibility;
there is no automatic cloud fallback.

## Keep a Mac available for iPhone control

In a build containing the macOS host adapter, `cleetus setup --workspace
/absolute/project` reviews a per-user LaunchAgent and its exact executable,
workspace and profile paths. Installation and startup have separate local owner
reviews. The agent runs the same Cleetus Application/Core as the terminal; no
IDE process is required. Setup enables no phone, LAN, VPN or Relay listener and
changes no firewall rules.

Keep this macOS account logged in with its login Keychain unlocked. Apple Command
Line Tools are required by the existing Keychain helper. This is a user agent,
not a pre-login system daemon. Sleep, logout, a locked keychain or an unavailable
user session can interrupt availability. A disconnected phone cannot establish
which of those happened; inspect local service status and logs.

After setup, `cleetus` attaches to the saved host. Run `cleetus signin` for the
existing device-code flow, choose **Native Claude Code and SSH terminal setup**,
**Codex account** or **Server-local Ollama / LM Studio model engine**, then use
**iPhone pairing and control** to review a private listener and obtain the
existing pairing invitation. Each engine keeps its own sign-in and consent.
Authorize exact phone host-review scopes locally if the phone should approve
initial execution while the terminal is closed. Closing the terminal leaves the
LaunchAgent running. An unavailable approval still denies work.

Inspect the explicit service lifecycle without an IDE:

```sh
cleetus service status --json
cleetus service logs
cleetus service stop
cleetus service start
```

Status distinguishes an observed running job, a confirmed unloaded/stopped job,
and unknown manager state; application readiness is reported separately. Read
errors do not silently start a foreground replacement. Service logs stay in the
private profile's `logs` directory. Uninstall removes the managed LaunchAgent and
its service manifest while preserving account credentials, phone trust, sessions
and logs:

```sh
cleetus service uninstall
```

The macOS adapter has fixture lifecycle, attachment and plist-parser validation.
A real persistent Mac installation, reboot/logout recovery, physical-phone access
and provider inference require separate live acceptance. Windows service support
is explicitly unavailable.

## Run a Linux background host

Use [Linux host setup](HEADLESS_CLI.md). The wizard reviews installation and
startup separately, then normal terminal launches attach to the saved owned host.
`cleetus setup status --workspace /absolute/project --json` reads setup evidence.
An unavailable or uncertain host does not cause a replacement credential store
or automatic installation replay.

Headless work needs an attached owner terminal or an authorized paired phone for
approvals. Missing approvals deny execution. Phone/LAN listeners need separate
review and do not change firewall rules. Native provider consent still belongs
to its own supported terminal flow. [Advanced](ADVANCED_LINUX.md)

### What has been exercised

Real Linux checks have covered encrypted systemd/keyring startup and restart
persistence, attached CLI device-code sign-in, and iPhone Simulator pairing and
reconnection after relaunch. A real Ollama-backed reply has completed through
Cleetus Core after an unrelated tool request was denied. This is not acceptance
of every discovered model, Claude Code authentication, or physical-iPhone push
delivery. Each provider still needs its own supported setup and validation.

## Update without losing your profile

Stop active work before changing the installation. Updates are explicit and must
preserve the existing profile, trust data and encrypted credential. The protected
system host and ordinary user service have different update procedures.
[Advanced](ADVANCED_LINUX.md#update-without-replacing-the-keyring-credential)

For a macOS LaunchAgent, stop active work and the service first, upgrade the
terminal package, then inspect the new exact paths before an explicit update:

```sh
cleetus service stop
brew upgrade snowbiz/cleetus/cleetus-cli
cleetus service plan --workspace /absolute/project --json
cleetus service update --workspace /absolute/project
cleetus service start
```

The update preserves the profile path, computer identity and approved workspace;
it does not start the agent or re-pair the phone. Unknown manager state or changed
managed files require local inspection before another action. Keep the original
profile and Keychain items; a new profile represents another host identity.

CLI releases have their own channel; they do not update the IDE or extension.
No background download or automatic CLI installation is claimed.

## Recovery and security

Use `cleetus credentials status --profile …` to inspect uncertain Linux credential
operations and `reconcile` only after checking the actual local state. Unconfirmed
writes, worker cleanup and interrupted jobs are not automatically replayed.
A saved PID is evidence, not permission to kill an unrelated process.

Keep profile directories private and retain them across updates. Sharing a package
is not sharing its local credentials, workspace, paired-device grants or account.
See [security boundaries](SECURITY_MODEL.md), [phone control](PHONE_CONTROL.md),
[teams](TEAMS.md) and the [Apache license](https://github.com/SnowBiz/cleetus-releases/blob/main/docs/licenses/Apache-2.0.txt).

## Choose a routed LAN or VPN interface

In the local Phone menu, select **Enable on one routed LAN / VPN interface**
when your host supports it. Review the one interface, address and port before
allowing the listener. Exact IP is the default. Following address changes also
requires a stable hostname already covered by the saved certificate.

This supports private IPv4 and the shared IPv4 range used by some routed
networks. It does not approve every interface, open a firewall or trust a device
from discovery. Existing pairings and the certificate stay intact; missing or
incompatible identity material requires review. Only the actual approved route
is advertised. Managed Relay remains a separate private-preview capability;
the public base CLI does not contain Native RTC.

## Workspace activity metadata

Local activity and organization reporting have separate controls. Both start off.
Local activity keeps a bounded metadata history in application memory:

```sh
cleetus observation status --workspace /absolute/project
cleetus observation on --workspace /absolute/project
cleetus observation off --workspace /absolute/project
```

Compatible hosts also expose **Workspace metadata export** in the TUI:

```sh
cleetus observation-export setup --workspace /absolute/project
cleetus observation-export status --workspace /absolute/project
cleetus observation-export refresh --workspace /absolute/project
cleetus observation-export disable --workspace /absolute/project
```

These commands attach to an existing host. Setup and refresh require an attached
terminal for a separate local consent review. Setup offers organization and
workspace names; it does not ask you to paste IDs. Organization approval is also
required. Restarting the host requires **refresh** and another local resume
review within the existing consent period. Status and disable work without an
interactive terminal. Add `--json` for machine-readable results; use
`observation-export security` only when inspecting advanced security bindings.

Export requires current Cleetus CLI device sign-in, secure credential storage,
an approved reporting identity, organization metadata permission and the server
collection switch. Setup reuses a compatible existing approved installation key.
Otherwise it offers a separate host review to create a metadata-only reporting
key. Compare its full fingerprint on your signed-in website under **Devices →
Reporting identities**, approve it there, and rerun setup or refresh. This does
not enable Remote or authorize export: organization enrollment approval and a
separate local export-consent review still follow.

An uncertain registration is checked with **refresh** only; setup cannot silently
register another key. A confirmed revoked or expired identity can be replaced
only after prior export scopes have stopped and cleanup is confirmed. Unresolved
server revocation or receipts can block replacement; the host preserves that
uncertainty. Server routes and collection must be available in your deployment.
Local activity consent never authorizes reporting.

Reporting contains future turn status, permission outcomes, partial usage and
owned-worker lifecycle metadata. It excludes prompts, outputs, tool inputs,
file paths and hidden reasoning. Queued metadata is encrypted and bounded;
server retention is 24 hours. Consent lasts at most 24 hours. Status distinguishes
reporting, waiting for approval, paused and unknown receipts. An unknown receipt
does not trigger a resend. Disable stops local capture immediately and erases its
pending queue; **Stopping** or **Receipt unknown** means cleanup or server
revocation still needs confirmation. Signing out does not prevent local cleanup.

## Personal account-host candidate

Builds containing `cleetus account-host setup|status|refresh|disable` can enroll
one personal host through separate key and passkey reviews. Commands attach to
the running host; setup and refresh require an interactive terminal. Browser
execution transport and additional-user isolation are unavailable in this slice.
See [Personal account-host setup](ACCOUNT_HOST.md) for the exact workflow and
unknown-outcome recovery limits. This does not enable phone, reporting or Relay
authority.
