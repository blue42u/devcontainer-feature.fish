<!--
SPDX-FileCopyrightText: Jonathon Anderson

SPDX-License-Identifier: CC-BY-4.0
-->

# Fish as a Devcontainer feature

This is a small repository to repackage [Fish](https://fishshell.com/)'s standalone binaries as a reusable [Devcontainer](https://containers.dev/) feature.

## Why?

- **No dependencies**. At all. Compatible with every container image under the sun, including the weird ones.
- **No extras**. You get exactly what you asked for and nothing more.
- **No version skew**. The version is where the version should be, not an option added below.

## Usage

```jsonc
// .devcontainer.json
{
  // ...
  "features": {
    "ghcr.io/blue42u/devcontainer-features/fish:latest": {}
  }
}
```

To select a specific version of Fish to install instead of the latest:

```jsonc
// .devcontainer.json
{
  // ...
  "features": {
    "ghcr.io/blue42u/devcontainer-features/fish:4.9.3": {}
  }
}
```

## Configuration

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| `overwrite` | Overwrite any existing `/usr/bin/fish` | boolean | `false` |
| `updateShell` | Also set the remote user's default shell to Fish | boolean | `true` |
