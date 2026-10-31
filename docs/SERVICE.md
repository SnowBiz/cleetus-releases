# Local service and agent jobs

_Read this guide on [cleetus.dev](https://cleetus.dev/docs/service/)._

Cleetus runs heavy and long-running work, such as tracker and PR requests and Design jobs, in a separate local service process. The editor stays responsive, a crash there can't take the editor down, and agents get a durable job queue they can submit to and check on.

![An agent submits a job; permissions run, the host adds identity, then a durable queue and two workers](images/diagram-service-jobs.png)

## What it is

- **A separate Node.js process** started automatically by Cleetus, talking to the editor over a **private inherited IPC channel**. It opens no network port and needs no URL, account or shared token.
- **Two workers** by default. Jobs for the same project run in order, and a project lock covers other Cleetus windows on that project.
- **Durable records** with bounded logs, kept in your profile.

It runs with your user's privileges. Process separation buys responsiveness and fault isolation; it isn't an OS sandbox.

![Settings → Cleetus service with service status and jobs](screenshots/service.png)

Open **Settings → Cleetus service** and choose **Refresh service & jobs** to see queued, running, completed and failed work, and to cancel a queued or running job.

## Let agents use it

| Tool                           | What it does                                          |
| ------------------------------ | ----------------------------------------------------- |
| `cleetus_service_capabilities` | Supported operations and ownership rules              |
| `cleetus_service_status`       | Service health                                        |
| `cleetus_job_submit`           | Queue a supported Design operation; returns a job ID  |
| `cleetus_job_list`             | This session's jobs                                   |
| `cleetus_job_get`              | Progress, result or error for a job this session owns |
| `cleetus_job_cancel`           | Cancel a job this session owns                        |

Supported operations include extraction, site capture, source rendering, component extraction, creation and checking, capture, comparison and mock cropping. Try: _"Run a background component extraction for `src/components`, tell me the job ID, and summarize the result when it finishes."_

## Ownership

The host, not the agent, supplies the session and project for every job. An agent can't name another owner, and it can't read or cancel another session's job by guessing its ID. Your own management view can see and cancel all of the profile's jobs; agents never get that broader view.

Submitting and cancelling go through the normal [permission flow](TOOLS.md#the-permission-flow), and turning off the Design tools setting blocks submissions. Job arguments still run real adapters, so source execution, network access and native builds behave as they would anywhere else.

## Recovery

- **Cancelling keeps writes already made.** Review the project before resubmitting.
- **Restarts don't replay.** Unfinished jobs owned by a stopped service become **interrupted**.
- **Remote writes that time out** may already have succeeded. Reconcile with the provider before retrying.
- **Closing Cleetus** stops the service and its jobs. Reload if the service becomes unavailable.

Tracker credentials come from the secure credential store through a narrow broker and are never written into job records. Environment-variable credentials must exist when the service starts.

[Cleetus Design](DESIGN.md) · [Work tracking](WORK_TRACKING.md) · [Architecture](ARCHITECTURE.md)
