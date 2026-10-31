# Install and update Cleetus

Choose the native **Cleetus IDE 0.1.0** for macOS Apple Silicon or the **Cleetus VS Code extension 1.11.3** for ordinary VS Code. They have independent release and update channels; installing one does not require the other.

## Install Cleetus IDE for Apple Silicon

Use an Apple Silicon Mac with macOS 12 or newer.

1. Open the [IDE 0.1.0 release](https://github.com/SnowBiz/cleetus-releases/releases/tag/ide-v0.1.0-macos-arm64) and download [cleetus-ide-0.1.0-macos-arm64.dmg](https://github.com/SnowBiz/cleetus-releases/releases/download/ide-v0.1.0-macos-arm64/cleetus-ide-0.1.0-macos-arm64.dmg) plus `SHA256SUMS`.
2. Run `shasum -a 256 cleetus-ide-0.1.0-macos-arm64.dmg` and compare the complete result with that filename's entry in `SHA256SUMS`.
3. Open the signed and notarized DMG and drag **Cleetus.app** to **Applications**.
4. Launch **Cleetus** from Applications, then open your project folder.

When replacing an unsigned development app, macOS may request authorization for Cleetus’s existing Keychain item. Complete that system prompt locally to finish startup.

The IDE includes the editor, so you do not need VS Code or a source checkout. Its [Preview License](LICENSES.md) permits free personal and commercial use of the covered build. The [IDE guide](IDE.md) walks through Agent Command, teams, tasks, review and Design. Locally compiled unsigned development apps are separate from this installer.

For engine setup, install **Node.js 22+** and npm, then follow the separate runtime and account instructions below. You may use Claude, Codex or both; installing the editor does not install provider accounts or grant model access.

## Install the extension

Use **VS Code 1.94+**, Node.js 22+ and npm. The current clean-host engine-runtime audit covers macOS ARM64; other runtime platforms still need local verification.

1. Open the extension's [latest stable release](https://github.com/SnowBiz/cleetus-releases/releases/latest) ([1.11.3](https://github.com/SnowBiz/cleetus-releases/releases/tag/v1.11.3)).
2. Download `cleetus-<version>-universal.vsix` and `SHA256SUMS` from that release.
3. Verify the filename and full SHA-256 against `SHA256SUMS`.
4. In VS Code, open Extensions → **Install from VSIX…** and select the downloaded file. Alternatively, run `code --install-extension /path/to/cleetus-<version>-universal.vsix`.
5. Reload VS Code and open the Cleetus activity-bar icon.

Compute a checksum on macOS with `shasum -a 256 <file>`, on Linux with `sha256sum -c SHA256SUMS`, or in PowerShell with `Get-FileHash <file> -Algorithm SHA256`. A matching checksum establishes consistency with the downloaded release, not an independent publisher signature.

## Install the separate Claude runtime

The Claude SDK and executable are not bundled in the VSIX or native IDE. Install the version specified by the release. For the current release, run:

```sh
npm install --prefix "$HOME/.cleetus/runtime" --include=optional --omit=dev --no-audit --no-fund @anthropic-ai/claude-agent-sdk@0.3.312
```

PowerShell:

```powershell
npm install --prefix "$env:USERPROFILE\.cleetus\runtime" --include=optional --omit=dev --no-audit --no-fund @anthropic-ai/claude-agent-sdk@0.3.312
```

You can also download this public repository as a ZIP and run `node docs/install-runtime.mjs`. Keep `install-runtime.mjs` and its adjacent `runtime-package.json` together. This installer uses only Node.js built-ins and npm; it does not require private source access.

Keep optional dependencies enabled: they supply the platform executable. The official Claude VS Code extension is unnecessary. A custom runtime location requires the same `CLEETUS_RUNTIME_DIR` environment variable when launching VS Code or Cleetus IDE.

## Connect your engines

![Get started connection controls](screenshots/get-started.png)

For Claude account access, choose the appropriate Claude.ai or Anthropic Console sign-in and complete the runtime's browser/terminal flow. Bedrock uses your configured AWS region/profile and native credential chain. Account access and provider terms still apply.

For Codex, connect through browser/device sign-in. Cleetus can use a configured executable, a suitable Codex executable supplied by the official extension, or `codex` on PATH. A standalone CLI is required if no other executable is available. Bedrock support depends on runtime/account capability.

Open a project, then choose **Cleetus: Open Workspace**. Start with a bounded task, inspect tool requests and diffs, and run relevant checks. Connect accounts locally; installation does not transfer another computer's tokens or history.

## Optional LAN collaboration

Both computers need a build with collaboration support: extension 1.11.2 or later, or Cleetus IDE 0.1.0. Each person needs an existing local team and **OpenSSL on PATH**; `openssl version` must succeed. Both computers must share the same directly attached private IPv4 subnet. Start no network listener until you choose **Collaborate on LAN** and approve it. Follow the [pairing and proposal guide](COLLABORATION.md); there is no automatic discovery or reconnect.

## Updates

In ordinary VS Code, these update controls install the extension VSIX. In Cleetus IDE, **Check for Updates** checks the independent native release channel. A verified notarized IDE installation can stage and recheck a signed installer from the same publisher before you explicitly open it. Unsigned development builds offer release notes only; the updater never replaces the app silently or bypasses Gatekeeper. For manual installation, use the [IDE 0.1.0 release](https://github.com/SnowBiz/cleetus-releases/releases/tag/ide-v0.1.0-macos-arm64).

If you installed 1.10.0 or earlier, manually install 1.10.1 or newer once. Older builds check the former release location; they cannot discover releases after its source repository became private. Subsequent updates use this public download repository.

The VS Code extension checks its public latest stable release shortly after startup, at most once per day after a successful check. Run **Cleetus: Check for Updates** to check immediately, or disable **checkForUpdates** in Settings → Extension preferences.

Choose **Release notes** to review the release, or explicitly choose **Download & install**. Cleetus verifies the versioned VSIX's size and SHA-256 before asking VS Code to install it. Choose **Reload window** to activate the new version. It does not silently install updates. Draft/prerelease/incomplete releases and mismatched checksums are rejected.

Engine subscriptions, model usage and third-party services are separate costs. See [licensing](LICENSES.md) and [troubleshooting](TROUBLESHOOTING.md).
