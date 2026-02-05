# Skill: Generate Content

## Purpose

Orchestrates multimodal content generation (text, images, video) for social media publishing.

## Input Contract

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "GenerateContentInput",
  "type": "object",
  "required": ["content_type", "prompt"],
  "properties": {
    "content_type": {
      "type": "string",
      "enum": ["text", "image", "video", "carousel"]
    },
    "prompt": {
      "type": "string",
      "description": "Generation prompt/instructions"
    },
    "persona_id": {
      "type": "string",
      "description": "Agent persona for style consistency"
    },
    "platform": {
      "type": "string",
      "enum": ["twitter", "instagram", "threads", "tiktok"]
    },
    "constraints": {
      "type": "object",
      "properties": {
        "max_length": {"type": "integer"},
        "aspect_ratio": {"type": "string"},
        "style": {"type": "string"}
      }
    }
  }
}
```

## Output Contract

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "title": "GenerateContentOutput",
  "type": "object",
  "required": ["success", "content"],
  "properties": {
    "success": {"type": "boolean"},
    "content": {
      "type": "object",
      "properties": {
        "text": {"type": "string"},
        "media_urls": {"type": "array", "items": {"type": "string"}},
        "hashtags": {"type": "array", "items": {"type": "string"}}
      }
    },
    "confidence_score": {"type": "number", "minimum": 0, "maximum": 1},
    "generation_cost_usd": {"type": "number"}
  }
}
```

## Error Contract

```json
{
  "success": false,
  "error_code": "GENERATION_FAILED | CONTENT_POLICY_VIOLATION | BUDGET_EXCEEDED",
  "error_message": "Human-readable description"
}
```

## Dependencies

- LLM API (Claude/Gemini) for text
- Ideogram/Midjourney for images
- Runway/Luma for video
