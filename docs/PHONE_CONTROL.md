# Phone control

This guide describes the earlier Phone control pairing route. Current internal
iPhone builds can also use a compatible [registered computer](ACCOUNT_HOST.md).
That newer direct WebRTC route uses supported status/transcript snapshots and
does not yet include this route's team chat or paid Relay. Follow the guide for
the connection you selected; permissions and capabilities do not transfer
between them automatically.

Phone control connects a compatible Cleetus phone client to a running Cleetus
host on macOS or Linux. It is optional and off until you enable it. Desktop-to-
desktop [agent collaboration](COLLABORATION.md) is a separate paired workflow;
Cleetus account sign-in is separate from both kinds of device pairing.

## Enable and pair

1. Open **Workspace → Phone control** in Studio, or run **Cleetus: Phone Control**
   from the command palette. Select a private IPv4 address assigned to this Mac.
   Choose an automatic port, or use Advanced to keep a previously configured port.
   On Mac, choose **Follow this private interface** for DHCP reconnection, or
   keep an exact IP address. This choice is included in the Mac approval.
2. Review **Enable Phone control** on the Mac. Cleetus starts a TLS 1.3 listener
   bound to that address and advertises `_cleetus-phone._tcp` through Bonjour.
   The follow-interface choice remembers the selected interface, certified `.local`
   name, port and existing identity. Only that interface may follow private IPv4
   changes. The exact-IP choice remembers that specific private endpoint.
3. Choose **Show pairing invitation** and scan the offline QR on your phone.
   Share its invitation and TLS fingerprint only with your own trusted phone. The invitation lasts ten minutes and is
   consumed when pairing starts.
4. A supported manual pairing flow can use the exact endpoint, invitation and
   fingerprint instead. Discovery information is untrusted; it does not establish
   the Mac's identity or grant access. Create a new invitation if the old one
   expires; this refresh does not replace the listener or its identity.
5. Compare the eight-digit code on both devices. Approve on the Mac and confirm
   on the phone within the comparison window. Decline unexpected requests.

macOS and iOS may ask for Local Network permission. Allow it only when you intend
to use pairing. Guest Wi-Fi isolation, firewalls, VPNs and network changes can
block the connection. Cleetus does not change firewall rules. Direct connections
can use an approved private LAN or routed VPN interface when both devices have
a working route. Bonjour discovery stays local to its network; account discovery
supplies location updates across networks. IPv6-only listeners are not supported.

Managed Relay is a separate, permissioned private-preview capability for eligible
members. Signing in or discovering a computer does not establish Relay trust.
Relay availability, allowance and actual connection acceptance are checked
separately; a saved computer is not proof that it is online.

## What a paired phone can do

A trusted phone can view bounded snapshots of current projects, agents, teams,
tasks and transcript pages. It can request agent prompts, starts, retries and
stops; start or stop teams; create goals; and review reported tasks. Requests
use the existing desktop application, engine permissions and local reviews.
Current clients can also create structured tasks and configured teams. The shared
role catalog provides actual persona prompts and details; engine, model and
effort choices come from the Mac's advertised support. Team creation saves its
configuration without starting agents. A supported solo-role launch uses the
reviewed catalog instructions and preserves the exact approved prompt for resume.
Pair only a device you trust with the work in this window.

- Starts identify an actual registered engine. The phone v1 `recipe` field is a
  compatibility alias for an engine launch, not a workflow definition. New
  clients can use the separate engine list.
- Commands keep exact project and session identity. A v1 client may omit a
  project only where its target determines one unambiguously or this window has
  one open root. Multiple-project goals and reviews require a selected project.
- General agent controls cannot take over hidden task, team or workflow sessions.
  Their owning workflows and teams retain execution authority.
- A phone permission card mirrors the desktop's immutable review document.
  Decisions require the matching live request and content digest; an Allow is
  one decision, not a rule for future requests. Ambiguous or oversized reviews
  remain on the Mac. Native provider sign-in and unsupported consent stay native.
- A retry is a new explicit request. Saved image metadata cannot silently recreate
  missing image input; choose replacement input through a supported desktop flow.

## Choose where phone reviews appear

Pairing does not automatically send initial agent, team or task reviews to your
phone. This setup flow requires extension 1.12.9 or an IDE 0.2.7 build that includes
**Phone review setup & status**. Extension and IDE updates are released
independently; check the installed host version if the entry is missing. Setup
requires a listening Phone Control host, a v2
paired phone, an opened project and working local host approval.

1. On the host, run **Cleetus: Phone Control**, then choose **Phone review setup &
   status**. **Saved review setup** is a read-only inspection; **Why a phone Inbox
   can be empty** explains any missing prerequisite.
2. Choose **Configure one phone and project…**. Select the exact paired-phone ID
   and one opened project. Check the ID rather than assuming that the newest or
   similarly named device is the intended phone.
3. Select only the required kinds: an initial conversation, a published-role
   conversation, template-team creation, a configured-team start, a team
   conversation turn or a task start. Available kinds come from the host. Other
   phone/project scopes are retained.
4. Choose **Review this complete policy locally on the host**. This opens a
   mandatory local review of the full phone, project and action-kind policy.
   Inspect every scope and allow it only if it matches your choices. The setup
   policy itself cannot be approved from the phone.
5. Wait for confirmed save/readback, then inspect **Saved review setup**. Cancel,
   denial, unavailable approval or an unconfirmed save must not be treated as
   enabled phone review access.

This grants access to review the listed actions, not permission to execute them
automatically. Every later action still needs its own exact review. Provider
sign-in, provider-native permission and operating-system consent remain on the
host. A headless host uses its normal [local review configuration](HEADLESS_CLI.md);
this guided picker belongs to an editor window.

The save is bound to the policy revision you reviewed. If another window changes
or revokes scopes before the save completes, the stale save is refused rather
than overwriting that change. Reopen the setup and inspect the current records.
Phone revocation, listener changes or a changed/replaced opened project can also
invalidate a selection or pending review. If a save's outcome is uncertain,
inspect the saved policy before requesting another change.

An empty phone Inbox is not proof that a start succeeded, failed or is waiting
for phone approval. A review may still be local, may have expired, or may not
have been created. Check the original action receipt and the host's actual work.

## Disable, revoke and reconnect

Run **Cleetus: Phone Control** again to disable the listener or revoke a paired
phone. Disabling ends its live sessions and advertisement; revoking also removes
that phone's stored pairing. Disable also saves automatic startup as off.
Ordinary quit preserves a previously approved startup setting. If Disable cannot
save securely, it stops this run and explicitly asks you to retry before closing.
Last-known public location metadata may remain for advisory account sync; it does
not enable a listener. Pending phone approvals default to deny. A late
approval cannot restart a disabled listener or revive a revoked pending command.
Already admitted work and source changes remain real; inspect them on the Mac.

The TLS identity and pairing records use secure host credential storage. The
certificate covers the assigned private interfaces and is checked for validity;
a changed interface or expired certificate can require an explicit owner review.
There is no silent certificate renewal that changes a phone's trusted identity.
With follow-interface approval, Cleetus checks the selected interface locally
every second, with a bounded fallback after a stopped listener, and can rebind its unchanged certified endpoint and
port after a private DHCP address change. It does not rotate keys or rewrite the
approval during a move. Missing or ambiguous addresses, a changed local name, an
invalid certificate or an occupied saved port leave control off for review.
Earlier exact-IP approvals keep their original scope; a DHCP change requires
owner review before enabling follow-interface mode. Accepted pairing credentials
remain separate from short-lived sessions; compatible clients can renew an
expired session without pairing again.

## Network changes and account sync

Updated hosts publish a changed approved route to your signed-in account. A
compatible phone refreshes that metadata and uses its existing pairing to verify
the host again. The certificate fingerprint and host identity remain unchanged;
an address change never authorizes a different computer. Unchanged reports do not
rewrite the account or generate another change notification.

Version 2 discovery keeps the transport address separate from the exact name
verified in the saved certificate. This lets a host retain its certificate while
moving to an approved VPN address. Both the certificate name and the phone's
locally saved certificate fingerprint are checked before pairing authentication.
Older clients retain their original verification behavior and need an update to
use these routes.

**Synced hosts** is your account directory, separate from this phone's saved
pairings. A Linux host can appear there before it is paired on this iPhone. Its
account row or discovery report does not establish local trust, online status or
execution permission. Follow the normal pairing/identity review before controlling
it; never import trust merely because an address came from your account.

If an expected host is missing, check whether the account and directory are
verified, cached or unavailable. An unavailable directory is not an empty verified
list. On the host, check the approved listener and published route. Keep existing
pairings while investigating; removing them does not repair account discovery.

If an approved interface disappears, the host withdraws its routes rather than
advertising another interface without permission. When that same approved
interface returns, it publishes the new route. A silent notification asks the
phone to fetch current metadata; it contains no address, credential or command.
Push delivery is best-effort, so foreground refresh remains available.

Only hosts with an approved listener advertise an inbound route. An iPhone
controller receives host updates; it does not advertise a nonexistent server or
copy pairing secrets to your account. Account sign-in and Phone Control approval
are separate. **Automatic Phone control stayed off** means the saved listener
could not be restored safely; review its interface, port and identity on the host.

## Optional generic alerts

Supported phone clients can register closed-app notifications and ask the Mac to
enable generic alerts. Review the separate Mac consent. Alert hints carry no
project, command, path or message content, and they do not authorize actions.
Cloud acceptance is not proof that a phone received or displayed an alert.
Routine quit and a DHCP move pause alerts without revoking the approved binding.
They resume only after the same saved identity, pairing keys and owner approval
are validated. An in-flight outcome can remain unknown and is never replayed.
Cloud revocation or expiry still prevents cloud admission.
Disable, unpair or notification revocation stops further local admissions; an
already admitted or queued generic alert may still arrive. Account engine-change
notifications use a separate account-service path.

## Direct routes and optional Remote fallback

With automatic reconnection enabled, compatible phone clients try the trusted
direct LAN or VPN route first, then may use a separately configured Remote route.
Keep these checks separate:

- **Account eligibility and allowance:** the account service may permit managed
  Relay use within its current allowance. This does not enable a host runtime or
  approve any device or workspace.
- **Local Remote runtime:** Remote must be explicitly enabled on the host. A
  ready/listening status means it can receive connection signaling; it does not
  establish a connected peer or successful RPC.
- **Device and action authority:** approve the exact installation identities and
  separately review the device pairing and exact workspace/action grant. Direct
  Phone Control pairing alone does not grant Remote access.

A disabled local runtime, unavailable account service, exhausted allowance or
missing grant can each prevent fallback. Remote transport may negotiate a direct
peer path or a managed Relay path; a ready indicator is not proof that Relay was
used. Check the actual connection result. Do not change identities, revoke a
working pairing or broaden grants merely to clear a connection error.

## Recovery and limits

Every command has an operation ID and sequence. Cleetus writes a durable intent
before dispatch and refuses to execute that ID again. Current clients can receive
a pending receipt while the Mac waits for a local approval. Wait for that review
and read the same operation's outcome; closing the phone does not undo Mac work. After interruption or a
lost response, inspect the operation and actual work on the Mac. **Unknown** means
reconcile the outcome; it never means automatically repeat the command.

Compatible clients can show negotiated lifecycle facts for an asynchronous agent
start. Older clients and historical receipts may have less detail.

| Lifecycle fact | What it establishes |
| --- | --- |
| Admitted | The host recorded the request. This is not proof that an agent started. |
| Awaiting native approval | The initial review is waiting in the host's native approval flow. Check that host. |
| Awaiting phone review | The host actually created an eligible phone review. Open the phone Inbox and inspect its exact content. |
| Starting | The initial review passed, but the start outcome is not yet confirmed. |
| Applied / started | The host confirmed the start was applied. Inspect the actual session or task for subsequent progress. |
| Proven rejection before start | A trusted initial review proved that execution did not start, for example because approval was declined, expired, unavailable or cancelled. |
| Unknown | Execution cannot be established. Read the original receipt and inspect the host; never replay it automatically. |

An interrupted admission or later exception does not prove rejection. New
lifecycle detail cannot retroactively turn a historical unknown receipt into a
safe retry, and an approval is not proof that an engine produced a response.

Phone clients with compact contextual status link to connection/action details.
**Read original action receipt** reads the same operation on its original
host; reconnect to that host if needed. **Stop waiting on this phone** only stops
the local wait and does not cancel or undo host work. Confirm that you inspected
an uncertain outcome only after checking it on the host. An unknown receipt stays
available in the Inbox/details even when there is no phone approval card.

Snapshots, transcript pages, pending reviews, connections and the operation
journal are bounded. Missing information is not proof of success. A full journal,
unconfirmed listener cleanup or uncertain credential-helper write requires owner
review rather than automatic deletion or replay.

The included tests distinguish mocked security boundaries, real loopback TLS,
simulator journeys and physical-device acceptance. A simulator or a process
launched from Terminal does not prove first-run permissions, sleep/wake or VPN
behavior on your physical iPhone. Live model-provider work also depends on its
own installed CLI, account and permissions.

[Cleetus accounts](ACCOUNTS.md) · [Agent teams](TEAMS.md) · [Local service](SERVICE.md)
