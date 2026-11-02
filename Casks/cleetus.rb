cask "cleetus" do
  version "0.2.3"
  sha256 "7b78383e373bcd77998bad5be934c5dc0cd5316eea534d46e34e6aa3c3fd96b2"

  url "https://github.com/SnowBiz/cleetus-releases/releases/download/ide-v#{version}-macos-arm64/cleetus-ide-#{version}-macos-arm64.dmg"
  name "Cleetus"
  desc "Code - OSS editor with your own coding agents"
  homepage "https://cleetus.app/"

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "Cleetus.app"
end
