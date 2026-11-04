# Activity & diagnostics

Cleetus can show metadata about the agent work it owns, and—with separate
permission—report new metadata to an organization workspace. These are two
independent controls. Neither captures your prompts, tool arguments, credentials
or unrelated applications.

This feature requires a release that includes **Activity & diagnostics**. Older
installed builds do not gain it from an account or membership update.

## Inspect activity on this device

In the IDE, open **More → Activity & diagnostics**. In the VS Code workspace,
open **Settings → Activity & diagnostics → Open local activity**.

Choose **Enable local metadata** and review the project in the host confirmation.
The view can then show agent turn admission and dispatch, outcomes, approval
decisions, reported usage and Cleetus-owned service-worker lifecycle events.
Activity refreshes while the view is visible.

Local diagnostics are off by default. Consent lasts up to 24 hours for the exact
project you reviewed. Records stay in a bounded memory-only queue; restarting
does not restore its event history. **Turn off & clear local activity** clears
diagnostics without deleting your conversations.

The CLI uses the same host controls:

```sh
cleetus observation status
cleetus observation on
cleetus observation off
```

Select the current project using your normal CLI project selection. Enabling
requires an interactive terminal so you can review consent; a headless service
does not approve its own collection.

## Report to your organization

Organization reporting requires all of the following:

1. Sign in to Cleetus using the normal account flow.
2. Register this installation and have its complete key fingerprint approved in
   the Cleetus account portal.
3. Have an organization administrator permit metadata reporting and create a
   named reporting workspace in **Observability**.
4. In **Activity & diagnostics**, choose **Set up reporting**, then select the
   organization and workspace.
5. Review the separate host confirmation. It names the destination, data class,
   retention and consent period.
6. Have the organization administrator review and approve this enrollment in
   the portal. Choose **Check reporting** to retrieve its current state.

No local history is backfilled. Only new eligible metadata under that reporting
consent is queued. Local diagnostics can remain off while separately approved
organization reporting is on. The workspace displays a reporting indicator
while reporting is active, paused or awaiting a delivery result.

If setup is unavailable, check account sign-in, installation approval,
organization policy and server availability. Membership, phone pairing and
Remote access do not grant reporting consent.

## Read the results

Open your organization’s **Observability** page on the Cleetus website to review
your accessible activity and upload receipts. Members can inspect their own
enrolled scopes. Reading another member’s activity requires an explicit
workspace reader assignment; an administrator role alone does not grant that
access.

| Status | What to do |
| --- | --- |
| Waiting for installation review | Ask an organization administrator to compare and approve the full fingerprint. |
| Reporting on | New eligible metadata can be delivered to the shown workspace. |
| Reporting paused | Check account, policy and consent status before resuming. |
| Reporting action needs reconciliation | Check the original status or receipt. Cleetus does not repeat an uncertain enrollment, renewal, revocation or upload. |
| Reporting stop needs confirmation | Local cleanup or server revocation remains unconfirmed. Check details before assuming the queue was cleared. |
| Reporting access revoked | Complete a new explicit review if reporting is needed again. |

## Stop sharing and manage retained activity

Choose **Stop reporting & clear queue** to stop locally and discard pending
metadata. Cleetus also attempts to revoke the enrollment using your current
account authority. If the server cannot confirm revocation, that state stays
visible; stopping locally does not recall a batch already accepted by the server.

Accepted metadata expires from server reads after 24 hours. Physical database
cleanup may happen later. The portal’s own-scope hide control blocks access and
future ingestion for that scope; it does not claim immediate physical or backup
erasure. Revoking access and hiding retained activity are separate actions.

## Understand coverage

- This is partial operational evidence about Cleetus-owned work. It is not a
  system-wide process monitor or a claim that every provider child is observed.
- An optional host memory/CPU sample describes the shared Cleetus host. It is
  not attributed to a particular agent or model turn.
- Usage preserves its source and estimate status. Missing values remain unknown;
  reported zero stays zero. Partial usage is not an account total or invoice.
- Local diagnostics refresh quickly. Organization reporting uses bounded batches
  and is not the phone’s live agent-streaming transport.
- Reporting cannot approve tools, retry agent work, change provider permissions
  or turn an uncertain execution outcome into a success.

[Account setup](ACCOUNTS.md) · [Security model](SECURITY_MODEL.md) ·
[CLI guide](CLI.md)
