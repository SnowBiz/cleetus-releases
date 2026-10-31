# Troubleshooting

_Read this guide on [cleetus.dev](https://cleetus.dev/docs/troubleshooting/)._

| Symptom | What to check |
| --- | --- |
| New version does not appear | In the IDE, quit and reopen Cleetus, then check **Cleetus: Show Build Info**. For the extension, reload the VS Code window and make sure the VSIX was installed in the profile you're using. |
| macOS IDE pauses after an update | Check for a macOS Keychain authorization request for Cleetus, particularly after replacing an unsigned development build. Complete any required authorization locally in macOS. Do not delete credentials or disable encryption to bypass it. |
| Claude executable unavailable | Install the release's SDK runtime with optional dependencies enabled. Make sure the runtime location and environment match what Cleetus was launched with. |
| Account label says connected but a request fails | Reconnect the engine and check actual account/model access. Provider labels are not authorization. |
| No models or unexpected choices | Refresh the catalog, reconnect the relevant engine/backend and confirm runtime support. |
| Design lists source but no visual preview | Install project dependencies and register a working adapter/story fixture. Source discovery is an inventory. |
| Web capture cannot start | Install a supported Chrome/Edge/Brave/Chromium executable or configure its path. Playwright Core does not download one for normal use. |
| Native preview fails | Use macOS/Xcode, an installed Simulator runtime, the configured target/scheme and a buildable Debug story host. Inspect build logs. |
| Service unavailable | Refresh its Settings card, reload the window, then inspect interrupted jobs and repository changes before retrying. |
| Tracker connection fails | Check HTTPS certificates, endpoint/account, local secret/environment token and required provider scope/SSO. Never disable TLS verification. |
| Claim or write times out | Reconcile remote state before retrying; the remote operation may have succeeded. Another agent's lease cannot be assumed available. |
| PR checks look stale | Refresh and inspect the exact head commit. Missing/pending/skipped evidence is not a pass. Publish tooling results through GitHub checks/statuses. |
| LAN pairing fails | Check that `openssl version` works, both computers are on the same private IPv4 subnet, the invitation is under ten minutes old and unused, and Wi-Fi isolation, a VPN or a firewall isn't blocking it. See [LAN collaboration](COLLABORATION.md). |
| Workflow step blocked | A predecessor failed. Inspect its journal, fix the cause and start a new run; failed side effects aren't retried. See [Workflows](WORKFLOWS.md). |
| Task report rejected | Its execution lease expired or was replaced. Inspect the saved output and run the task again. See [Tasks](TASKS.md#execution-leases-and-fencing). |
| Update rejected | Check proxy/network policy and release assets. Mismatched version/size/checksum blocks installation. Use the [manual install](INSTALL.md). |

Native runtime/account capabilities and permissions determine feature availability. Stop/cancel is not rollback. Keep credentials, private transcripts and internal paths out of public bug reports; share the version, platform, reproducible steps and a redacted error.
