#!/usr/bin/env bash
# Compares r3trace's latest release with the cask. Prints, for $GITHUB_OUTPUT, bump=true when
# the release is newer, its version, and the digest the release API gives its R3Trace.dmg.
set -euo pipefail

cask=Casks/r3trace.rb
release=$(gh api repos/michaeltheologitis/r3trace/releases/latest)
tag=$(jq -r .tag_name <<<"$release")
if [[ ! $tag =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "r3trace's latest release is $tag, not vX.Y.Z" >&2
  exit 1
fi
version=${tag#v}
digest=$(jq -r '.assets[] | select(.name == "R3Trace.dmg") | .digest' <<<"$release")
if [[ ! $digest =~ ^sha256:[0-9a-f]{64}$ ]]; then
  echo "r3trace $tag has no R3Trace.dmg with a sha256 digest" >&2
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
