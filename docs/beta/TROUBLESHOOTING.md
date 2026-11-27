# Troubleshooting Cleetus Core (Beta 1)

Find your message or symptom, then do the one fix next to it. If it does not help, run `cleetus-core feedback` (or use **You, Help & support, Help and feedback** in the iPhone app) and add diagnostics. You see exactly what is sent first.

Start with the quick health check, which most fixes below refer to:

```sh
cleetus-core inspect status
```

If it prints a status, Core is running. If it cannot connect, see [Core is not running](#core-is-not-running).

## Installing (Linux)

The installer stops with a message in this form: "this installer needs ... " and one next step. These are the ones you may see.

| You see | Do this |
| --- | --- |
| this installer is for Linux | On a Mac, use the Cleetus Core `.pkg` instead. |
| this computer's processor is not supported | Use a 64-bit Intel or AMD Linux computer. Arm Linux is not in Beta 1. |
| do not run the installer as root | Run it as your everyday user. It asks for `sudo` once by itself. |
| Python is older than 3.11 | Use Ubuntu 24.04 or Debian 12 or newer, or install Python 3.11 or newer. |
| your systemd user session is not running | Log in to the computer directly (not only with `su`), or run `sudo loginctl enable-linger $(id -un)` and log in again. |
| this computer has no KVM virtualization | Turn on virtualization in the computer's firmware settings. On a cloud server, choose a type that offers nested virtualization, or use another computer. There is no fallback: Cleetus will not run agents without isolation. |
| this step needs your answer, but there is no terminal | Run the installer in a terminal, not from a script or a pipe with no screen. |
| the license was not accepted | Run it again and accept, or nothing is installed. |
| the system setup did not finish | Read the message above it, fix what it names, run the installer again. It is safe to repeat. |
| Core did not start, so the previous state was restored | Run the installer again. If it repeats, send feedback with diagnostics. |
| the release could not be downloaded and verified | Check your network and run again. A verification failure is never ignored; do not look for a way around it. |

After the installer, **log out and back in once** if it says so. Linux only applies the new KVM access at login.

## Approving the computer

| You see | Do this |
| --- | --- |
| The link says the code is wrong or expired | The code lives for a few minutes. Run `cleetus-core account login` for a fresh link. |
| "Already approved" but the app does not show the computer | Run `cleetus-core account status`. If it says signed in, wait a minute and pull to refresh in the app. If not, run `cleetus-core account login`. |
| The browser did not open | Over SSH it does not open by itself. Copy the link it printed into any browser. |
| It asks you to sign in again after a few days | Today an approval lasts up to seven days. Approve again. Approvals that last until you revoke them are arriving. |
| "credential storage" error | Core keeps your sign-in in the system keyring. On Linux the keyring must be unlocked and the installer's system setup must have finished: re-run the installer. On a Mac, open Keychain Access and unlock the login keychain, and allow Cleetus if it asks. |
| You approved the wrong computer | Revoke it (see the getting started guide, step 8) and approve the right one. |

## The phone does not see the computer

1. Both must be signed in to the same Cleetus account. In the app, **You**, then **Account**.
2. The phone and the computer must be on the same network (or private VPN) in Beta 1. A guest Wi-Fi that isolates devices will not work. A hotspot on the phone is fine if the computer joins it.
3. Check Core is running: `cleetus-core inspect status`.
4. If a firewall is on, it must let Core accept connections from your local network. Core warns when it finds its listener port blocked. Allow it, or turn the firewall rule off for your home network.
5. On the computer, `cleetus-core account hosts` lists the computers your account can see. If yours is missing, run `cleetus-core account login`.
6. Still stuck: pair directly. On the computer turn on **Phone control**, then use **Connect device** in the app. See [Phone control](../PHONE_CONTROL.md).

Codes: if you are asked to compare an eight-digit code, only approve when both screens show the same number. If they differ, cancel.

## The agent will not start

| You see | Do this |
| --- | --- |
| No agent or engine to choose | Run `cleetus-core provider catalog`. If your tool is listed, run `cleetus-core provider use-existing codex` (or `claude-code`). If it is not, install and sign in to the tool first. |
| The agent says it is not signed in | Sign in with the agent's own tool on the computer (for example `claude auth status` or `codex login`), then try again. Cleetus cannot sign in for it. |
| "isolation unavailable" or similar | Run `cleetus-core inspect isolation`. On Linux, the usual cause is no KVM access in this login session: log out and back in. Without KVM the agent will not run. |
| The repository is missing from the phone | It has not been added to this computer. See getting started, step 5. |
| "token" or "permission" errors on a repository | The GitHub token expired or is missing a permission. Make a new fine-grained token for only that repository with Contents and Pull requests set to Read and write, and add the repository again. |
| It started but nothing happens | Open the task in the app. If it is waiting, there is a request in your **Inbox** for you to approve. |

## Core is not running

Linux:

```sh
systemctl --user status cleetus-host-core.service
journalctl --user -u cleetus-host-core.service -n 50
systemctl --user restart cleetus-host-core.service
```

Mac: open the Cleetus app. It starts Core. If it does not, restart your Mac, or log out and in.

If it keeps stopping, run `cleetus-core feedback --diagnostics` so we get the crash record.

## Updates

| You see | Do this |
| --- | --- |
| `cleetus-update check` says the update channel is old or invalid | Your clock may be wrong, or the channel could not be fetched. Check the date and network and try again. A bad channel is refused on purpose. |
| The update did not start the new version | It goes back to the previous version by itself. Try `cleetus-update apply` again later, and send feedback if it repeats. |
| You want the old version back | `cleetus-update rollback`. Your data stays; approvals and revocations are not rolled back. |

## Not covered

Anything about the Cleetus IDE, VS Code extension or Node.js CLI is in the main [troubleshooting guide](../TROUBLESHOOTING.md). That is a separate product.
