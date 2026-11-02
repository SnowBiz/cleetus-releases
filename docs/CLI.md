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
executable.** Install Node.js 22 or newer and npm first. The release workflow
validates Linux x64; other environments are previews until separately accepted.

### Install and open your workspace

After downloading and verifying the `.tgz`, replace `X.Y.Z` with its actual
version. Install as your ordinary account:

```sh
npm install -g --ignore-scripts ./cleetus-cli-X.Y.Z.tgz
cleetus --workspace /absolute/project
```

npm installs the frozen TypeScript and Playwright Core libraries. It does not
install a browser, coding agent, model or provider SDK.

**CLI 0.2.0 and later:** on Linux, the first terminal launch offers setup if a
working keyring is missing. You can also run `cleetus setup --workspace
/absolute/project`. Review the official OS prerequisites and protected host
installation once; starting the host is a separate approval. This future guide
requires a stable release that contains the wizard, and does not announce that
release. Older builds must use their matching release instructions.

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
[teams](TEAMS.md) and the [Apache license](licenses/Apache-2.0.txt).
