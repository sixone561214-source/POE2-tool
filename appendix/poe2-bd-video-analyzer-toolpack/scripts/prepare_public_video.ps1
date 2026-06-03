param(
  [Parameter(Mandatory=$true)][string]$Url,
  [string]$OutputDir = ".\output\bd-video",
  [string]$YtDlpPath = "yt-dlp",
  [string]$FfmpegPath = "ffmpeg",
  [string]$WhisperCliPath = "",
  [string]$WhisperModelPath = "",
  [switch]$ExtractKeyframes,
  [int]$KeyframeIntervalSeconds = 10
)

$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false)

function Resolve-Tool {
  param([Parameter(Mandatory=$true)][string]$PathOrCommand)
  if (Test-Path -LiteralPath $PathOrCommand) {
    return (Resolve-Path -LiteralPath $PathOrCommand).Path
  }
  $cmd = Get-Command $PathOrCommand -ErrorAction SilentlyContinue
  if ($null -eq $cmd) {
    throw "Tool not found: $PathOrCommand"
  }
  return $cmd.Source
}

$yt = Resolve-Tool $YtDlpPath
$ffmpeg = Resolve-Tool $FfmpegPath

$root = (Resolve-Path -LiteralPath (New-Item -ItemType Directory -Path $OutputDir -Force).FullName).Path
$videoDir = Join-Path $root "video"
$audioDir = Join-Path $root "audio"
$transcriptDir = Join-Path $root "transcript"
$keyframeDir = Join-Path $root "keyframes"
New-Item -ItemType Directory -Path $videoDir,$audioDir,$transcriptDir,$keyframeDir -Force | Out-Null

$manifest = Join-Path $root "SOURCE_MANIFEST.md"
$startedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Set-Content -Encoding UTF8 -LiteralPath $manifest -Value @"
# Source Manifest

Started at: $startedAt

URL: $Url

Safety: public-video preparation only. No cookies, tokens, passwords, API keys, paid-video access, private-video access, or platform login.

"@

Write-Output "Downloading public video..."
& $yt --no-playlist -o (Join-Path $videoDir "%(title).120B [%(id)s].%(ext)s") $Url
if ($LASTEXITCODE -ne 0) {
  throw "yt-dlp failed with exit code $LASTEXITCODE"
}

$video = Get-ChildItem -LiteralPath $videoDir -File | Sort-Object LastWriteTime -Descending | Select-Object -First 1
if ($null -eq $video) {
  throw "No downloaded video found."
}

Add-Content -Encoding UTF8 -LiteralPath $manifest -Value "Video: $($video.FullName)"

$audio = Join-Path $audioDir "audio.wav"
Write-Output "Extracting audio..."
& $ffmpeg -y -i $video.FullName -vn -ac 1 -ar 16000 $audio
if ($LASTEXITCODE -ne 0) {
  throw "ffmpeg audio extraction failed with exit code $LASTEXITCODE"
}
Add-Content -Encoding UTF8 -LiteralPath $manifest -Value "Audio: $audio"

if ($ExtractKeyframes) {
  Write-Output "Extracting keyframes..."
  $pattern = Join-Path $keyframeDir "frame_%05d.jpg"
  & $ffmpeg -y -i $video.FullName -vf ("fps=1/{0}" -f $KeyframeIntervalSeconds) -q:v 3 $pattern
  if ($LASTEXITCODE -ne 0) {
    throw "ffmpeg keyframe extraction failed with exit code $LASTEXITCODE"
  }
  Add-Content -Encoding UTF8 -LiteralPath $manifest -Value "Keyframes: $keyframeDir"
}

if ($WhisperCliPath -and $WhisperModelPath) {
  $whisper = Resolve-Tool $WhisperCliPath
  if (-not (Test-Path -LiteralPath $WhisperModelPath)) {
    throw "Whisper model not found: $WhisperModelPath"
  }

  Write-Output "Transcribing with whisper.cpp..."
  $outPrefix = Join-Path $transcriptDir "transcript"
  & $whisper -m $WhisperModelPath -f $audio -otxt -osrt -of $outPrefix
  if ($LASTEXITCODE -ne 0) {
    throw "whisper.cpp transcription failed with exit code $LASTEXITCODE"
  }
  Add-Content -Encoding UTF8 -LiteralPath $manifest -Value "Transcript: $transcriptDir"
} else {
  Add-Content -Encoding UTF8 -LiteralPath $manifest -Value "Transcript: not generated; whisper.cpp path/model not provided."
}

$finishedAt = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
Add-Content -Encoding UTF8 -LiteralPath $manifest -Value "Finished at: $finishedAt"

Write-Output ""
Write-Output "Done."
Write-Output "Output: $root"
Write-Output "Manifest: $manifest"
