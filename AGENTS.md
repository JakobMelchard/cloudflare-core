# cloudflare-core — shared CF infra (Pages + Workers)

```sh
curl -sL https://raw.githubusercontent.com/JakobMelchard/cloudflare-core/main/install.sh | bash
```

Seeds hooks, configs, and release-please workflow. Idempotent — safe to re-run.

## Hooks

- **pre-commit**: gitleaks → prettier (staged .css/.html/.js) → make validate → make build → make test
- **post-checkout**: auto-updates `.core` submodule on `git pull` / `git checkout`
- **pre-push**: make deploy
