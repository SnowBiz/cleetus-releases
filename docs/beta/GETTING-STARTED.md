# Getting started with Cleetus Core (Beta 1)

Cleetus Core runs coding agents on your own computer. Your iPhone is the remote control: you start a task, approve what the agent wants to do, look at the changes and merge. Your code stays on your computer.

This guide takes you from nothing to a first task finished from your phone. Plan for about 30 minutes, most of it waiting for installs.

> **This is the Core beta, a different product from the Cleetus IDE and the Node.js CLI** described elsewhere in this repository. Nothing here needs the IDE. If you installed the IDE or CLI, you can leave them in place.

> **Beta status.** Each step below says what works today and what is still arriving. Anything marked **Arriving** is built but not in a published release yet. The [known limits](KNOWN-LIMITS.md) list everything in one place. If a step does not match what you see, please [tell us](#get-help).

## Before you start

You need:

- an invitation email from us and a Cleetus account (the beta is invitation only);
- a Mac with Apple silicon (the app needs macOS 13 or newer), or a 64-bit Intel or AMD Linux computer with Ubuntu 24.04 or Debian 12 or newer;
- for Linux: hardware virtualization (KVM), which Cleetus uses to keep agents in an isolated virtual machine. Most desktops and servers have it. Many cloud servers do not, unless they offer "nested virtualization";
- an iPhone with iOS 18 or newer;
- Claude Code or Codex on that computer, signed in with your own account (step 4);
- a GitHub repository you can push to.

On the same Wi-Fi or network for now: in Beta 1 your phone and your computer must be on the same network (or the same private VPN). Control from anywhere is not in this beta.

## 1. Install Core

Pick your computer.

### Linux

Open a terminal as your everyday user (not root) and run the installer from this repository:

```sh
curl -fsSL https://raw.githubusercontent.com/SnowBiz/cleetus-releases/main/install/core.sh | sh
```

It checks your computer first and tells you in plain words if anything is missing, with one fix for each problem. Then it:

1. downloads the newest release and checks its signature, so a damaged or tampered download is refused;
2. shows the license and asks you to accept it;
3. asks once for your administrator password (`sudo`) to set up two things: KVM access for your account, and a private keyring that keeps your Cleetus secrets encrypted;
4. installs Core as a service that runs under your user;
5. asks you to approve the computer (step 2).

If it tells you to log out and back in once, do that: it is how Linux applies the KVM access.

You can install Core on a computer you only reach over SSH. Run the same command in the SSH session.

**Arriving:** the installer is built and tested, but its first public release has not been published yet. Until it is, you will get an installer link in your invitation email.

### Mac

Download `Cleetus-Core-macOS.pkg` from the [latest Core release](https://github.com/SnowBiz/cleetus-releases/releases), open it, accept the license and enter your Mac password once. The app installs for your user, Core starts as your login service, and the app opens on the approval screen (step 2). No terminal needed.

**Arriving:** the signed, notarized Mac package is built by the release pipeline but has not been published yet. Until it is, your invitation email will say how to get a build.

## 2. Approve this computer, once

Core must be tied to your Cleetus account before your phone can see it. You do this one time per computer.

1. The installer (or the Mac app) shows a web link and opens it for you on a desktop. Over SSH it only prints it: open it on any device. Sign in to your Cleetus account. The link already contains the code, so you do not type anything. (If you open the plain address instead, it asks for the short code printed beside the link.)
2. Check that the computer name looks right and tap **Approve**.
3. Back on the computer it says it is approved.

That is the whole approval, once per computer.

**What works today:** the link, the one-tap approval page and one-tap revoke are live. Today a computer's approval lasts up to seven days, after which the computer shows the link again and you approve again. **Arriving:** approval that lasts until you revoke it (the page already offers it, and the next Core release uses it), the installer drawing the link as a QR code, and your phone asking you to confirm with Face ID instead of a web page.

If you closed the window, start it again any time:

```sh
cleetus-core account login
```

(On a Mac the command is `cleetus-host`, inside the app: `"$HOME/Applications/Cleetus Host UI.app/Contents/Helpers/cleetus-host" account login`. Every `cleetus-core` command in this guide works with that program on a Mac.)

Check it worked with `cleetus-core account status`.

## 3. Install the iPhone app

1. Install **TestFlight** from the App Store if you do not have it.
2. Open the TestFlight invitation email we sent you on your iPhone and tap **View in TestFlight**, then **Accept** and **Install**.
3. Open Cleetus. Sign in with the same Cleetus account you used in step 2.

When you sign in, your approved computers should appear in the app and connect by themselves. There are no codes to type.

**Arriving:** automatic appearance after sign-in is in the next app build. In the build you may have now, add your computer with **Connect device** instead: on the computer, turn on **Phone control**, then scan the QR code it shows with the app, compare the eight-digit code on both screens and approve on the computer. Read [Phone control](../PHONE_CONTROL.md) for that route.

If you do not have an invitation yet, ask the person who invited you.

## 4. Connect Claude Code or Codex

Cleetus does not include a model. It drives the agent tools you already use, with your own accounts and your own usage limits.

1. Install Claude Code or Codex on the computer, the way their makers describe, and sign in with that tool. (Cleetus never sees your sign-in; the tool keeps it.)
2. Ask Core what it can see:

   ```sh
   cleetus-core provider catalog
   ```

3. Let Core use the tool you already have, after a review you approve:

   ```sh
   cleetus-core provider use-existing codex
   # or
   cleetus-core provider use-existing claude-code
   ```

   Core shows exactly which program it will use and asks you to confirm. If the tool is missing and Core offers a reviewed copy, `cleetus-core provider install codex` (or `claude-code`) shows the exact release and destination before it asks.

Check the result with `cleetus-core provider status`.

Good to know: agents run in an isolated environment, and Codex sessions start read-only and ask before changing files or running commands.

## 5. Add a repository

Core only works on repositories you add. Each one gets its own limited GitHub key, so an agent can never touch anything else.

1. On GitHub, create a **fine-grained personal access token** for just that repository (Settings, Developer settings, Personal access tokens, Fine-grained tokens). Under repository permissions choose **Contents: Read and write** and **Pull requests: Read and write**. Nothing else. Set an expiry you are comfortable with.
2. Add the repository (the form below is the one that exists today):

   ```sh
   cleetus-core repository enroll --state-dir ~/.cleetus-host-ui/state --host-id YOUR_HOST_ID \
     --repository NAME --github OWNER/NAME --github-id GITHUB_REPO_ID \
     --objects PATH_UNDER_REPOSITORIES_ROOT --identity-name "Cleetus agent" \
     --identity-email you@example.com
   ```

   Core shows what it is about to enroll and asks for the token with a hidden prompt. The token is checked against GitHub for that one repository, saved in Core's encrypted store, and never given to an agent.

**Honest note:** this step is the roughest one in Beta 1. It needs the repository's numeric GitHub ID (find it with `gh api repos/OWNER/NAME --jq .id`) and a one-time `effects enable` setup. We are replacing it with `cleetus-core repository add OWNER/NAME`, which will find the ID for you and open the token page with the right permissions ticked. If you get stuck, send us your command and the error with `cleetus-core feedback`.

## 6. Run your first task from the phone

1. In the app, pick your computer and your repository.
2. Choose a Cleetus role and the agent you connected, and write the task in plain words. Start small: "Add a test for the date parser" works better than "rewrite the app".
3. Send it. The agent starts on your computer. You see its conversation and progress on the phone. You can send follow-ups or stop it at any time.

## 7. Approve, review and merge

- **Approve.** When the agent wants to do something that needs your say-so, it lands in your **Inbox** as a request that says exactly what it is asking for. Approve or deny. An approval is one-time and for that exact request.
- **Review.** Open the finished work with **Review work**: a summary, the files changed and the code changes. Look at what changed before you accept anything. Checks (tests and so on) appear only when your computer reports them.
- **Merge.** When the work is on a pull request, merge it on GitHub for now. Accepting a review in the app does not merge or deploy anything.

**Arriving:** merging from the phone, with Face ID, for the exact pull request you reviewed once its checks pass. Full side-by-side diffs on the phone are also improving.

## 8. Revoke a device

Lost a phone, sold a computer, or just finished testing? Revoke it.

- **A computer:** sign in at [cleetus.app](https://cleetus.app), open **Account**, then **Settings**, then **Your CLI computers**, and tap **Revoke** next to it. Or run `cleetus-core account logout` on that computer.
- **Also on the computer:** revoking in the web stops the computer from using your account. It does not yet remove phones that you paired with that computer directly. If a phone was lost, also run `cleetus-core owner-device list` on the computer and `cleetus-core owner-device revoke` for that phone, or remove it in the Mac app under Phone control.
- **A phone:** sign out in the app (**You**, then **Account**), then remove the phone in the same two places above.

After a revoke, the computer shows the approval link again if you want to use it again.

## 9. Update and uninstall

**Update.** On Linux, `cleetus-update check` tells you whether there is a newer release, and `cleetus-update apply` installs it after asking you (it asks for your password once to approve the new version). `cleetus-update rollback` goes back to the previous release and keeps your data. On Mac, install the newer package; the installer replaces the app and returns to the old one if the new one does not start.

**Uninstall.** There is not yet a one-command uninstaller. Do this, and your code and repositories are never touched:

1. Revoke the computer ([step 8](#8-revoke-a-device)).
2. Linux:

   ```sh
   systemctl --user disable --now cleetus-host-core.service
   rm -f ~/.config/systemd/user/cleetus-host-core.service ~/.local/bin/cleetus-core ~/.local/bin/cleetus-update
   rm -rf ~/.local/share/cleetus-host ~/.cleetus-host-ui
   systemctl --user daemon-reload
   ```

   The one-time system setup (your KVM group membership and the private keyring service) is harmless to leave in place. A one-command removal is not ready yet; email us if you want it removed.

   Mac: quit the app, then:

   ```sh
   launchctl bootout gui/$(id -u)/app.cleetus.host.ui.mac.core
   rm -f ~/Library/LaunchAgents/app.cleetus.host.ui.mac.core.plist
   rm -rf "$HOME/Applications/Cleetus Host UI.app" ~/.cleetus-host-ui
   ```

   Removing `~/.cleetus-host-ui` deletes Core's saved state and approvals. Do it only when you are done. You can also delete the Cleetus items in Keychain Access.
3. Delete the GitHub tokens you made in step 5.

## Get help

- Something not working: [Troubleshooting](TROUBLESHOOTING.md). Common questions: [FAQ](FAQ.md).
- Tell us about a bug or an idea: in the iPhone app open **You**, then **Help & support**, then **Help and feedback**. On the computer run `cleetus-core feedback`. You can add a diagnostics report; you see exactly what it contains before it is sent, and it never includes your code, prompts or conversations.
- Email [support@cleetus.app](mailto:support@cleetus.app).
