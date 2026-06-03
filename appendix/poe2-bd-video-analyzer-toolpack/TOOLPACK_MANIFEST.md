# Toolpack Manifest

Package name: `poe2-bd-video-analyzer-toolpack`

Purpose: optional material-preparation helper for the `poe2-bd-video-analyzer` Skill.

## Files

| Path | Purpose |
|---|---|
| `README.md` | Toolpack usage and boundaries |
| `TOOLPACK_MANIFEST.md` | Package contents and safety notes |
| `config/toolpack.example.json` | Example local dependency paths |
| `scripts/check_environment.ps1` | Check whether required tools are available |
| `scripts/prepare_public_video.ps1` | Download public video, extract audio, optionally transcribe and extract keyframes |

## Required External Tools

| Tool | Required | Purpose |
|---|---:|---|
| `yt-dlp` | Yes for URL downloads | Public-video download |
| `ffmpeg` | Yes | Audio and keyframe extraction |
| `whisper.cpp` | Optional | Local rough transcription |
| Whisper model file | Optional | Required only when using `whisper.cpp` |

## Output Layout

```text
output/
  video/
  audio/
  transcript/
  keyframes/
  SOURCE_MANIFEST.md
```

## Boundaries

This toolpack does not include or require cookies, tokens, passwords, API keys, paid-video access, private-video access, or platform login.

It is intended for public material preparation only.
