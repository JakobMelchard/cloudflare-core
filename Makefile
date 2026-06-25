.ONESHELL:
MAKEFLAGS += --silent
PORT := $(if $(wildcard .pages-name),42000,8787)

.PHONY: dev validate build test deploy format check

default: dev

dev:
	if [ -f .pages-name ]; then \
		if [ -x scripts/dev ]; then exec scripts/dev; fi; \
		wrangler pages dev . --port $(PORT) --live-reload; \
	elif [ -f wrangler.toml ]; then \
		wrangler dev --port $(PORT); \
	else \
		echo "ERROR: create .pages-name (Pages) or wrangler.toml (Workers)" >&2; \
		exit 1; \
	fi

validate:
	if [ -x scripts/validate ]; then \
		scripts/validate; \
	elif [ -f wrangler.toml ]; then \
		wrangler deploy --dry-run; \
	fi

build:
	if [ -x scripts/build ]; then scripts/build; fi

test:
	if [ -x scripts/test ]; then scripts/test; fi

format:
	[ -f package.json ] && npm run format

check:
	[ -f package.json ] && npm run format:check

deploy:
	if [ -f .pages-name ]; then \
		PROJECT_NAME=$$(cat .pages-name); \
		wrangler pages deploy $$([ -d public ] && echo "public" || echo ".") --project-name=$$PROJECT_NAME; \
	elif [ -f wrangler.toml ]; then \
		wrangler deploy; \
	else \
		echo "ERROR: create .pages-name (Pages) or wrangler.toml (Workers)" >&2; \
		exit 1; \
	fi
