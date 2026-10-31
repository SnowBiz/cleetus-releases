# Work tracking and PR evidence

_Read this guide on [cleetus.dev](https://cleetus.dev/docs/work-tracking/)._

Connect GitHub Issues, Jira or your own tracker, turn an issue into a task brief for a conversation or team, and see a pull request's checks, reviews and merge evidence for its exact head commit. Agents get the same access through engine-neutral tools, including atomic, fenced claims when your tracker supports them.

![Work tracking with a connected tracker and its issues](screenshots/work-tracking.png)

## Connect a tracker

1. Open **Work tracking** (or **Cleetus: Open Work Tracking**) and choose **Add connection**: GitHub Issues, Jira Cloud, Jira Data Center or Custom REST tracker.
2. Enter a name and the HTTPS API base URL. Use `https://api.github.com` for GitHub.com, or your GitHub Enterprise API root such as `https://your-host/api/v3`.
3. Set `owner/repository` for GitHub or the project key for Jira. Jira Cloud also needs your account email. Map an acceptance-criteria field by its ID, such as `customfield_12345`.
4. Enter a token, or the name of an environment variable that holds it.
5. **Check connection**, then **Load issues**. GitHub search takes issue-search syntax scoped to the repository; Jira takes a JQL condition such as `assignee = currentUser()`, without `ORDER BY`.

Tokens live in the secure credential store. Your profile's `work-tracking.json` holds only metadata and credential references, and an environment reference wins over a typed token. Jira Cloud uses email plus API token; Jira Data Center and GitHub use bearer tokens. There's no OAuth flow yet, and TLS validation is never disabled.

## From issue to work

**Review issue** shows the title, source, status, description and mapped acceptance criteria. **Draft in Conversation** inserts a task brief without sending it, and **Prepare team** opens team setup with the issue filled in.

The brief carries the connection ID, work-item ID, source URL and ownership context. Issue content is treated as **untrusted evidence**, not instructions, and long fields are marked truncated. Agents should call `work_tracker_get` for the full issue before implementing.

**Create issue** and **Post comment** publish only when you click submit. Writes aren't retried automatically, so after a timeout check the tracker before trying again.

## Pull request evidence

![Source, tooling checks, review and merge, all tied to the current head commit](images/diagram-pr-evidence.png)

Choose a GitHub connection, then **Pull requests → View PR flow**. Each card comes from GitHub check runs and commit statuses for the PR's **current head SHA**: tests, builds, SonarQube, Snyk, anything that reports to GitHub.

![Visual PR flow with source, tooling checks, review and merge cards](screenshots/pull-request-flow.png)

| State              | Means                                                                                    |
| ------------------ | ---------------------------------------------------------------------------------------- |
| Passed             | Every collected check succeeded and every evidence source completed                      |
| Pending            | At least one check is queued or running                                                  |
| Failed             | At least one check ended unsuccessfully                                                  |
| Attention          | Some results are neutral or skipped; they're never shown as passes                       |
| Unknown or missing | No usable evidence, an unavailable source, incomplete paging or an absent expected check |
| Stale              | The head moved while evidence was loading. Refresh before relying on it                  |

Add **Expected PR check names**, one exact name per line, so a check that never reported shows as missing. Reviews separate approvals on the current head from approvals on earlier commits. Branch protection and rulesets **aren't verified**, and Cleetus has no merge button: green cards are not permission to merge. Collection stops at 500 records per source with a warning, and checks published only on GitHub's synthetic merge commit aren't included.

## Agent tools

| Tool                         | What it does                                              |
| ---------------------------- | --------------------------------------------------------- |
| `work_tracker_connections`   | List connections, without credentials                     |
| `work_tracker_list`          | Search and page through work items                        |
| `work_tracker_get`           | Read an item with its acceptance and ownership context    |
| `work_tracker_pull_requests` | List the repository's PRs                                 |
| `work_tracker_pr_checks`     | Read head checks, review and merge evidence; never merges |
| `work_tracker_claim`         | Take an atomic claim; proceed only on success             |
| `work_tracker_renew`         | Renew a claim with its saved fencing generation           |
| `work_tracker_release`       | Release a claim with its saved fencing generation         |

## Claims and fencing

Claims are leases, not assignee labels. They need a tracker with an atomic ownership contract, configured as a custom REST adapter; GitHub and Jira assignment isn't treated as a lease. Turn on **Allow agent ownership operations** to enable them.

- **Claims belong to the Cleetus session**, not to an ID the agent supplies. Another local session can't renew or release them.
- **Local reservation first.** Concurrent claims are reserved locally before the network call, and your server arbitrates between machines.
- **Fencing generations.** The generation from each claim response is saved and sent with every renewal and release.
- **No automatic heartbeat.** Agents must renew before expiry.
- **Uncertain claims stay blocked.** If the network fails mid-claim, the uncertain receipt blocks a blind reclaim. **Ownership receipts → Reconcile locally** is the human recovery path: check the remote lease, then forget the local record. Forgetting doesn't release remote work.

## Custom REST adapter

Custom trackers are configuration, not code. Paths are relative to your API root and dotted paths address nested JSON:

```json
{
  "listPath": "/api/v1/work",
  "readPath": "/api/v1/work/{id}",
  "itemsPath": "items",
  "nextCursorPath": "nextCursor",
  "idField": "id",
  "titleField": "title",
  "descriptionField": "description",
  "statusField": "status",
  "criteriaField": "criteria",
  "contextFields": ["goalId", "dependencies", "owner", "lease"],
  "queryParam": "search",
  "cursorParam": "cursor",
  "limitParam": "limit",
  "auth": "bearer",
  "claimPath": "/api/v1/work/{id}/claim",
  "renewPath": "/api/v1/work/{id}/renew",
  "releasePath": "/api/v1/work/{id}/release",
  "claimDefaults": { "ttl": 60000 },
  "generationPath": "lease.generation",
  "generationField": "generation",
  "commentPath": "/api/v1/work/{id}/comments",
  "commentBodyField": "message"
}
```

Lists use GET; creating, commenting, claiming, renewing and releasing use POST JSON. Ownership paths must contain `{id}`, and a claim response must expose a fencing generation as a string or number. Use `"auth": "header"` with `"tokenHeader": "X-API-Key"` for a custom header. Leave a write path empty and that action stays unavailable. Give the adapter a scoped worker credential; it never bypasses your server's admission or scheduling.

Tracker and PR requests run in the [local service](SERVICE.md), which gets credentials through a narrow broker and never writes them into job records.

[Tasks](TASKS.md) · [Review & Ship](REVIEW.md) · [Local service](SERVICE.md)
