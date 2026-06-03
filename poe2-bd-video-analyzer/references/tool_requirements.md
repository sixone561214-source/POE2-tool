# Optional Tool Requirements

This skill can work without the toolpack if the user provides transcript text, screenshots, POB links, or author notes.

Use the optional toolpack only when automatic preparation is needed.

If this Skill is distributed through a repository that includes `appendix/poe2-bd-video-analyzer-toolpack/`, that appendix can be used as a lightweight helper package for public-video preparation.

## Minimum

- User-provided transcript or notes
- User-provided screenshots or POB links if talent/equipment images are needed

## Standard

- `yt-dlp`: download public videos
- `ffmpeg / ffprobe`: inspect video, extract audio, extract keyframes
- local transcription tool such as `whisper.cpp`: generate rough transcript
- Markdown-capable file writer: produce `BD_SUMMARY.md`

## Enhanced

- OCR or image inspection tool: read skill names, equipment, passive/talent screenshots
- POB link reader or manual POB note extraction
- poe.ninja link reader or manual sample note extraction
- optional poe.ninja public-page search: build a class/main-skill search URL and collect similar character links when public pages expose them

## Not Included

Do not include or require:

- cookies
- tokens
- passwords
- API keys
- poe.ninja private or logged-in data
- paid video access
- private videos
- bundled videos from creators
- large model files unless the toolpack owner chooses to distribute them separately
