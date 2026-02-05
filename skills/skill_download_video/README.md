# Skill: Download Video

## Purpose

Downloads video content from supported platforms (YouTube, TikTok, Instagram) for analysis and content repurposing.

## Input Contract

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "DownloadVideoInput",
  "type": "object",
  "required": ["url"],
  "properties": {
    "url": {
      "type": "string",
      "format": "uri",
      "description": "URL of the video to download"
    },
    "output_format": {
      "type": "string",
      "enum": ["mp4", "webm", "mp3"],
      "default": "mp4"
    },
    "max_duration_seconds": {
      "type": "integer",
      "default": 300,
      "maximum": 600
    },
    "extract_audio_only": {
      "type": "boolean",
      "default": false
    }
  }
}
```

## Output Contract

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "DownloadVideoOutput",
  "type": "object",
  "required": ["success", "file_path", "duration_seconds"],
  "properties": {
    "success": {"type": "boolean"},
    "file_path": {"type": "string"},
    "duration_seconds": {"type": "number"},
    "file_size_bytes": {"type": "integer"},
    "metadata": {
      "type": "object",
      "properties": {
        "title": {"type": "string"},
        "author": {"type": "string"},
        "upload_date": {"type": "string", "format": "date"}
      }
    }
  }
}
```

## Error Contract

```json
{
  "success": false,
  "error_code": "DOWNLOAD_FAILED | DURATION_EXCEEDED | INVALID_URL | UNSUPPORTED_PLATFORM",
  "error_message": "Human-readable description"
}
```

## Dependencies

- `yt-dlp` for video downloading
- `ffmpeg` for format conversion

## Supported Platforms

- YouTube
- TikTok
- Instagram Reels
- Twitter/X Videos
