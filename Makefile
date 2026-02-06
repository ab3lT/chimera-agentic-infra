# Project Chimera - Makefile
# Standardized commands for development workflow

.PHONY: setup test lint docker-build docker-test spec-check clean help

# Default target
help:
	@echo "Project Chimera - Available Commands"
	@echo "====================================="
	@echo "make setup       - Install dependencies"
	@echo "make test        - Run test suite"
	@echo "make lint        - Run linters (ruff, mypy)"
	@echo "make docker-build - Build Docker image"
	@echo "make docker-test  - Run tests in Docker"
	@echo "make spec-check   - Validate specs alignment"
	@echo "make clean       - Remove build artifacts"

# Setup development environment
setup:
	pip install -e ".[dev]"
	pre-commit install

# Run tests
test:
	pytest tests/ -v --tb=short

# Run tests with coverage
test-cov:
	pytest tests/ -v --cov=src --cov-report=html --cov-report=term

# Lint code
lint:
	ruff check src/ tests/ skills/
	mypy src/ --ignore-missing-imports

# Format code
format:
	ruff format src/ tests/ skills/

# Build Docker image
docker-build:
	docker build -t chimera-agent:latest --target development .

# Run tests in Docker
docker-test:
	docker run --rm chimera-agent:latest pytest tests/ -v

# Validate specs (placeholder - implement spec checker)
spec-check:
	@echo "Checking spec alignment..."
	@echo "TODO: Implement spec validation script"
	@python -c "import json; print('Specs directory exists')" && ls specs/*.md

# Clean build artifacts
clean:
	rm -rf __pycache__ .pytest_cache .mypy_cache .ruff_cache
	rm -rf htmlcov .coverage
	rm -rf dist build *.egg-info
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
