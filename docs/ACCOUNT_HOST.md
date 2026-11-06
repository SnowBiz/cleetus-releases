# Connect a registered computer

Use a compatible published Cleetus host to connect from the browser workbench or
the invitation-only iPhone companion. Remote access starts off. Account sign-in,
host registration, a workspace assignment and an authenticated connection are
separate steps; a saved computer entry is not permission to execute.

The supported Linux x64 path uses the published CLI and its separately licensed
Linux Host Preview. Choose a Mac IDE release whose notes explicitly advertise
the required connection; a phone or browser update does not upgrade an older
host. Existing [Phone control pairing](PHONE_CONTROL.md), Remote/Relay and
[metadata reporting](OBSERVABILITY.md) retain their own setup and permissions.

## Review and save a host

First install and start your existing supported host, prepare its secure
credential store, and sign in to Cleetus. Coding agents still require their own
installation and native sign-in. Use an attached owner terminal, including a
normal SSH terminal, for local trust review.

```sh
cleetus signin
cleetus account-host setup --workspace /absolute/project
cleetus account-host trust-setup --workspace /absolute/project
```

Follow the local prompts. Choose nonsecret host and workspace labels; never put
private paths or secrets in public labels. Review the host identity, account,
workspace and maximum allowed actions before saving. If an earlier pending
personal enrollment already exists, inspect it with `status` and `refresh`
instead of replacing it. The existing TUI has the same account-host controls.

The saved registration uses a separate host-purpose key in the software secure
credential store. It does not reuse phone pairing, Relay or reporting authority.
This is software-key identity, not hardware attestation or proof that a host is
unspoofable. The OS account and machine administrators remain in the host's trust
boundary.

Choose **My personal account** for personal host access. An organization scope
requires current administrator authority and the separately supported tenant
execution boundary. Selecting an organization is not evidence of multiuser
isolation; shared organization execution is not generally available.

## Assign, then connect

Open your signed-in Cleetus account's computer settings. Review the personal
workspace assignment and allowed actions within the host's local ceiling. Then
open [the browser workbench](https://cleetus.dev/ide/), or select a compatible
registered computer in the current internal iPhone build, using the same account.
Confirm an authenticated connected state before requesting work.

Registration does not start a session or open a public listener. A current host,
service enablement, approved build and reachable direct network path are still
required. A host does not advertise native iPhone support merely because it can
serve a browser. Missing or stale capability stays unavailable.

The registered-computer route currently uses encrypted direct WebRTC. Supported
status and transcript snapshots refresh about every three seconds while active.
This is not continuous token streaming. Team chat and paid Relay are still on
the earlier Phone control and Remote paths and are not yet migrated here.

Review the selected role's complete prompt, engine, model, effort and workspace
before a permitted launch. Provider-native and operating-system consent remain
local. Missing approval capability denies protected actions. A launch being
admitted is not proof that the requested task succeeded.

## Status and safe recovery

```sh
cleetus account-host status --workspace /absolute/project --json
cleetus account-host trust-status --workspace /absolute/project --json
cleetus account-host trust-sync --workspace /absolute/project
```

Status reads the existing local setup. Sync refreshes the current assignment;
it does not replace an unknown operation. A saved computer that is offline or
has no current authenticated session remains unavailable. Preserve the host key,
profile, workspace and original action receipts across updates and restarts.

For an uncertain registration result, read the original outcome:

```sh
cleetus account-host trust-reconcile --workspace /absolute/project
```

CLI 0.2.9 adds explicit recovery after the original pending enrollment is proven
expired. Review a fifteen-minute extension, then separately review registration:

```sh
cleetus account-host trust-renew --workspace /absolute/project
cleetus account-host trust-setup --workspace /absolute/project
```

If the renewal result is uncertain, use `trust-renew-reconcile` for that original
request. An applied original receipt takes precedence. Each rejected original
supports one applied renewal; this flow cannot reset an active registration or
existing legacy grant. Do not delete state, create a replacement identity or
repeat an unknown command to force progress.

## Stop access

```sh
cleetus account-host disable --workspace /absolute/project
```

Disable stops this host's account access locally. Inspect the account's saved
assignment and revocation controls separately; a local stop is not a claim that
all server records or earlier phone pairings were revoked. Keep provider sign-in,
phone pairing and other independent permissions separate when reviewing access.
