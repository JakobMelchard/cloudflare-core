# cloudflare-core

Shared Cloudflare infra for Pages + Workers projects.

## Use

```sh
# In any Pages or Workers project:
curl -sL https://raw.githubusercontent.com/JakobMelchard/cloudflare-core/main/install.sh | bash
```

Adds `.core` submodule, sets hooks path, seeds config files.

```sh
# Pull latest:
curl -sL https://raw.githubusercontent.com/JakobMelchard/cloudflare-core/main/update.sh | bash
```

See [pages-template](https://github.com/JakobMelchard/pages-template) or [workers-template](https://github.com/JakobMelchard/workers-template).
