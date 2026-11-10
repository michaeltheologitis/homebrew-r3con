#!/usr/bin/env bash
# Compares r3con's latest release with the cask. Prints, for $GITHUB_OUTPUT, bump=true when
# the release is newer, its version, and the digest the release API gives its R3Con.dmg.
set -euo pipefail

cask=Casks/r3con.rb
release=$(gh api repos/michaeltheologitis/r3con/releases/latest)
tag=$(jq -r .tag_name <<<"$release")
if [[ ! $tag =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "r3con's latest release is $tag, not vX.Y.Z" >&2
  exit 1
fi
version=${tag#v}
digest=$(jq -r '.assets[] | select(.name == "R3Con.dmg") | .digest' <<<"$release")
if [[ ! $digest =~ ^sha256:[0-9a-f]{64}$ ]]; then
  echo "r3con $tag has no R3Con.dmg with a sha256 digest" >&2
  exit 1
fi
current=$(sed -n 's/^  version "\(.*\)"$/\1/p' "$cask")
if [[ -z $current ]]; then
  echo "$cask has no version line" >&2
  exit 1
fi
newest=$(printf '%s\n' "$current" "$version" | sort -V | tail -n 1)
bump=false
if [[ $version != "$current" && $version == "$newest" ]]; then
  bump=true
fi
echo "cask $current, latest release $version: bump=$bump" >&2
printf 'bump=%s\nversion=%s\ndigest=%s\n' "$bump" "$version" "$digest"
