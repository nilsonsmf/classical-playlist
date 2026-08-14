#!/usr/bin/env bash
set -uo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
CSV="$ROOT/playlist.csv"
DEST="$ROOT/music"
missing=0

while IFS=$'\x1f' read -r number _composer _title _movement _performer _source _page _url _license format _quality filename status; do
  [[ "$number" == "track_number" || -z "$number" ]] && continue
  path="$DEST/$filename"
  if [[ ! -f "$path" ]]; then
    printf '[%s] MISSING (%s): %s\n' "$number" "$status" "$filename"
    ((missing++))
    continue
  fi
  size=$(stat -c '%s' -- "$path" 2>/dev/null || echo 0)
  mime=$(file --brief --mime-type -- "$path" 2>/dev/null || echo unknown)
  ext=${filename##*.}
  printf '[%s] %s bytes | %s | .%s | %s\n' "$number" "$size" "$mime" "$ext" "$filename"
  if (( size < 16384 )); then
    echo "  WARNING: file is smaller than 16 KiB" >&2
  fi
  if command -v ffprobe >/dev/null 2>&1; then
    ffprobe -v error -show_entries stream=codec_name,bit_rate,sample_rate,channels -show_entries format=duration -of 'default=noprint_wrappers=1' -- "$path" 2>&1 | sed 's/^/  /'
  fi
done < <(python3 - "$CSV" <<'PY'
import csv, sys
with open(sys.argv[1], newline='', encoding='utf-8') as f:
    for row in csv.DictReader(f):
        print('\x1f'.join(row.get(k, '') for k in (
            'track_number','composer','title','movement','performer','source',
            'source_page','download_url','license','format','quality','filename','status')))
PY
)

if (( missing )); then
  echo "$missing track(s) missing. Unverified tracks are not downloaded." >&2
  exit 1
fi
echo "All 50 tracks are present."
