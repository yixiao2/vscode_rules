# Codex Customizations

Shared Codex skills and agent guidance for WSL and Remote-SSH environments.

## Install On A Machine

On each WSL distro and each Remote-SSH server account, clone the parent repo under
`$HOME`:

```bash
git clone git@github.com:YOURNAME/set_clinerules ~/set_clinerules
```

Then run the Codex link installer:

```bash
~/set_clinerules/codex-customizations/agents/install/setup-codex-links.sh
```

To preview changes first:

```bash
~/set_clinerules/codex-customizations/agents/install/setup-codex-links.sh --dry-run
```

## What The Installer Links

The installer creates these symlinks in the local Codex home:

```text
~/.codex/AGENTS.md
~/.codex/skills/grill-me
~/.codex/skills/karpathy-guidelines
```

It links every skill directory under `skills/` that contains a `SKILL.md`.

## Verify

```bash
ls -l ~/.codex/AGENTS.md
ls -l ~/.codex/skills/grill-me/SKILL.md
ls -l ~/.codex/skills/karpathy-guidelines/SKILL.md
```

Re-running the installer is safe. Existing correct links are left unchanged; real
files or directories at target paths are moved to timestamped backups before a
link is created.
