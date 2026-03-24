# dotfiles

Personal Arch Linux configuration managed with [chezmoi](https://chezmoi.io) and [Ansible](https://ansible.com). One command takes a fresh Arch install to a fully configured KDE Plasma desktop with development tools, theming, and all dotfiles in place.

## Features

- **One-command bootstrap** — From base Arch install to complete desktop in a single script
- **Declarative package management** — All packages defined in `ansible/vars/packages.yml`
- **Dotfile sync** — Shell configs, KDE settings, VS Code preferences, GTK themes managed via chezmoi
- **Role-based Ansible playbook** — Modular roles: base, KDE, NVIDIA, dev tools, services
- **NVIDIA support** — Optional NVIDIA driver installation (skippable with `SKIP_NVIDIA=1`)
- **Wallpaper setup** — Automatic wallpaper deployment to `~/Pictures/Wallpapers/`

## Quick Start

After a base Arch install (user created, internet working):

```bash
bash <(curl -fsLS raw.githubusercontent.com/rainyroot/dotfiles/main/bootstrap.sh)
```

On machines without NVIDIA GPUs:

```bash
SKIP_NVIDIA=1 bash <(curl -fsLS raw.githubusercontent.com/rainyroot/dotfiles/main/bootstrap.sh)
```

See [INSTALL.md](INSTALL.md) for prerequisites and manual setup, and [USAGE.md](USAGE.md) for day-to-day workflows.

## What Gets Installed

| Role | Packages |
|------|----------|
| **base** | git, zsh, tmux, neovim, networkmanager, chezmoi, btrfs-progs, refind, ... |
| **kde** | plasma-meta, konsole, dolphin, kate, ark, kcalc, sddm |
| **nvidia** | nvidia-dkms, lib32 drivers, libva-nvidia-driver *(optional)* |
| **dev** | VS Code, Node.js, npm, pnpm, GitHub CLI, Oh My Zsh + plugins |
| **AUR** | yay, google-chrome, obsidian, openrazer-daemon |
| **services** | NetworkManager, sddm, bluetooth, openrazer-daemon |

## Managed Dotfiles

| File | Description |
|------|-------------|
| `~/.zshrc` | Zsh configuration with Oh My Zsh |
| `~/.bashrc` | Bash fallback config |
| `~/.gitconfig` | Git user settings and aliases |
| `~/.config/konsolerc` | Konsole terminal settings |
| `~/.config/kwinrc` | KWin window manager / tiling layout |
| `~/.config/kdeglobals` | KDE global theme and colors |
| `~/.config/kglobalshortcutsrc` | Keyboard shortcuts |
| `~/.config/plasmarc` | Plasma shell settings |
| `~/.config/gtk-3.0/`, `gtk-4.0/` | GTK theme and window decorations |
| `~/.config/Code/User/settings.json` | VS Code settings |
| `~/.config/Code/User/keybindings.json` | VS Code keybindings |

## Project Structure

```
dotfiles/
├── ansible/
│   ├── playbook.yml              # Main Ansible playbook
│   ├── roles/
│   │   ├── base/tasks/main.yml   # Base system packages
│   │   ├── kde/tasks/main.yml    # KDE Plasma desktop
│   │   ├── nvidia/tasks/main.yml # NVIDIA drivers
│   │   ├── dev/tasks/main.yml    # Development tools
│   │   └── services/tasks/main.yml
│   └── vars/packages.yml         # All package lists
├── assets/wallpapers/            # Desktop wallpapers
├── dot_config/                   # chezmoi-managed config files
├── dot_zshrc                     # → ~/.zshrc
├── dot_bashrc                    # → ~/.bashrc
├── dot_gitconfig                 # → ~/.gitconfig
├── dot_gtkrc-2.0                 # → ~/.gtkrc-2.0
├── bootstrap.sh                  # One-command setup script
├── .chezmoi.toml.tmpl            # chezmoi configuration template
└── run_once_setup-wallpapers.sh  # Wallpaper deployment (runs once)
```

## Contributing

This is a personal configuration repository. Feel free to fork it and adapt it to your own setup.
