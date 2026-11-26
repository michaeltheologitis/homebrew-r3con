cask "r3trace" do
  version "0.6.51"
  sha256 "8140b5875a539bf431338e4e82ab1de506cf0c7140604f6dae6e4bb68d9e6be4"

  url "https://github.com/michaeltheologitis/r3trace/releases/download/v#{version}/R3Trace.dmg"
  name "R3Trace"
  desc "Answer questions whose evidence is spread across many documents"
  homepage "https://github.com/michaeltheologitis/r3trace"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on :macos

  app "R3Trace.app"

  zap trash: [
    "~/Library/Application Support/r3con",
    "~/Library/Application Support/r3trace",
    "~/Library/Caches/io.github.michaeltheologitis.r3con",
    "~/Library/HTTPStorages/io.github.michaeltheologitis.r3con",
    "~/Library/Preferences/io.github.michaeltheologitis.r3con.plist",
    "~/Library/Saved Application State/io.github.michaeltheologitis.r3con.savedState",
    "~/Library/WebKit/io.github.michaeltheologitis.r3con",
  ]
end
