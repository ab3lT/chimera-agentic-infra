# Skill: Transcribe Audio

## Purpose

Converts audio/video content to text using speech-to-text models for content analysis and repurposing.

## Input Contract

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "TranscribeAudioInput",
  "type": "object",
  "required": ["file_path"],
  "properties": {
    "file_path": {
      "type": "string",
      "description": "Path to audio/video file"
    },
    "language": {
      "type": "string",
      "default": "auto",
      "description": "Language code or 'auto' for detection"
    },
    "include_timestamps": {
      "type": "boolean",
      "default": false
    },
    "model": {
      "type": "string",
      "enum": ["whisper-small", "whisper-medium", "whisper-large"],
      "default": "whisper-medium"
    }
  }
}
```

## Output Contract

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "TranscribeAudioOutput",
  "type": "object",
  "required": ["success", "text"],
  "properties": {
    "success": {"type": "boolean"},
    "text": {"type": "string"},
    "language_detected": {"type": "string"},
    "confidence": {"type": "number", "minimum": 0, "maximum": 1},
    "duration_seconds": {"type": "number"},
    "segments": {
      "type": "array",
      "items": {
        "type": "object",
        "properties": {
          "start": {"type": "number"},
          "end": {"type": "number"},
          "text": {"type": "string"}
        }
      }
    }
  }
}
```

## Error Contract

```json
{
  "success": false,
  "error_code": "FILE_NOT_FOUND | UNSUPPORTED_FORMAT | TRANSCRIPTION_FAILED",
  "error_message": "Human-readable description"
}
```

## Dependencies

- OpenAI Whisper API or local Whisper model
- `ffmpeg` for audio extraction
