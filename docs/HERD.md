# Herd: direct the work, keep the code close

Herd is the new Cleetus workspace for planning work and controlling your crew.
Configure a team once, then follow its work, review decisions and inspect the
design without keeping the code editor in front of you.

**Availability:** this guide describes the next preview being validated. Earlier
IDE, CLI and iPhone releases do not automatically contain this interface. Check
the release notes for the product you install.

## One workspace, three views

- **Herd** shows the selected crew, observed activity, decisions and linked work.
- **Plan** turns the goal into outcomes, acceptance criteria, non-goals and open
  questions. A feature brief needs explicit scope before approval.
- **Design** opens the project's actual design library and configured source
  previews. Inspect pages, components and shared tokens beside the crew.

The desktop **Code** action returns to the traditional editor. On iPhone, Herd
is the overview; **Agents → Crews** opens crew configuration. Spec, Design and
Chat actions lead to the same work and selected crew. There is no second team
to configure inside a separate Herd subsection.

## From a goal to an approved build

1. Select the project and write a brief in **New work**.
2. Record the result you want, the checks that would establish success, and what
   is outside this change. Keep unresolved questions visible.
3. Select saved Design references where useful. Their exact contents are bound
   to the brief; a reference is not proof that the design was implemented.
4. Ask your crew to refine the draft. Cleetus prepares a message for review;
   selecting Refine does not send a message or start agents automatically.
5. Review and approve the exact brief revision, then choose the configured crew
   and separately authorize its build.

Cleetus preserves the crew's role prompts, engines, model and effort choices,
tool assignments and scheduling mode. A build has a linked execution record so
the conversation crew stays intact. The interface retains the original crew
name and lets you move between configuration and its current build. Configuration
changes apply to a later approved build; they do not silently rewrite active work.

Changing the approved brief, a bound Design reference or the crew configuration
invalidates the relevant authority. Cleetus refuses future dispatches that no
longer match it. This cannot undo an external tool that has already started.

## See what is actually happening

Role portraits identify the crew members. Models, effort, computer, task state
and connections come from available runtime records. A declared supervision
line does not mean agents have exchanged messages. Missing activity, usage or
check evidence stays unavailable rather than appearing as a successful check.

The crew conversation retains **Supervisor only** and **All agents** recipient
choices. Sending to every member can use more tokens. Read the recipients before
sending; a goal draft does not launch work until you authorize the relevant action.

## Keep Design tied to source

Select a saved page or component to open its configured source renderer in the
shared workspace. A web adapter can render real source at desktop and phone
sizes. Native Apple previews use the configured Simulator adapter. A catalog
entry without a runnable adapter is still a reference, not an interactive preview.

The inspector reports actual source metadata and shared tokens. Shared tokens
are library values; they are not automatically proven to be used by the selected
component. Acceptance criteria remain separate from observed test evidence.

## Work across computers

The **Computers** view uses observed, accepted host and worker offers. A reviewed
handoff carries the approved brief to the selected worker through Cleetus's
existing collaboration protocol. The receiving owner still reviews the work.
It does not copy a provider login, running model process or hidden conversation state.

An interrupted operation with an unknown outcome is retained for reconciliation.
Cleetus does not silently submit it again on reconnect.

Install an anchor with the [CLI guide](CLI.md). Linux supports the existing
protected system service. The new macOS service adapter is a per-user LaunchAgent:
it needs a logged-in user and available login Keychain, rather than acting as a
pre-login server. Windows service support has not been accepted.

Direct LAN or routed VPN connectivity still requires the remembered device
identity, fingerprint and exact permissions. Managed Cloudflare Relay is a
separate metered, Foreman private-preview capability. A subscription or an account
directory entry alone does not pair devices or enable Relay.

See [teams](TEAMS.md), [Design](DESIGN.md), [phone control](PHONE_CONTROL.md),
[accounts](ACCOUNTS.md) and [security](SECURITY_MODEL.md) for the underlying controls.
