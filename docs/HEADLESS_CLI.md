# Set up a Linux host

Use **Cleetus CLI 0.2.0 or later** for this guided path. Older builds need the
instructions matching their release.

Install the verified CLI package as described in the [CLI guide](CLI.md), then
run as your ordinary account in an attached terminal:

```sh
cleetus setup --workspace /absolute/project
```

Choose an existing workspace you own. On supported Ubuntu or Debian hosts with
systemd 250+, the wizard reviews missing official OS packages, the exact user and
workspace, and the protected host installation before asking for administrator
approval. It uses a verified published CLI, official Node runtime and frozen
libraries in a root-owned installation. The first administrator bootstrap is an
explicit trust decision; no user-writable package or Brew Node runs as root.

Installation leaves the host stopped. Starting it requires a separate review.
The wizard checks the owned host's application readiness before reporting ready.
It saves the selected profile so the next command attaches to that same host:

```sh
cleetus --workspace /absolute/project
cleetus setup status --workspace /absolute/project --json
```

An interactive desktop with an unlocked Secret Service can use its existing
keyring without the protected system-service installation. No plaintext
credential fallback is used. macOS uses Keychain and does not use this Linux
wizard; Windows is not a supported CLI host.

## Account and agent setup

Sign in to Cleetus from the attached terminal when you choose to. Coding agents,
local model servers and provider sign-in remain separate installations and
approvals. Setup does not install models, open a network listener, pair devices,
change firewall rules or grant agent execution authority.

To reuse the host's existing Codex account, use the local **Codex account** menu
and review its native profile. Settings, instructions, plugins and MCP servers
may be loaded from that profile. See [Codex account selection](CLI.md#choose-the-codex-account-for-new-conversations).

## Let your trusted device reach the host

On Linux, open **iPhone pairing and control → Linux discovery setup and network
readiness**. The optional guided action reviews the OS discovery packages before
requesting administrator permission. It can also refresh discovery for an already
approved listener without changing its certificate, paired phones or history.
Installing the OS packages may immediately start local mDNS advertising.

`cleetus phone-discovery status` is read-only; `cleetus phone-discovery setup`
opens the same local owner review. This action does not change your firewall.
A registered discovery service and a reachable HTTPS listener are separate checks.
A physical iPhone has its own network address; a rule allowing only your Mac
allows the Simulator on that Mac, not the phone.

Enable Phone Control only after reviewing its interface, port and approval scope.
Pair using the displayed code and TLS fingerprint. Enabling a listener does not
change your firewall. A saved pairing preserves identity; an IP address alone
never establishes trust. [Advanced](ADVANCED_LINUX.md#let-your-trusted-device-reach-the-host)

## How the vault stays unlocked

The protected service uses a private D-Bus and GNOME keyring. A random unlock
credential is encrypted with systemd's host key and delivered privately to the
service. It does not use your Cleetus, Linux or provider password. Profile,
pairing identity and keyring data persist across restarts. Root and the selected
OS user remain in the local trust boundary; this is not full-disk encryption.

## Updates and recovery

Do not replace files in a running installation or delete receipts to retry an
uncertain operation. Setup status reads existing evidence; an unknown install or
start is not automatically repeated. A completed setup is reused without
replacing its keyring credential. Updating an existing protected host is a
separate explicit operation that preserves its profile and encrypted credential.
[Advanced](ADVANCED_LINUX.md#update-without-replacing-the-keyring-credential)

## Validation status

CLI 0.2.0's published Linux ARM64 package passed guided setup in a disposable
systemd host: real sudo and terminal approval, signed OS package installation,
separately approved service start, owned application readiness, and private
Secret Service storage preserved across a clean restart. The public Homebrew
formula also passed installation, catalog checks and credential-adapter tests.

Attached account sign-in and Simulator pairing have separate host acceptance.
macOS CLI remains a preview; provider/model and physical-phone acceptance are
separate from these installation checks. The cask was audited and its signed
installer inspected without replacing an existing app.

## Optional workspace metadata

The running host keeps local activity and organization export off until separate
reviews. Attach a terminal and use `cleetus observation on` for local memory-only
metadata, or `cleetus observation-export setup` for the named organization and
workspace picker on a compatible host. Export also needs current sign-in, an
existing approved installation key, organization permission, server collection
and browser organization approval. Setup never enables Remote or creates a key.

`cleetus observation-export status --json` reads host-local status. After a host
restart, `cleetus observation-export refresh` needs an attached terminal and a
fresh local resume review within the existing consent period. Use
`cleetus observation-export disable` without an interactive terminal to stop
capture and erase the scoped pending queue. A stopping or unknown state requires
review; it is not confirmation that the server revoked its grant. See the
[CLI guide](CLI.md#workspace-activity-metadata) for boundaries and commands.
