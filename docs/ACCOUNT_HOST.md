# Personal account-host setup

This development candidate adds explicit personal host enrollment to the CLI.
**Browser execution transport is not connected in this build.** Completing setup
does not make the browser editor able to run agents yet. Availability also
requires the corresponding server feature to be enabled; a local build does not
enable it. This is separate from existing [phone control](PHONE_CONTROL.md),
Relay and [metadata reporting](OBSERVABILITY.md).

The current runtime supports one personal owner. Additional people and
organization execution are unavailable. A second process running as the same
OS user does not provide multiuser isolation.

## Start a pending enrollment

Use a supported host with secure credentials, a running Cleetus host and normal
Cleetus account sign-in. These commands attach to that existing host; they do not
install a service or open a new network listener.

```sh
cleetus signin
cleetus account-host setup --workspace /absolute/project
```

Setup requires an interactive terminal, including a normal SSH terminal. Choose
a public host label, a public workspace label, and read-only access or agent
start/stop access. Labels are shown to your signed-in account; do not put private
paths or secrets in them. The TUI also has **Personal account-host · separate
passkey trust**.

Review creation of a separate host-purpose key and the exact pending enrollment.
The key stays in this host profile's secure credential store. This step grants no
execution authority and does not reuse a reporting key, phone pairing or Relay
grant. Setup displays the fixed signed-in platform site and enrollment request.

Sign in at the displayed `/ide/` site and use its pending-host passkey flow when
that deployment offers it. Website sign-in alone cannot trust the passkey for
this host. Synced passkeys and cross-device passkey authentication are distinct
from pairing every browser with a phone.

## Review the exact passkey and workspace

After creating the pending passkey, run:

```sh
cleetus account-host refresh --workspace /absolute/project
```

The local review shows the account, complete passkey public-key fingerprint,
credential hash, host fingerprint, public workspace label and allowed actions.
Compare the full fingerprint and approve only the intended account and passkey.
The review pins this passkey anchor to this physical workspace and personal host.
Provider-native login and permission prompts remain local.

A finalized host checks current server authority before accepting a short-lived
session. A positive acceptance response alone is insufficient: the host must
confirm the exact signed lease through its own server sync. Lost responses are
reconciled by status; unknown mutations and agent commands are never replayed.

## Status, stop and restart recovery

```sh
cleetus account-host status --workspace /absolute/project --json
cleetus account-host disable --workspace /absolute/project
```

Status is local and does not sign in or refresh credentials. After restart,
`refresh` requires another exact local review before resuming the saved policy.
An uncertain enrollment or finalization remains attached to its original request;
`setup` does not silently replace it. Account switching hides the previous
account's host details and stops its captured execution authority.

Disable stops this host locally without waiting for the server. **Server host
revocation is unavailable in this slice**; the command does not claim to revoke
the server record or passkey. To resume the same saved setup, use `refresh` and
review it again. A different owner or workspace enrollment, host policy editing,
additional principals, file actions and browser execution remain separate work.
Do not delete state or retry an unknown command to force progress.

A new CLI sign-in can create a different device grant. The saved enrollment is
bound to its original grant and cannot silently transfer to the new one. This
candidate does not offer enrollment replacement or passkey recovery; a denied
binding stays unavailable. Recent command receipts use a bounded cache while a durable admission cursor
continues to reject old operations. An older outcome may become
`retired-unknown`; that never permits replay. A new sequence is a new deliberate
action, not recovery of an uncertain one. Storage faults pause admission for
review instead of resetting command history.
