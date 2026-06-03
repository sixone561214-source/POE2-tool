# POE2 BD Video Analyzer Toolpack Appendix

This appendix is an optional toolpack for the `poe2-bd-video-analyzer` Skill.

It helps prepare raw material from public POE2 BD videos:

- download public videos with `yt-dlp`
- extract audio with `ffmpeg`
- optionally transcribe with local `whisper.cpp`
- optionally extract keyframes for BD screenshots and talent/equipment review

The Skill can still be used without this toolpack if the user provides transcript text, screenshots, POB links, poe.ninja links, or author notes.

## What This Package Includes

- `TOOLPACK_MANIFEST.md`: package contents and boundaries
- `config/toolpack.example.json`: example local path config
- `scripts/check_environment.ps1`: dependency checker
- `scripts/prepare_public_video.ps1`: public-video preparation wrapper

## What This Package Does Not Include

- `yt-dlp`
- `ffmpeg`
- `whisper.cpp`
- speech or transcription model files
- cookies, tokens, passwords, or API keys
- paid, private, members-only, or login-required video access

## Basic Workflow

1. Install or prepare your own local `yt-dlp`, `ffmpeg`, and optional `whisper.cpp`.
2. Run the environment check.
3. Run the public-video preparation script.
4. Give the generated transcript, keyframes, and source notes to the Skill.

## Example

```powershell
Set-ExecutionPolicy -Scope Process Bypass

.\scripts\check_environment.ps1 `
  -YtDlpPath "yt-dlp" `
  -FfmpegPath "ffmpeg" `
  -WhisperCliPath "<path-to-whisper-cli>" `
  -WhisperModelPath "<path-to-whisper-model>"
```

```powershell
.\scripts\prepare_public_video.ps1 `
  -Url "https://www.bilibili.com/video/xxxxx" `
  -OutputDir ".\output\sample-bd" `
  -YtDlpPath "yt-dlp" `
  -FfmpegPath "ffmpeg" `
  -WhisperCliPath "<path-to-whisper-cli>" `
  -WhisperModelPath "<path-to-whisper-model>" `
  -ExtractKeyframes
```

If transcription tools are not available, omit `-WhisperCliPath` and `-WhisperModelPath`. The script will still download video, extract audio, and extract keyframes.

## Safety Boundary

Use this toolpack only for public videos that you are allowed to download and analyze.

Do not provide cookies, login sessions, passwords, tokens, paid-video links, private-video links, or member-only content.
