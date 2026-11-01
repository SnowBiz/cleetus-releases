# Phone control

Phone control connects a compatible Cleetus phone client to the application
running on your Mac. It is optional and off until you enable it. Desktop-to-
desktop [agent collaboration](COLLABORATION.md) is a separate paired workflow;
Cleetus account sign-in is separate from both kinds of device pairing.

## Enable and pair

1. Open **Workspace → Phone control** in Studio, or run **Cleetus: Phone Control**
   from the command palette. Select a private IPv4 address assigned to this Mac.
2. Review **Enable Phone control** on the Mac. Cleetus starts a TLS 1.3 listener
   bound to that address and advertises `_cleetus-phone._tcp` through Bonjour.
3. Choose **Show pairing invitation**. Share its invitation and TLS fingerprint
   only with your own trusted phone. The invitation lasts ten minutes and is
   consumed when pairing starts.
4. In the phone client's Mac pairing screen, select the discovered Mac and enter
   the invitation and fingerprint. Discovery information is untrusted; it does
   not establish the Mac's identity or grant access.
5. Compare the eight-digit code on both devices. Approve on the Mac and confirm
   on the phone within the comparison window. Decline unexpected requests.

macOS and iOS may ask for Local Network permission. Allow it only when you intend
to use pairing. Guest Wi-Fi isolation, firewalls, VPNs and network changes can
block the connection. Cleetus does not change firewall rules or create a public
relay. IPv6-only networks and away-from-home relays are not supported here.

## What a paired phone can do

A trusted phone can view bounded snapshots of current projects, agents, teams,
tasks and transcript pages. It can request agent prompts, starts, retries and
stops; start or stop teams; create goals; and review reported tasks. Requests
use the existing desktop application, engine permissions and local reviews.
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

## Disable, revoke and reconnect

Run **Cleetus: Phone Control** again to disable the listener or revoke a paired
phone. Disabling ends its live sessions and advertisement; revoking also removes
that phone's stored pairing. Pending phone approvals default to deny. A late
approval cannot restart a disabled listener or revive a revoked pending command.
Already admitted work and source changes remain real; inspect them on the Mac.

The TLS identity and pairing records use secure host credential storage. The
certificate covers the assigned private interfaces and is checked for validity;
a changed interface or expired certificate can require an explicit owner review.
There is no silent certificate renewal that changes a phone's trusted identity.

## Recovery and limits

Every command has an operation ID and sequence. Cleetus writes a durable intent
before dispatch and refuses to execute that ID again. After interruption or a
lost response, inspect the operation and actual work on the Mac. **Unknown** means
reconcile the outcome; it never means automatically repeat the command.

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
