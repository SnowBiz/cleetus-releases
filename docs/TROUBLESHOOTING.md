# Troubleshooting

| Symptom | What to check |
| --- | --- |
| New version does not appear | Reload the target VS Code window and use **Cleetus: Show Build Info**. Ensure the VSIX was installed in the profile you are using. |
| Claude executable unavailable | Install the release's SDK runtime with optional dependencies enabled. Ensure the runtime location/environment matches VS Code. |
| Account label says connected but a request fails | Reconnect the engine and check actual account/model access. Provider labels are not authorization. |
| No models or unexpected choices | Refresh the catalog, reconnect the relevant engine/backend and confirm runtime support. |
| Design lists source but no visual preview | Install project dependencies and register a working adapter/story fixture. Source discovery is an inventory. |
| Web capture cannot start | Install a supported Chrome/Edge/Brave/Chromium executable or configure its path. Playwright Core does not download one for normal use. |
| Native preview fails | Use macOS/Xcode, an installed Simulator runtime, the configured target/scheme and a buildable Debug story host. Inspect build logs. |
| Service unavailable | Refresh its Settings card, reload VS Code, then inspect interrupted jobs and repository changes before retrying. |
| Tracker connection fails | Check HTTPS certificates, endpoint/account, local secret/environment token and required provider scope/SSO. Never disable TLS verification. |
| Claim or write times out | Reconcile remote state before retrying; the remote operation may have succeeded. Another agent's lease cannot be assumed available. |
| PR checks look stale | Refresh and inspect the exact head commit. Missing/pending/skipped evidence is not a pass. Publish tooling results through GitHub checks/statuses. |
| Update rejected | Check proxy/network policy and release assets. Mismatched version/size/checksum blocks installation. Use the [manual install](INSTALL.md). |

Native runtime/account capabilities and permissions determine feature availability. Stop/cancel is not rollback. Keep credentials, private transcripts and internal paths out of public bug reports; share the version, platform, reproducible steps and a redacted error.
