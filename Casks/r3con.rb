cask "r3con" do
  version "0.6.31"
  sha256 "362a96649f4f32f27c7a856d12abe8dcf9e578fe452906ba026c7586201a2eb4"

  url "https://github.com/michaeltheologitis/r3con/releases/download/v#{version}/R3Con.dmg"
  name "R3Con"
  desc "Answer questions whose evidence is spread across many documents"
  homepage "https://github.com/michaeltheologitis/r3con"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on :macos

  app "R3Con.app"

  zap trash: [
    "~/Library/Application Support/r3con",
    "~/Library/Caches/io.github.michaeltheologitis.r3con",
    "~/Library/HTTPStorages/io.github.michaeltheologitis.r3con",
    "~/Library/Preferences/io.github.michaeltheologitis.r3con.plist",
    "~/Library/Saved Application State/io.github.michaeltheologitis.r3con.savedState",
    "~/Library/WebKit/io.github.michaeltheologitis.r3con",
  ]
end
