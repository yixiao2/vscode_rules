- On each WSL distro and each Remote-SSH server account, clone it somewhere under $HOME, for example:
git clone git@github.com:YOURNAME/codex-customizations.git ~/.codex-customizations

- Symlink each shared skill into the local Codex skill directory:
mkdir -p ~/.codex/skills
ln -s ~/.codex-customizations/skills/grill-me ~/.codex/skills/grill-me
