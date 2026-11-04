cask "cleetus" do
  version "0.2.7"
  sha256 "ed8a711191170a74cc8502c2d8220ca0a914fb59742bbca069afec5b08558e29"

  url "https://github.com/SnowBiz/cleetus-releases/releases/download/ide-v#{version}-macos-arm64/cleetus-ide-#{version}-macos-arm64.dmg"
  name "Cleetus"
  desc "Code - OSS editor with your own coding agents"
  homepage "https://cleetus.app/"

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "Cleetus.app"
end
