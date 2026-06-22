# cloudflare-core — shared CF infra (Pages + Workers)

Install: `curl -sL https://raw.githubusercontent.com/JakobMelchard/cloudflare-core/main/install.sh | bash`
Update:  `curl -sL https://raw.githubusercontent.com/JakobMelchard/cloudflare-core/main/update.sh | bash`

Seeds hooks, configs, and release-please workflow.
Consumer provides its own Makefile (from pages-template or workers-template).

## Hooks

- **pre-commit**: gitleaks → make validate → make build → make test
- **pre-push**: make deploy
