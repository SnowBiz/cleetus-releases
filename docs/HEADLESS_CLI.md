# An encrypted headless CLI host

This optional Linux setup is for a machine without an already unlocked desktop
keyring. It runs Cleetus as your ordinary account in a **system** service with a
private D-Bus session and GNOME keyring. It keeps your account home and a fixed
search path covering Node, standard system tools and your own local/bin directories;
provider credentials or arbitrary shell environment values are not copied into the unit. The default `cleetus service` user-service
path remains available for machines that already have a working Secret Service.

Use a build that includes `scripts/cli-headless.mjs`. It requires Node.js 22+,
Linux systemd 250+ with `systemd-creds`, and the official D-Bus, GNOME keyring,
libsecret, GLib, Python 3 and tmux tools. On Ubuntu, install the missing prerequisites:

```sh
sudo apt-get install dbus-user-session gnome-keyring libsecret-tools libglib2.0-bin python3 tmux
systemd-creds --version
node --version
```

The helper does not install OS packages. Verify your CLI archive/checksums before
running any installer with sudo. Coding agents, models and provider authentication
remain separately installed; the helper does not download models or change them.

## Review, install and start

Choose an existing non-root account and workspace. Resolve the installed package
and Node executable from the account you normally use:

```sh
cleetus_package="$(npm root -g)/cleetus-cli"
cleetus_node="$(command -v node)"
sudo "$cleetus_node" "$cleetus_package/scripts/cli-headless.mjs" plan --user "$(id -un)" --workspace /home/alex/projects/app
```

The plan shows the exact account, workspace, executable pins, system unit,
profile and encrypted credential location. It contains no password. Review it,
then use the same arguments for each explicit step:

```sh
sudo "$cleetus_node" "$cleetus_package/scripts/cli-headless.mjs" install --user "$(id -un)" --workspace /home/alex/projects/app
sudo "$cleetus_node" "$cleetus_package/scripts/cli-headless.mjs" start --user "$(id -un)" --workspace /home/alex/projects/app
sudo "$cleetus_node" "$cleetus_package/scripts/cli-headless.mjs" status --user "$(id -un)" --workspace /home/alex/projects/app
```

Installation writes the reviewed files and reloads systemd. It **does not start**
the host. Starting explicitly enables and starts only this managed unit. Manager
status is distinct from application readiness; attach to the printed profile to
check the actual CLI host:

```sh
cleetus --attach --profile /var/lib/cleetus-headless-IDENTIFIER/profile --workspace /home/alex/projects/app
```

Run the attached CLI as the chosen ordinary user, not root. Its local private
socket connects to the existing host; account storage stays in the service's
keyring. Use Cleetus account sign-in from the attached terminal. Phone/LAN
listeners and agent actions still require their own reviewed approvals.

`systemctl` reporting an active unit is not the same as Cleetus application
readiness. A client of this managed profile validates the installed root-owned
configuration, service unit, user, workspace and private socket owner, including
its kernel-reported membership in that exact systemd unit, then waits
up to ten seconds for the application. It never starts an unmanaged replacement
using your SSH session's credential environment. If startup is still incomplete,
try attaching again; if the service is stopped, explicitly start the reviewed
unit. A mismatched configuration or workspace requires owner review, not a new
profile, keyring or automatic repair. Do not use `cleetus run` to work around
managed-service startup.

Managed attachment requires readable Linux procfs and the unit's unified cgroup
membership. An ordinary SSH process using the same profile is not accepted as
the managed host. Other CLI profiles retain their normal private-owner checks.

### Use the host's existing Codex account

After attaching as the service's ordinary user, open **Codex account · existing
CLI or isolated profile**. Explicitly review the existing native Codex home for
new conversations, then use the separate no-inference account check. Sign in to
the provider in its own Codex CLI if needed; Cleetus account device-code sign-in
does not do that. Do not copy credential files into the service profile or put
provider tokens in a systemd unit.

The native profile may load its own settings, instructions, hooks, plugins and
MCP servers. Cleetus retains fixed first-party auth-mode routing and on-request,
project-scoped sandbox controls for its managed turns. Existing sessions keep
their saved runtime pins when you change the choice for new work. Unconfirmed
metadata or a changed binding requires local review, with no automatic account
fallback, credential copy or launch replay. See the
[Codex account selection guide](CLI.md#choose-the-codex-account-for-new-conversations)
for the full selection and recovery steps.

## Let your trusted device reach the host

Enabling Phone Control starts the approved listener; it **does not allow traffic
through your host firewall**. A listener can be running while your phone cannot
reach it. Keep the listener on the reviewed private interface and explicit port.
Do not expose it to the public internet or forward its port through your router.

Review the listener address and port in Cleetus, then inspect the server's
interfaces and existing firewall rules:

```sh
ip -brief address
sudo ufw status numbered
```

If you use UFW, replace every uppercase placeholder below with your reviewed
values. Allow only the trusted client's single private IPv4 address (`/32`), on
the intended private interface, to the server's private address and Cleetus port:

```sh
sudo ufw allow in on PRIVATE_INTERFACE proto tcp from TRUSTED_CLIENT_IP/32 to SERVER_PRIVATE_IP port CLEETUS_PORT comment 'Cleetus paired client'
```

This is an example rule to review, not an installer step. Do not enable, disable
or reset an existing firewall just to make pairing work; preserve SSH and other
existing access rules. If you use another firewall, apply the same narrow scope
there. Avoid rules that allow any source or an entire LAN. For iPhone Simulator,
the network client is normally its Mac; a physical iPhone has its own address.

From the trusted client, test only the reviewed address and port:

```sh
nc -vz SERVER_PRIVATE_IP CLEETUS_PORT
```

A successful TCP connection proves reachability, **not identity or trust**.
Complete Cleetus's pairing-code comparison and TLS fingerprint verification even
when the address looks familiar. A saved pairing reconnects only to its trusted
identity; another computer obtaining the same IP must not inherit access. If
DHCP changes an address, review the narrow firewall rule again. Review and remove
obsolete rules using `sudo ufw status numbered` and `sudo ufw delete RULE_NUMBER`;
do not broaden the rule to avoid that review.

## How the vault stays unlocked

The installer generates a separate random keyring unlock credential. It encrypts
and authenticates it with `systemd-creds --with-key=host`, using systemd's root-only
machine key. It never uses your Cleetus password, an empty keyring password or an
environment/command-line password. At activation, `LoadCredentialEncrypted`
delivers a read-only credential to the unit, which pipes it into the official
GNOME keyring daemon. The credential reader verifies systemd’s read-only delivery
and exact service-user access, including Linux POSIX ACLs, before reading it. A
fixed isolated Python 3 helper inspects only file/ACL metadata through inherited
descriptors; it never reads or prints the credential. The CLI child does not inherit the credential-directory
variable. Private persistent keyring data and account credentials survive restarts.

The host-key option protects against ordinary users reading the encrypted file;
it does not protect against root or theft of both the disk and its root machine
key. It makes no TPM or full-disk encryption claim. Service processes and the
chosen operating-system user remain within the same local trust boundary.

## Platform validation

The encrypted service path has been exercised on Linux x64 with real systemd
credential delivery, private D-Bus and GNOME keyring startup, CLI readiness, and
private vault storage persistence through a controlled restart. Cleetus device-code
sign-in has also completed from an attached headless CLI. An iPhone Simulator has
paired with the Linux host and reconnected after relaunch. A real Ollama-backed
reply completed through Cleetus Core after an unrelated tool request was denied.

These are separate checks: they do not establish that every advertised model
works, that Claude Code is signed in, or that physical-iPhone push delivery has
passed. Provider authentication remains separate from Cleetus sign-in. Follow the
requirements and notes for the exact release you install.

## Update without replacing the keyring credential

Explicitly stop the service before replacing its package or Node executable:

```sh
sudo "$cleetus_node" "$cleetus_package/scripts/cli-headless.mjs" stop --user "$(id -un)" --workspace /home/alex/projects/app
```

Install the verified new CLI version, resolve its package and Node paths again,
then run **update** followed by **start** with the same account and workspace.
Update requires the known unit to be inactive, records old/new code hashes,
reuses the exact encrypted unlock credential, preserves its profile/keyring and
does not start anything automatically. Unit/config hash binding rejects mixed
files after an interrupted update. Unknown or partial installation records are
preserved for owner review; the helper does not guess whether it should replace
or replay them. Status and stop can inspect a known old unit when code pins changed.

To leave the host disabled, stop it and use `sudo systemctl disable UNIT.service`
with the exact unit from the plan. The helper never deletes your profile, pairing
identity, encrypted keyring or machine credential. Losing those encryption keys
requires explicit recovery or new sign-in; it is not repaired by silently creating
a replacement password.

[CLI installation and operation](https://cleetus.dev/docs/cli/) ·
[Account and membership](ACCOUNTS.md)
