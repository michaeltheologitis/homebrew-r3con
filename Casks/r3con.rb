cask "r3con" do
  version "0.6.12"
  sha256 "9098a161fd715783483e6cd90e94f838fa59dbc49b2d5c5adb651a9ba915e59c"

  url "https://github.com/michaeltheologitis/r3con/releases/download/v#{version}/R3Con-#{version}.dmg"
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
    "~/Library/WebKit/io.github.michaeltheologitis.r3con",
  ]
end
