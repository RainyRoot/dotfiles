# rainyroot's dotfiles

Arch Linux setup managed with [chezmoi](https://chezmoi.io) + [Ansible](https://ansible.com).

## Fresh Arch install → full setup in one command

After a base Arch install (user created, internet working):

```bash
bash <(curl -fsLS raw.githubusercontent.com/rainyroot/dotfiles/main/bootstrap.sh)
```

On non-NVIDIA machines:

```bash
SKIP_NVIDIA=1 bash <(curl -fsLS raw.githubusercontent.com/rainyroot/dotfiles/main/bootstrap.sh)
```

## What gets installed

| Role | Packages |
|------|----------|
| base | git, zsh, tmux, neovim, networkmanager, chezmoi, ... |
| kde | plasma-meta, konsole, dolphin, kate, ark, sddm |
| nvidia | nvidia-dkms, lib32 drivers |
| dev | VS Code, nodejs, npm, pnpm, Oh My Zsh + plugins |
| services | NetworkManager, sddm, bluetooth |

## What chezmoi manages (dotfiles)

- `~/.zshrc`, `~/.bashrc`, `~/.gitconfig`
- `~/.config/konsolerc` — Konsole terminal settings
- `~/.config/kwinrc` — KWin tiling layout
- `~/.config/kdeglobals` — KDE global theme/colors
- `~/.config/kglobalshortcutsrc` — keyboard shortcuts
- `~/.config/plasmarc` — Plasma shell settings
- `~/.config/gtk-3.0/`, `~/.config/gtk-4.0/` — GTK theme
- `~/.config/Code/User/settings.json` — VS Code settings
- `~/.config/Code/User/keybindings.json` — VS Code keybindings

## Day-to-day sync workflow

```bash
# After changing a config (e.g. Konsole settings):
chezmoi add ~/.config/konsolerc
chezmoi cd
git add -A && git commit -m "update konsole config"
git push

# Pull changes on another machine:
chezmoi update
```

## Editing package lists

Open `ansible/vars/packages.yml` to add/remove packages, then re-run:

```bash
ansible-playbook ~/dotfiles/ansible/playbook.yml --ask-become-pass
```

## Secrets (SSH keys, tokens)

SSH keys are NOT stored in this repo. After bootstrap, copy your keys manually
or generate new ones:

```bash
ssh-keygen -t ed25519 -C "C.Wiege92@live.de"
gh auth login
```

To add secret files with encryption in the future, install `age` and uncomment
the `[encryption]` section in `.chezmoi.toml.tmpl`.
