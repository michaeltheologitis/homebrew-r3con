#!/usr/bin/env bash
# Usage: set-version.sh VERSION DIGEST
# Points the cask at r3con VERSION, once its R3Con.dmg hashes to DIGEST (sha256:<hex>).
set -euo pipefail

version=$1
digest=$2
cask=Casks/r3con.rb
dmg=$(mktemp)
trap 'rm -f "$dmg"' EXIT
curl -sSfL -o "$dmg" "https://github.com/michaeltheologitis/r3con/releases/download/v$version/R3Con.dmg"
sha256=$(shasum -a 256 "$dmg" | cut -d ' ' -f 1)
if [[ sha256:$sha256 != "$digest" ]]; then
  echo "R3Con.dmg hashes to sha256:$sha256, but the release API gives $digest" >&2
  exit 1
fi
# -i.orig, which GNU and BSD sed both take.
sed -i.orig -e "s/^  version \".*\"$/  version \"$version\"/" -e "s/^  sha256 \".*\"$/  sha256 \"$sha256\"/" "$cask"
rm "$cask.orig"
grep -qx "  version \"$version\"" "$cask"
grep -qx "  sha256 \"$sha256\"" "$cask"
echo "$cask: version $version, sha256 $sha256" >&2
