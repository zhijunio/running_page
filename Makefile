PYTHON ?= python3
VENV := .venv
VENV_PYTHON := $(VENV)/bin/python

.PHONY: help setup tui test lint check format build ci

help:
	@echo "Available targets:"
	@echo "  make setup   - Create a Python venv and install dependencies"
	@echo "  make tui     - Run the Textual TUI"
	@echo "  make test    - Run Python tests"
	@echo "  make lint    - Run frontend lint"
	@echo "  make check   - Run frontend format check"
	@echo "  make format  - Format frontend files"
	@echo "  make build   - Build frontend assets"
	@echo "  make ci      - Run test, lint, check, and build"

setup:
	$(PYTHON) -m venv $(VENV)
	$(VENV_PYTHON) -m pip install --upgrade pip
	$(VENV_PYTHON) -m pip install -e . -r requirements-dev.txt

tui:
	$(VENV)/bin/run_page

test:
	$(VENV_PYTHON) -m unittest discover -s . -p 'test_*.py'

lint:
	pnpm run lint

check:
	pnpm run check

format:
	pnpm run format

build:
	pnpm run build

ci: test lint check build
