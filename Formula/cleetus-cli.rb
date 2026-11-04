class CleetusCli < Formula
  desc "Terminal workspace and headless host for your own coding agents"
  homepage "https://cleetus.app/"
  url "https://github.com/SnowBiz/cleetus-releases/releases/download/cli-v0.2.3/cleetus-cli-0.2.3.tgz"
  sha256 "2dd30e9e12f0449ee45ba6c0df8551dde38e5b328983cc2704601f9a70264b69"
  license "Apache-2.0"

  depends_on "node@22"
  depends_on "openssl@3"
  depends_on "tmux"

  on_linux do
    depends_on "acl"
    depends_on "dbus"
    depends_on "glib"
    depends_on "libsecret"
  end

  def install
    ENV.prepend_path "PATH", formula_opt_bin("node@22")
    node_version = Utils.safe_popen_read("node", "--version")
    odie "Cleetus requires the actual node@22 runtime" unless node_version.start_with?("v22.")
    ENV["PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD"] = "1"
    (buildpath/"empty-user.npmrc").write ""
    (buildpath/"empty-global.npmrc").write ""
    ENV["npm_config_userconfig"] = buildpath/"empty-user.npmrc"
    ENV["npm_config_globalconfig"] = buildpath/"empty-global.npmrc"
    system "npm", "ci", "--omit=dev", "--ignore-scripts", "--no-audit", "--no-fund",
           "--registry=https://registry.npmjs.org", "--fetch-retries=0"
    rm "empty-user.npmrc"
    rm "empty-global.npmrc"
    libexec.install Dir["*"]
    (libexec/"cleetus-setup.json").write JSON.generate(
      version:      1,
      distribution: "homebrew",
      pins:         {
        version:       version.to_s,
        archiveSHA256: "2dd30e9e12f0449ee45ba6c0df8551dde38e5b328983cc2704601f9a70264b69",
        helperSHA256:  "450790f60ffee6ac6082faaea19c957afe7594d7aa905e55a41c2a3fb1efdf6c",
      },
    )
    if OS.linux?
      tools = {
        secretTool:     (formula_opt_bin("libsecret")/"secret-tool").to_s,
        gdbus:          (formula_opt_bin("glib")/"gdbus").to_s,
        tmux:           (formula_opt_bin("tmux")/"tmux").to_s,
        openssl:        (formula_opt_bin("openssl@3")/"openssl").to_s,
        dbusRunSession: (formula_opt_bin("dbus")/"dbus-run-session").to_s,
        getfacl:        (formula_opt_bin("acl")/"getfacl").to_s,
      }
      (libexec/"cleetus-homebrew.json").write JSON.generate(
        version: 1, distribution: "homebrew", prefix: HOMEBREW_PREFIX.to_s, tools: tools,
      )
    end
    runtime_path = [
      formula_opt_bin("node@22"), formula_opt_bin("openssl@3"), formula_opt_bin("tmux"), "$PATH"
    ].join(File::PATH_SEPARATOR)
    (bin/"cleetus").write_env_script libexec/"bin/cleetus", PATH: runtime_path
  end

  def caveats
    <<~EOS
      Coding agents, model servers and browser binaries are installed separately.
      Sign-in, phone/LAN access and headless services require explicit setup.
      On Linux, OS Secret Service/D-Bus prerequisites are required for credentials.
    EOS
  end

  test do
    assert_equal "Cleetus CLI 0.2.3", shell_output("#{bin}/cleetus --version").strip
    assert_match "Cleetus", shell_output("#{bin}/cleetus --help")
    roles = JSON.parse(shell_output("#{bin}/cleetus roles --json"))
    assert_equal 54, roles.fetch("roleCatalog").length
    assert_equal 9, JSON.parse(shell_output("#{bin}/cleetus templates --json")).length
  end
end
