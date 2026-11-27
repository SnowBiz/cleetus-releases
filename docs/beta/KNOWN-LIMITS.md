# Cleetus Core beta: known limits

What Beta 1 does not do yet, so nothing surprises you. This list is kept up to date with each release. Items marked **Arriving** are built but not yet in a published release.

## Where it works

- Mac with Apple silicon and Linux on 64-bit Intel or AMD. No Windows, no Intel Mac, no Linux on Arm yet.
- Linux needs KVM, Python 3.11 or newer, a systemd user session and one administrator password at install. Cloud servers without nested virtualization will not work.
- The phone and the computer must be on the same network or private VPN. Control from anywhere is not in Beta 1.
- The iPhone app is through TestFlight only. Builds expire after about 90 days.

## Installing and updating

- **Arriving:** the first public Linux installer and signed Mac package.
- Linux updates are `cleetus-update check`, `apply` and `rollback`. Each update asks for your administrator password once.
- Mac updates are a newer package; the app does not check for updates by itself yet.
- There is no one-command uninstaller. [Getting started](GETTING-STARTED.md#9-update-and-uninstall) lists the steps. The Linux system setup is left in place unless you ask us to remove it.

## Approving and revoking

- Today an approval on the computer lasts up to seven days, then you approve again. **Arriving:** approval until you revoke it, a QR code at install, and confirming on your phone with Face ID.
- **Arriving:** your signed-in phone showing your computers by itself. In the build you may have, add the computer with **Connect device** and the eight-digit code.
- Revoking a computer in your account does not yet remove phones you paired with it directly. Remove those on the computer too (Getting started, step 8).

## Repositories, tasks and review

- Adding a repository is a command-line step that needs the repository's numeric GitHub ID and a GitHub token you create. **Arriving:** `cleetus-core repository add OWNER/NAME`.
- Core opens a pull request for finished work. You merge it on GitHub. **Arriving:** merge from the phone, with Face ID, for the exact pull request you reviewed once its checks pass.
- Reviewing on the phone shows a summary, the changed files and code changes. A full side-by-side diff on the phone is still improving; use GitHub for large changes.
- Accepting a review in the app does not merge or deploy anything.
- Results of tests and checks show only when your computer reports them. Missing checks are shown as missing, never as passed.

## Agents

- Claude Code and Codex, signed in with your own accounts. Other engines are not part of this beta.
- Codex sessions start read-only and ask before writing or running commands.
- Cleetus does not bring models, usage or billing for them. Your provider's limits apply.

## Help and data

- Support is one email address, [support@adaptivebase.app](mailto:support@adaptivebase.app), plus in-app and command-line feedback. There is no status page; this list and the release notes are it.
- Account deletion and data export are handled by email for now.
- Beta software can lose a task in the middle of an update or crash. Core records what it was doing and never repeats an action on its own after a restart; if a task shows as unknown, check the repository before you retry.
