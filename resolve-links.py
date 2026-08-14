#!/usr/bin/env python3
"""Resolve explicit, legally licensed Internet Archive audio URLs in playlist.csv.

This is deliberately conservative: items without an explicit Creative Commons,
Public Domain, or equivalent rights field are not added to the download queue.
"""
from __future__ import annotations

import csv
import json
import re
import sys
import time
from pathlib import Path
from urllib.parse import quote, urlencode
from urllib.request import Request, urlopen

ROOT = Path(__file__).resolve().parent
CSV_PATH = ROOT / "playlist.csv"
JSON_PATH = ROOT / "playlist.json"
SEARCH = "https://archive.org/advancedsearch.php"
META = "https://archive.org/metadata/"
AUDIO_EXTS = {".flac", ".mp3", ".ogg", ".oga", ".wav"}
LICENSE_RE = re.compile(r"creativecommons|public.?domain|cc0|license.?url", re.I)


def get_json(url: str) -> dict:
    req = Request(url, headers={"User-Agent": "classical-playlist/1.0"})
    with urlopen(req, timeout=30) as response:
        return json.load(response)


def text(value) -> str:
    if isinstance(value, list):
        return " ".join(map(str, value))
    return str(value or "")


def explicit_license(meta: dict) -> str:
    fields = meta.get("metadata", {})
    values = [fields.get(k, "") for k in ("licenseurl", "license", "rights", "usage", "description")]
    value = " | ".join(text(v) for v in values if v)
    return value if LICENSE_RE.search(value) else ""


def resolve(row: dict) -> tuple[str, str, str, str] | None:
    query = f'title:"{row["title"]}" AND (creator:"{row["composer"]}" OR subject:"{row["composer"]}") AND mediatype:audio'
    params = urlencode({"q": query, "fl[]": ["identifier", "title"], "rows": 20, "output": "json"}, doseq=True)
    result = get_json(f"{SEARCH}?{params}")
    for doc in result.get("response", {}).get("docs", []):
        identifier = doc.get("identifier")
        if not identifier:
            continue
        meta = get_json(META + quote(identifier, safe=""))
        license_text = explicit_license(meta)
        if not license_text:
            continue
        for item in meta.get("files", []):
            name = text(item.get("name"))
            ext = Path(name).suffix.lower()
            if ext not in AUDIO_EXTS or name.startswith("__MACOSX"):
                continue
            url = f"https://archive.org/download/{quote(identifier)}/{quote(name)}"
            fmt = "FLAC" if ext == ".flac" else "MP3" if ext == ".mp3" else ext[1:].upper()
            quality = text(item.get("size"))
            page = f"https://archive.org/details/{quote(identifier)}"
            return url, page, license_text, fmt + (f" ({quality} bytes)" if quality else "")
    return None


def main() -> int:
    rows = list(csv.DictReader(CSV_PATH.open(newline="", encoding="utf-8")))
    changed = 0
    for index, row in enumerate(rows, 1):
        if row.get("download_url") or row.get("status") == "copyright_review":
            continue
        try:
            found = resolve(row)
        except Exception as exc:  # network/API failures remain reviewable, never guessed
            print(f"[{index}] search error: {exc}", file=sys.stderr)
            continue
        if not found:
            print(f"[{index}] no explicitly licensed recording found")
            continue
        url, page, license_text, quality = found
        row.update({"source": "Internet Archive", "source_page": page, "download_url": url,
                    "license": license_text, "format": quality.split(" ", 1)[0],
                    "quality": quality, "status": "ready" if quality.startswith("FLAC") else "mp3_only"})
        changed += 1
        print(f"[{index}] encontrado: {url}")
        time.sleep(0.25)

    with CSV_PATH.open("w", newline="", encoding="utf-8") as output:
        writer = csv.DictWriter(output, fieldnames=rows[0].keys())
        writer.writeheader()
        writer.writerows(rows)
    JSON_PATH.write_text(json.dumps(rows, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"Updated {changed} track(s). Review the CSV before downloading.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
