# Project Chimera - Docker Configuration
# Multi-stage build for production efficiency

FROM python:3.11-slim as base

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# --- Development Stage ---
FROM base as development

# Install all dependencies including dev
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy application code
COPY . .

# Default command for development
CMD ["pytest", "tests/", "-v"]

# --- Production Stage ---
FROM base as production

# Install only production dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy application code
COPY src/ ./src/
COPY skills/ ./skills/
COPY specs/ ./specs/

# Create non-root user
RUN useradd --create-home appuser && chown -R appuser:appuser /app
USER appuser

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000/health || exit 1

# Default command for production
CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8000"]
