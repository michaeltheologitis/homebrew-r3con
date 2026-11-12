cask "r3con" do
  version "0.6.22"
  sha256 "f8206230f1e04036af9243f375b17caafaa7ee5cb4e5eed6d85304bdaba44ae4"

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
