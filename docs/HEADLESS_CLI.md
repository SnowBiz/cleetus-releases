# Set up a Linux host

The guided setup described here requires **Cleetus CLI 0.2.0 or later**. Until a
stable release includes it, follow the guide matching your downloaded release;
this page does not announce its availability.

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

The underlying encrypted service has been exercised with real Linux systemd,
private Secret Service, restart persistence, attached sign-in and Simulator
pairing. The new 0.2.0 guided installer has passed fixture and source review;
privileged disposable installation and published-artifact acceptance remain
pending. Those checks are required before recommending this new installation
path as accepted. Provider/model and physical-phone acceptance are separate.
