# Classical Playlist — legal downloads

This repository tracks 50 requested classical pieces and the evidence needed to download legal recordings. A public-domain composition does **not** automatically make a particular recording free to copy. The [Musopen FAQ](https://musopen.org/faq/) explains the distinction between composition and sound-recording rights; the [Musopen catalog](https://musopen.org/music/) is used as the initial source for research.

Portuguese documentation: [README.pt-BR.md](README.pt-BR.md).

## Current status

The catalog pages are useful, but a specific recording, license, and direct audio URL still have to be selected and verified for each track. Therefore:

- 46 tracks remain `no_direct_url`;
- Albinoni’s *Adagio in G minor* and Barber’s *Adagio for Strings* are `copyright_review`;
- 4 tracks now have explicit Internet Archive URLs and were downloaded to `music/`.

No direct URLs were fabricated. Tracks whose sites require dynamic selection, JavaScript, or authentication remain in the inventory for manual review.

## Files

- `playlist.csv`: editable source of truth for the download queue;
- `playlist.json`: the same metadata as JSON;
- `resolve-links.py`: searches Internet Archive and adds only audio files with explicit compatible rights metadata;
- `download-classicos.sh`: safe downloader using `curl` (or `wget`), `.part` files, HTTP failure handling, and an HTML/JSON response check;
- `verify.sh`: checks files, MIME types, sizes, extensions, and `ffprobe` metadata when available;
- `music/`: downloaded audio (ignored by Git).

## Requirements and usage

Linux, Bash, Python 3, and either `curl` or `wget` are required. The `file` command is used for basic type detection; `ffprobe` is optional.

```bash
cd classical-playlist
python3 resolve-links.py
./download-classicos.sh
./verify.sh
```

The downloader skips every status other than `ready` and `mp3_only`, never overwrites an existing file, and moves a `.part` file into place only after a successful download.

`resolve-links.py` is intentionally conservative. It does not guess URLs and leaves tracks unchanged when Internet Archive has no explicit compatible rights metadata or no matching audio file. Review the generated metadata before downloading.

## Metadata and legal review

Each row records the composer, work, movement, performer, source page, direct URL, license, format, quality, filename, and status. Do not mark a track `ready` merely because the composition is old: verify the recording license as well. Do not convert MP3 to FLAC.
