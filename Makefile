.ONESHELL:
ROOT := $(shell git rev-parse --show-toplevel 2>/dev/null || pwd)
PROJECT_NAME := $(shell cat $(ROOT)/.pages-name 2>/dev/null)
PORT := $(if $(wildcard $(ROOT)/.pages-name),42000,8787)

.PHONY: dev validate build test deploy format check

default: dev

dev:
	cd $(ROOT) && if [ -f .pages-name ]; then if [ -x scripts/dev ]; then scripts/dev; else wrangler pages dev . --port $(PORT) --live-reload; fi; elif [ -f wrangler.toml ]; then wrangler dev --port $(PORT); else echo "ERROR: create .pages-name (Pages) or wrangler.toml (Workers)" >&2; exit 1; fi

validate:
	cd $(ROOT) && if [ -x scripts/validate ]; then scripts/validate; elif [ -f wrangler.toml ]; then wrangler deploy --dry-run; fi

build:
	cd $(ROOT) && if [ -x scripts/build ]; then scripts/build; fi

test:
	cd $(ROOT) && if [ -x scripts/test ]; then scripts/test; fi

format:
	cd $(ROOT) && if [ -f package.json ]; then npm run format; fi

check:
	cd $(ROOT) && if [ -f package.json ]; then npm run format:check; fi

deploy:
	cd $(ROOT) && if [ -f .pages-name ]; then wrangler pages deploy $$([ -d public ] && echo "public" || echo ".") --project-name=$(PROJECT_NAME); elif [ -f wrangler.toml ]; then wrangler deploy; else echo "ERROR: create .pages-name (Pages) or wrangler.toml (Workers)" >&2; exit 1; fi
