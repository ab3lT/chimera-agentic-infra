# Agent Runtime Skills

## Overview

Skills are reusable capability packages that Chimera agents invoke at runtime. Each skill has a well-defined input/output contract.

## Skill Structure

```
skills/
├── skill_<name>/
│   ├── README.md      # Contract definition (required)
│   ├── __init__.py    # Implementation (TDD - starts empty)
│   └── tests/         # Skill-specific tests
```

## Contract Template

Every skill README must define:

1. **Purpose**: What the skill does
2. **Input Schema**: JSON schema for parameters
3. **Output Schema**: JSON schema for return value
4. **Error Schema**: Standardized error format
5. **Dependencies**: External services required

## Available Skills

| Skill | Status | Priority |
|-------|--------|----------|
| `skill_download_video` | Contract defined | P0 |
| `skill_transcribe_audio` | Contract defined | P0 |
| `skill_generate_content` | Contract defined | P0 |

## Usage Pattern

```python
from skills import skill_download_video

result = await skill_download_video.execute({
    "url": "https://youtube.com/watch?v=...",
    "output_format": "mp4",
    "max_duration_seconds": 300
})
```
