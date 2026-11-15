# Cleetus 1.12.14

Codex turns now report an unexpected provider-process exit after a start
acknowledgment. Tasks retain their changed files and failure evidence for review.
An explicitly resumed thread ignores output from the retired provider process.
Delayed replies and old approval dialogs cannot decide a replacement provider
request that reuses the same server identifier.

Shared Core modules now have explicit state ownership and focused compatibility
checks. Fragmented remote TLS input avoids repeated partial-frame copies, while
browser connection backlogs and route waits remain bounded by their original
limits and deadlines. Existing access grants, approvals and saved data formats
remain in force. Reduced copy work is not an end-to-end latency claim.

# Cleetus IDE 0.2.30

Signed development preview of the native IDE. It includes the shared Core changes
since 0.2.29.

Studio pages have subtle artwork: a faded header scene, a watermark on utility pages and
a character in empty states, with text kept readable over it. Tasks and Review have
clearer empty states, Projects shows status chips, and the Computers page is laid out
as a list of computers with their state.

Connections to a registered computer are sturdier: a channel no longer ends after a
fixed number of requests, a missed heartbeat is retried inside its window, a stalled
browser runtime is restarted, and the connection state names its reason. Diagnostics
keep a bounded event history and can produce a diagnostics bundle that leaves out
private content.

Account registration and remote access still need their normal owner setup and
supported computer capabilities. Sustained usable connectivity across real networks,
preserved-profile upgrade and live conversation acceptance remain open. CLI, browser,
extension and iPhone builds retain their independent release paths.

Shared Core ownership and protocol boundaries have focused checks across supported
clients. Fragmented TLS input avoids repeated partial-frame copies, browser
connection backlogs are bounded, and route waits preserve their original deadlines.
These changes preserve access checks, existing saved data and independent extension
packaging. Reduced copy work is not an end-to-end latency claim.

# Cleetus CLI 0.2.35

Shared Core state and provider cleanup have clearer ownership, with focused checks
for module boundaries and supported product entries. Codex requests that lose their
provider process after acknowledgment retain changed files and failure evidence;
late replies and approvals from a retired process cannot settle a replacement request.

Remote TLS frame reassembly avoids repeatedly copying a growing partial frame.
This reduces copied bytes and allocation work for fragmented input; it is not a
claim of an equivalent improvement in end-to-end connection speed. Queue limits,
request deadlines, access grants and approval checks remain enforced.

Existing sessions and saved data keep their formats. The Apache CLI and separately
licensed Linux Host Preview retain their existing licenses and third-party notices.
Native IDE, browser and iPhone acceptance follow their own release checks.

# Cleetus Web 0.3.22

Computer connections now bound preparation and handshake backlogs. Bulk requests
recheck whether their dedicated or fallback route is available while keeping their
original deadline. Shared protocol boundaries have additional compatibility checks
for each supported client.

Access that depends on a current subscription tier is checked again when a continuity
ticket is used. Work already issued with an unknown outcome still requires exact
reconciliation; reconnecting does not silently replay it.

Existing sign-in, access grants, saved data, provider setup, licenses and third-party
notices remain in force. This preview does not establish physical iPhone or sustained
cross-network connection acceptance.
