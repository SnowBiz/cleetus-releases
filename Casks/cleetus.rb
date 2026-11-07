cask "cleetus" do
  version "0.2.12"
  sha256 "dfdd776a539767b510a396691244754955c9ac12c65edb409d5e880ca135aae3"

  url "https://github.com/SnowBiz/cleetus-releases/releases/download/ide-v#{version}-macos-arm64/cleetus-ide-#{version}-macos-arm64.dmg"
  name "Cleetus"
  desc "Code - OSS editor with your own coding agents"
  homepage "https://cleetus.app/"

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "Cleetus.app"
end
