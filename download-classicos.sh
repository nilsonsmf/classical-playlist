#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
CSV="$ROOT/playlist.csv"
DEST="$ROOT/music"
mkdir -p "$DEST"

if command -v curl >/dev/null 2>&1; then
  DOWNLOADER=curl
elif command -v wget >/dev/null 2>&1; then
  DOWNLOADER=wget
else
  echo "Error: install curl or wget." >&2
  exit 1
fi

command -v python3 >/dev/null 2>&1 || { echo "Error: python3 is required to parse CSV safely." >&2; exit 1; }

echo "Source: $CSV"
echo "Destination: $DEST"

while IFS=$'\x1f' read -r number _composer _title _movement _performer _source _page url _license format _quality filename status; do
  [[ "$number" == "track_number" || -z "$number" ]] && continue
  if [[ "$status" != "ready" && "$status" != "mp3_only" ]]; then
    printf '[%s] skipping (%s): %s\n' "$number" "$status" "$filename"
    continue
  fi
  if [[ -z "$url" ]]; then
    printf '[%s] skipping (no direct URL): %s\n' "$number" "$filename"
    continue
  fi

  target="$DEST/$filename"
  part="$target.part"
  if [[ -s "$target" ]]; then
    printf '[%s] already exists: %s\n' "$number" "$filename"
    continue
  fi
  rm -f -- "$part"
  printf '[%s] downloading: %s\n' "$number" "$filename"
  if [[ "$DOWNLOADER" == curl ]]; then
    curl --fail --location --retry 3 --continue-at - --output "$part" "$url"
  else
    wget --continue --tries=3 --output-document="$part" "$url"
  fi

  [[ -s "$part" ]] || { echo "Empty download: $url" >&2; rm -f -- "$part"; continue; }
  mime=$(file --brief --mime-type -- "$part" 2>/dev/null || true)
  if [[ "$mime" == text/html* || "$mime" == application/json* ]]; then
    echo "Response is not audio ($mime): $url" >&2
    rm -f -- "$part"
    continue
  fi
  mv -- "$part" "$target"
done < <(python3 - "$CSV" <<'PY'
import csv, sys
with open(sys.argv[1], newline='', encoding='utf-8') as f:
    for row in csv.DictReader(f):
        print('\x1f'.join(row.get(k, '') for k in (
            'track_number','composer','title','movement','performer','source',
            'source_page','download_url','license','format','quality','filename','status')))
PY
)

echo "Completed."
