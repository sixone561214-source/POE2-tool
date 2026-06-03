# Optional Tool Requirements

This skill can work without the toolpack if the user provides transcript text, screenshots, POB links, or author notes.

Use an optional toolpack only when automatic preparation is needed.

This shared Skill does not include a ready-to-use toolpack.

中文说明：

工具包请自行使用 AI 根据本 Skill 要求生成。

如果需要傻瓜式一键安装包，请联系作者抖音私信。

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
