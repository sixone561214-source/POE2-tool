param(
  [string]$YtDlpPath = "yt-dlp",
  [string]$FfmpegPath = "ffmpeg",
  [string]$WhisperCliPath = "",
  [string]$WhisperModelPath = ""
)

$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false)

function Test-CommandOrFile {
  param(
    [Parameter(Mandatory=$true)][string]$PathOrCommand
  )

  if ([string]::IsNullOrWhiteSpace($PathOrCommand)) {
    return $false
  }

  if (Test-Path -LiteralPath $PathOrCommand) {
    return $true
  }

  $cmd = Get-Command $PathOrCommand -ErrorAction SilentlyContinue
  return $null -ne $cmd
}

function Write-Check {
  param(
    [string]$Name,
    [bool]$Ok,
    [string]$Detail
  )

  $status = if ($Ok) { "OK" } else { "MISSING" }
  Write-Output ("[{0}] {1}: {2}" -f $status, $Name, $Detail)
}

$ytOk = Test-CommandOrFile $YtDlpPath
$ffmpegOk = Test-CommandOrFile $FfmpegPath
$whisperOk = if ($WhisperCliPath) { Test-CommandOrFile $WhisperCliPath } else { $false }
$modelOk = if ($WhisperModelPath) { Test-Path -LiteralPath $WhisperModelPath } else { $false }

Write-Check "yt-dlp" $ytOk $YtDlpPath
Write-Check "ffmpeg" $ffmpegOk $FfmpegPath

if ($WhisperCliPath) {
  Write-Check "whisper.cpp cli" $whisperOk $WhisperCliPath
} else {
  Write-Output "[OPTIONAL] whisper.cpp cli: not configured"
}

if ($WhisperModelPath) {
  Write-Check "whisper model" $modelOk $WhisperModelPath
} else {
  Write-Output "[OPTIONAL] whisper model: not configured"
}

if (-not $ytOk -or -not $ffmpegOk) {
  Write-Output ""
  Write-Output "Required tools are missing. Configure yt-dlp and ffmpeg before running video preparation."
  exit 1
}

Write-Output ""
Write-Output "Environment check complete."
