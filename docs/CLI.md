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

### Install the npm package

After downloading the `.tgz`, replace `X.Y.Z` below with its actual version:

```sh
npm install -g ./cleetus-cli-X.Y.Z.tgz
cleetus --version
cleetus --help
```

npm installs the pinned TypeScript and Playwright Core libraries declared by the
package. It does not install Claude, Codex, a browser or a provider SDK.

### Use the portable JavaScript archive

Extract `cleetus-cli-X.Y.Z-node22.tar.gz` into a new version-specific folder.
Its top-level directory is `package`. Install its pinned public libraries before
using Design or advanced features:

```sh
cd package
npm ci --omit=dev --ignore-scripts
./bin/cleetus --help
./bin/cleetus --workspace /absolute/project --profile ~/.cleetus/cli
```

Keep the package directory intact: worker, credential and systemd helpers resolve
relative to that installation. The ordinary CLI and user service need no administrator access. The optional
encrypted headless system service requires an explicit administrator install.

## Prepare the host

- **Linux x64:** install `libsecret-tools`, a user D-Bus/Secret Service with an
  unlocked keyring, and Node.js 22+. Native terminal agents also need `tmux`.
  Background service commands require a systemd **user** manager.
- **macOS preview:** macOS Keychain and Apple Command Line Tools (`xcrun swiftc`)
  are required for the credential helper. A native consent prompt may appear.
- **Windows:** not a supported CLI host yet; the release is not a Windows binary.

There is no plaintext credential fallback. An interactive Linux desktop can use
its unlocked user Secret Service. For a server without a desktop login, the
optional [encrypted headless service](HEADLESS_CLI.md) provisions a separate
private keyring using a random host-encrypted systemd credential. It runs as your
existing non-root user; installation and startup are explicit administrator
actions. It does not reuse your Cleetus, Linux or provider account password.

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

```sh
cleetus service install --workspace /absolute/project --profile ~/.cleetus/cli
cleetus service start --workspace /absolute/project --profile ~/.cleetus/cli
cleetus service status --workspace /absolute/project --profile ~/.cleetus/cli
cleetus service logs --workspace /absolute/project --profile ~/.cleetus/cli
```

Install writes an owned user unit but does not start it. Start explicitly enables
and launches that unit. It pins the installation, Node executable, project and
profile; another terminal attaches to the profile’s private local socket.

Use `--attach` on a TUI or sign-in command when you want only the existing host:

```sh
cleetus --attach --workspace /absolute/project --profile ~/.cleetus/cli
```

`status` and `request` always attach without starting a host. Managed encrypted
headless profiles automatically use the same attach-only behavior, even without
the flag. Clients wait up to ten seconds for application readiness and verify
the profile owner and exact workspace before sending work. If the host remains
unavailable, they report that outcome without opening another credential store.
Starting a stopped service remains an explicit operator action. An ordinary
fresh interactive TUI or sign-in can still start its own local host when no
service or managed profile exists; `cleetus run` is explicit manual host startup.

Headless work needs an attached owner terminal or an authorized paired phone for
approvals. No approval surface means deny. Phone Control and encrypted LAN
listeners require their own owner review; installation does not open a listener.
Native Claude sign-in, trust or unsupported prompts still need direct SSH/tmux;
Cleetus never types consent or reads the raw native terminal transcript.

Enabling a Phone Control listener does not change the host firewall. Review a
narrow rule for the trusted client's private address, private interface and exact
listener port; never treat an open port or familiar IP as a trusted pairing. See
[headless host reachability and pairing](HEADLESS_CLI.md#let-your-trusted-device-reach-the-host).

### What has been exercised

Real Linux checks have covered encrypted systemd/keyring startup and restart
persistence, attached CLI device-code sign-in, and iPhone Simulator pairing and
reconnection after relaunch. A real Ollama-backed reply has completed through
Cleetus Core after an unrelated tool request was denied. This is not acceptance
of every discovered model, Claude Code authentication, or physical-iPhone push
delivery. Each provider still needs its own supported setup and validation.

## Update without losing your profile

Stop running tasks and the user service before replacing package files. Download
and verify the next CLI release, then install it or extract it into a new folder.
If its Node/script path changes, uninstall the old managed unit and explicitly
install/start the new one. Uninstall preserves the profile and trust data.
Do not overwrite a live installation and assume its workers reloaded safely.

CLI releases do not change the IDE/extension’s latest release or updater channel.
Current CLI updates are explicit; no background download or auto-install is claimed.

## Recovery and security

Use `cleetus credentials status --profile …` to inspect uncertain Linux credential
operations and `reconcile` only after checking the actual local state. Unconfirmed
writes, worker cleanup and interrupted jobs are not automatically replayed.
A saved PID is evidence, not permission to kill an unrelated process.

Keep profile directories private and retain them across updates. Sharing a package
is not sharing its local credentials, workspace, paired-device grants or account.
See [security boundaries](SECURITY_MODEL.md), [phone control](PHONE_CONTROL.md),
[teams](TEAMS.md) and the [Apache license](licenses/Apache-2.0.txt).
