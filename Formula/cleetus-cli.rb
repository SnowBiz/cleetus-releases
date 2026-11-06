class CleetusCli < Formula
  desc "Terminal workspace and headless host for your own coding agents"
  homepage "https://cleetus.app/"
  url "https://github.com/SnowBiz/cleetus-releases/releases/download/cli-v0.2.9/cleetus-cli-0.2.9.tgz"
  sha256 "bdb0cc786d6d191e68d61718307ce5776f74615bd83fcb2f61de8bb16b390c0d"
  license all_of: ["Apache-2.0", :cannot_represent]

  on_linux do
    on_intel do
      skip_clean "libexec/linux-host"
      resource "cleetus-linux-host-preview" do
        url "https://github.com/SnowBiz/cleetus-releases/releases/download/cli-v0.2.9/cleetus-cli-linux-host-preview-0.2.9.tar.gz"
        sha256 "4df8ccbfed09cfb796c67ef55b90e19d12c1ed487cc85d77d58bba136caba2ad"
      end
      resource "cleetus-linux-browser" do
        url "https://cdn.playwright.dev/builds/cft/156.0.8078.4/linux64/chrome-linux64.zip"
        sha256 "43fd31766c7533a02dda2ded5ad50c2f861cd5400be7509c0abad71129f79d79"
      end
    end
  end

  depends_on "node@22"
  depends_on "openssl@3"
  depends_on "tmux"

  on_linux do
    depends_on "acl"
    depends_on "dbus"
    depends_on "glib"
    depends_on "libsecret"
  end

  def skip_clean?(path)
    if OS.linux? && Hardware::CPU.intel?
      return false if path.each_filename.any? { |part| part == "." || part == ".." }
      return true if prefix.directory? && path == prefix.realpath/"libexec/linux-host"
    end
    super
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
        archiveSHA256: "bdb0cc786d6d191e68d61718307ce5776f74615bd83fcb2f61de8bb16b390c0d",
        helperSHA256:  "7875ff37e54494a5722d490e62ab325937f82ccbe38b81ef75ad38e96b2c47ba",
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
    entry = libexec/"bin/cleetus"
    if OS.linux? && Hardware::CPU.intel?
      resource("cleetus-linux-host-preview").stage { (libexec/"linux-host").install Dir["*"] }
      resource("cleetus-linux-browser").stage { (libexec/"linux-host/browser").install Dir["*"] }
      (libexec/"linux-host").find do |file|
        odie "Linked Preview resource denied" if file.symlink?
        mode = file.directory? || (file.stat.mode & 0111).positive? ? 0755 : 0644
        chmod mode, file
      end
      cp libexec/"cleetus-homebrew.json", libexec/"linux-host/base/cleetus-homebrew.json"
      chmod 0644, libexec/"linux-host/base/cleetus-homebrew.json"
      host_setup = JSON.parse((libexec/"cleetus-setup.json").read)
      host_setup["version"] = 2
      host_setup["pins"].merge!({"hostArchiveSHA256" => "4df8ccbfed09cfb796c67ef55b90e19d12c1ed487cc85d77d58bba136caba2ad", "hostManifestSHA256" => "9ad0144e23af5b142d68894e13a75b6c1ca298becbef8cad92a16e35889260ee", "browserManifestSHA256" => "8f4aa809bc414bbddebde4c86935e027fc785ab8438150b1a6d9ac4f37600220"})
      (libexec/"linux-host/base/cleetus-setup.json").write JSON.generate(host_setup)
      chmod 0644, libexec/"linux-host/base/cleetus-setup.json"
      entry = libexec/"linux-host/cleetus-host.mjs"
      system formula_opt_bin("node@22")/"node", entry, "--version"
    end
    runtime_path = [
      formula_opt_bin("node@22"), formula_opt_bin("openssl@3"), formula_opt_bin("tmux"), "$PATH"
    ].join(File::PATH_SEPARATOR)
    (bin/"cleetus").write_env_script entry, PATH: runtime_path
  end

  def caveats
    <<~EOS
      Linux x86_64 includes the separate Cleetus Linux Host Preview and a pinned browser.
      Other platforms use the independent Apache CLI. Coding agents install separately.
      Remote stays off until explicit enablement and normal account/key approval.
      Sign-in, phone/LAN access and headless services require explicit setup.
      On Linux, OS Secret Service/D-Bus prerequisites are required for credentials.
    EOS
  end

  test do
    assert_match "0.2.9", shell_output("#{bin}/cleetus --version").strip
    assert_match "Cleetus", shell_output("#{bin}/cleetus --help")
    roles = JSON.parse(shell_output("#{bin}/cleetus roles --json"))
    assert_equal 54, roles.fetch("roleCatalog").length
    assert_equal 9, JSON.parse(shell_output("#{bin}/cleetus templates --json")).length
  end
end
