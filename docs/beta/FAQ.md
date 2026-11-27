# Cleetus Core beta: questions and answers

## What is it?

Cleetus Core is a small program that runs on your Mac or Linux computer and runs coding agents (Claude Code, Codex) for you in an isolated environment. The Cleetus iPhone app lets you start tasks, approve requests, review changes and merge, from anywhere in the room. Start with [Getting started](GETTING-STARTED.md).

## Is this the Cleetus IDE?

No. The IDE, the VS Code extension and the Node.js CLI described in the rest of this repository are a separate product with their own installs and docs. You do not need them for Core, and Core does not need them.

## Does my code leave my computer?

Cleetus does not upload it. Core runs on your computer and the agent works there. What reaches the Cleetus account service is your account, the list of your computers and their names and versions, and which devices you approved. The agent's own provider (Anthropic for Claude Code, OpenAI for Codex) sees what the agent sends it, under their terms, exactly as if you ran the tool yourself. Feedback you choose to send is covered below.

## What can the agent touch?

- It runs inside an isolated environment (a virtual machine), not directly on your computer.
- It only works on repositories you added, and each one has its own GitHub token limited to that repository.
- The token is stored in Core's encrypted store and is never given to the agent.
- Anything beyond that, such as running a command that needs approval, comes to your phone as a request that names exactly what it is. Approving one request does not approve the next.

## Why do I need to approve the computer?

So your phone and your computer can trust each other without you typing codes or passwords. You approve once in a browser; after that the computer is tied to your account until the approval ends or you revoke it. Anyone who has your account can see your approved computers, so protect the account.

## What does it cost?

Beta 1 is free from us. Claude Code and Codex are billed by their makers under your own plan; Cleetus does not resell or bundle model access.

## Which computers work?

| Computer | Beta 1 |
| --- | --- |
| Mac with Apple silicon, macOS 13 or newer | Yes |
| Linux, Intel or AMD 64-bit, Ubuntu 24.04 or Debian 12 or newer, with KVM | Yes |
| Linux on Arm (including a Raspberry Pi) | Not yet |
| Intel Mac | No |
| Windows | No |
| A cloud server | Only if it offers KVM (nested virtualization). Many do not. |

Check Linux KVM with `ls -l /dev/kvm`. If the file is missing, the installer will stop and say so.

## Can I control it when I am away from home?

Not in Beta 1. The phone and the computer must be on the same network (or the same private VPN such as Tailscale). Remote control from anywhere is planned for the next beta.

## Do I need an account?

Yes. The beta is by invitation. The invitation email walks you through the beta agreement and your account. The computer and the phone use the same account. If the invitation has not arrived, check your spam folder, then email [support@cleetus.app](mailto:support@cleetus.app).

## How do I get the iPhone app?

Through TestFlight, using the invitation we send. Beta builds from TestFlight stop working after about 90 days, so install the newer one when we send it. There is no App Store version.

## What do you collect if I send feedback?

Only what you send. A message and your account ID. If you tick **Include diagnostics** (or pass `--diagnostics` to `cleetus-core feedback`), also: app and Core versions, your operating system version, the Core's status summary, and recent error or crash records, with names, file paths, network addresses and secrets removed. You are shown the full text before it is sent. It never includes your code, repository contents, prompts or conversations. It is stored privately under your account and read only by the Cleetus team to fix problems.

Crash reports are off unless you turn them on, and they leave your device only inside feedback you choose to send. We use no third-party crash service.

## How do I delete my data?

Email [support@cleetus.app](mailto:support@cleetus.app) from your account address. To remove a computer first, see revoke in Getting started, step 8.

## How do I report a bug?

iPhone app: **You**, **Help & support**, **Help and feedback**. Computer: `cleetus-core feedback`. Or email [support@cleetus.app](mailto:support@cleetus.app). Say what you did, what you expected and what happened. Add diagnostics if it is a crash or something that will not start.

## Why are the downloads public but the source private?

The program you install is published openly so installs are easy to verify. The source code is private and shared with testers under the beta agreement.

## Is it safe to leave running?

Core runs as you, not as an administrator, and only accepts requests from devices you approved. The one time it needs your administrator password is the installer's system setup on Linux. If you stop using it, uninstall it (Getting started, step 9) and revoke the computer.
