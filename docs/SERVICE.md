# Local service and agent jobs

Cleetus automatically starts a separate local service process. Tracker/PR requests and heavy Design work run outside the VS Code extension host. No additional service URL, account or shared agent token is needed.

![Service status and jobs](screenshots/service.png)

Open Settings → **Cleetus service** and choose **Refresh service & jobs**. Inspect queued/running/completed/failed work or cancel a queued/running job. Two workers run concurrently by default, with same-project work serialized and a project lock protecting cross-window jobs.

## Let agents use it

Claude and Codex receive the same tools; connected ACP agents can receive them
when their negotiated MCP support and explicit assignments allow it:

| Tool | Purpose |
| --- | --- |
| `cleetus_service_capabilities` | Discover supported operations and ownership rules |
| `cleetus_service_status` | Read service health |
| `cleetus_job_submit` | Queue a supported Design operation and return its job ID |
| `cleetus_job_list` | List the current session's jobs |
| `cleetus_job_get` | Inspect an owned job's progress/result/error |
| `cleetus_job_cancel` | Cancel an owned job |

Supported operations include extraction, site capture, source rendering, component extraction/creation/checking, capture, comparison and mock cropping. The host supplies the authenticated session and project; agents cannot choose another owner or inspect another session's job by guessing its ID. Normal tool permissions/hooks and the Design-tools setting remain effective.

Ask an agent to perform a background extraction, report its job ID and review the result. Job submission does not implicitly start a model/team. Design's **Extract from codebase** still provides the full reviewed extraction-team workflow.

## Recovery

Jobs retain durable state and bounded logs under the Cleetus profile.
Cancellation preserves writes already made. Released beta 3 reports interrupted
work after a stopped service without automatic replay. Current development /
upcoming-beta builds add the more precise cleanup states below; they are not part
of released beta 3.

- A queued job can become **cancelled** immediately because no worker launched.
- Cancelling a running job first records **cancellation-requested**. The project
  stays occupied until its owned worker and process-group cleanup are confirmed.
  The service requests termination, then uses bounded forced cleanup if needed;
  only confirmation allows the job to become **cancelled**.
- If termination cannot be confirmed, **cleanup-required** retains an explicit
  uncertain result and blocks new service jobs for that project. A previously
  running or cancelling job left by a stopped service also requires this review;
  a never-launched queued job becomes **interrupted**. Cleetus neither replays
  the work nor kills an arbitrary process from a saved PID after restart.

For **cleanup-required**, inspect the retained job/error, confirm its owned work
has stopped and reconcile repository changes before manual recovery. The fence
is not removed automatically. A late worker reply cannot turn a cancellation
request into a successful result. Closing the host awaits bounded owned cleanup;
if confirmation fails, the uncertainty record remains.

Damaged saved Design JSON is preserved and blocks replacement extraction writes.
A damaged session-history index is also preserved rather than replaced with an
empty index. These development-build recovery errors require repair or a
reviewed restoration; Cleetus does not silently delete or rebuild the originals.
See [workflow and saved-data recovery](TOOLS.md#workflow-execution-and-recovery).
Remote write timeouts still need provider reconciliation because an operation
may already have succeeded.

Reload VS Code if the service is unavailable. Closing the extension requests
cleanup of its owned service/jobs; use the recorded state to distinguish
confirmed cleanup from uncertainty. The service is local user code, not an OS
sandbox or remote multi-user control plane.

## Other hosts

Cleetus has a shared application and explicit host adapters so an independent client can reuse sessions, engine integrations and service tools. The current standalone browser developer host has partial UI parity. It is not a packaged/signed native IDE release, and no native IDE installer is implied by this guide.
