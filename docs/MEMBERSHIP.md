# Membership and saved settings

The production membership catalog, saved-preference service and public website
guide are deployed. The public catalog has passed the client's strict catalog
validation, and unauthenticated preference reads and writes have been checked to
return an authorization failure. A native development host has passed Scout
sign-in and a production preference roundtrip: save reduced motion on, reload it,
save it off, then reload it again. Live paid-tier grants and subscription
purchases have not been tested.

The IDE 0.2.0 and extension 1.12.1 additions described here are implemented client
release candidates. Installed-app credential persistence and final native
installer acceptance remain pending. Check
[Install and update](INSTALL.md) for published downloads.

Cleetus membership adds curated resources to the existing local application.
Your coding-agent accounts, model subscriptions, API keys and provider permissions
remain separate. See [Your Cleetus account](ACCOUNTS.md) for sign-in and account
management.

## Tiers

| Tier | Candidate resources |
| --- | --- |
| **Scout · Free** (`free`) | All nine existing prebuilt teams, custom team creation and existing tools remain free local features. No Cleetus account is required for them. |
| **Wrangler · Pro** (`pro`) | Scout plus **Studio refinement**, **Release readiness** and two read-only membership tools. |
| **Foreman · Team** (`team`) | Wrangler plus **Cross-project review**. |

The existing [prebuilt teams](TEAMS.md), saved teams, tools and project data keep
their current behavior. A membership change does not automatically stop work
already running. New premium team admissions and premium tool calls must pass
their current feature checks.

Eligible existing paid memberships map to Wrangler. An unknown subscription or
a test-mode subscription never grants paid production access. Complimentary
Wrangler or Foreman access requires an explicit grant from the account service.
Foreman checkout remains unavailable until a distinct Team price is configured.

## Curated teams and tools

| Resource | Feature | What it does |
| --- | --- | --- |
| **Studio refinement** (`studio-refinement`) | Premium teams · Wrangler | A design curator, UI builder and independent reviewer refine real source using design rules, authorized references and actual evidence. |
| **Release readiness** (`release-readiness`) | Premium teams · Wrangler | A release lead, checks engineer and reviewer collect and assess evidence against the requested product's acceptance criteria. They do not publish a release. |
| **Cross-project review** (`cross-project-review`) | Team governance · Foreman | Scope, security and release reviewers assess the projects explicitly authorized by the user and their shared boundaries. |
| `membership_design_readiness` | Premium tools · Wrangler | Reads saved design manifest and discovery counts, rules presence and missing saved preview files. Discovery and historical previews do not establish current visual acceptance. |
| `membership_release_readiness` | Premium tools · Wrangler | Summarizes existing local jobs, workflows and task review records. It runs no commands, makes no network requests and grants no release approval. |

These teams use the existing team runtime, engines, tools and approval flow.
Their prompts require source evidence, authorized external sources, truthful
check reports and explicit authorization for deployment or publication. A
curated prompt cannot grant project access or bypass an approval.

To configure Cross-project review, open the intended project folders in the same
Cleetus window, choose **Configure Cross-project review**, and select **Project**
for each agent. Agents default to the current project. Agents assigned to other
opened projects use engine defaults for model and effort because that dialog has
no verified metadata for those projects. Creating the team saves it ready for
review; starting it still requires separate approval. Reopening or reloading a
premium draft rechecks membership, retaining the draft if access is unavailable.

## How access is decided

Account tier cards and locked resource catalogs display the account service's
verified membership catalog. The server controls tier grants and feature
availability. Display metadata, a local preference, a submitted template body or
a provider's model list cannot upgrade an account.

The shared Core checks access when a premium resource is requested. Registered
Core/MCP tool handlers also check each invocation, including direct calls that
do not come from Studio. A paid feature requires all of the following:

- A validated signed-in identity and an account profile verified less than five
  minutes ago, with an unexpired authentication token.
- The required tier and server entitlement grant. Subscription access also
  requires a live paid period that has not expired; an explicit complimentary
  grant uses its server-assigned tier.
- The feature enabled by the server, and no saved user opt-out for that feature.

The feature IDs are `premium-teams`, `premium-tools` and `team-governance`.
Unavailable, offline, stale or unknown verification denies new premium access.
A cached profile can remain visible as last known. Choose **Refresh account**
after a membership change or when verification expires.

These checks govern access to Cleetus's curated resources. They are not DRM and
do not change the licenses of existing code or provide third-party model,
provider or tool licenses.

## Saved Cleetus settings

Authenticated Scout accounts can save preferences too; this does not require a
paid membership. In native Studio, open **Account → Saved Cleetus settings**.
In VS Code, run **Cleetus: Account and Membership**, then choose **Saved Cleetus
settings** from the account menu.

The version 1 cloud preference record accepts only these values:

| Preference | Supported values |
| --- | --- |
| `startupView` | Agent Command (`command`), Teams (`teams`) or Design (`design`) |
| `reduceMotion` | On or off |
| `compactLayout` | On or off |
| `disabledFeatures` | Opt-outs for `premium-teams`, `premium-tools` or `team-governance` |

Feature switches can disable an otherwise available feature. Switching one on
still requires its verified tier, grant and server-enabled availability.

Provider credentials, project or machine paths, environment variables, tool
commands and configuration, projects, transcripts and team data are not part of
this preference sync. Keep using the existing local settings and provider flows
for those.

Each loaded draft has a short-lived, single-use edit grant tied to its account
session and revision. Signing out, switching accounts or refreshing account
verification invalidates an old draft. Matching display names, email addresses
or revision numbers cannot move that draft to another account. A successful save
returns a fresh edit grant for further changes; these local grants are not
synced to the service or saved as credentials.

Saves also use compare-and-swap conflict detection. If another installation has
saved a newer revision, Cleetus refuses to overwrite it. In Studio, choose
**Reload saved preferences**, review the current values, then make and save your
changes again. In VS Code, reopen **Saved Cleetus settings** to load the current
draft before editing and choosing **Save to Cleetus account**. A failed or stale
edit requires an explicit reload; conflicts are not silently merged or retried.

Feature opt-outs restrict access as soon as they are saved. A successful save
does not automatically refresh account verification. Choose **Refresh account**
to verify newly enabled features, then reload preferences before editing again.

[Your Cleetus account](ACCOUNTS.md) · [Prebuilt teams](TEAMS.md) · [Tools and integrations](TOOLS.md)
