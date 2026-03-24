# Usage

## Day-to-Day Dotfile Sync

### After changing a config file

When you modify a config on your machine (e.g., Konsole settings, VS Code config), add it to chezmoi and push:

```bash
chezmoi add ~/.config/konsolerc
chezmoi cd
git add -A && git commit -m "update konsole config"
git push
```

### Pull changes on another machine

```bash
chezmoi update
```

### Check what would change before applying

```bash
chezmoi diff
```

### Edit a managed file through chezmoi

```bash
chezmoi edit ~/.zshrc
chezmoi apply
```

## Managing Packages

### Add a new package

1. Edit `ansible/vars/packages.yml` and add the package to the appropriate list:
   - `pacman_base` — System essentials
   - `pacman_kde` — KDE desktop packages
   - `pacman_nvidia` — NVIDIA drivers
   - `pacman_dev` — Development tools
   - `aur_packages` — AUR packages (installed via yay)
   - `systemd_services` — Services to enable

2. Re-run the playbook:
   ```bash
   ansible-playbook ~/dotfiles/ansible/playbook.yml --ask-become-pass
   ```

### Remove a package

Remove it from `packages.yml` and uninstall manually:

```bash
sudo pacman -Rns <package-name>
```

Then re-run the playbook to keep state consistent.

## Adding New Dotfiles to chezmoi

### Regular files

```bash
chezmoi add ~/.config/some-app/config.toml
```

### Template files

For files that need machine-specific values (e.g., hostname, paths):

```bash
chezmoi add --template ~/.config/some-app/config.toml
```

Then edit the template to use Go template variables:

```bash
chezmoi edit ~/.config/some-app/config.toml
```

Available template variables are defined in `.chezmoi.toml.tmpl`.

### Private files

Files with restricted permissions (mode 0600) are automatically prefixed with `private_` by chezmoi.

## Re-Running the Full Setup

To re-provision the entire system (e.g., after a fresh install or to ensure everything is in sync):

```bash
cd ~/dotfiles
ansible-playbook ansible/playbook.yml --ask-become-pass
chezmoi apply
```

## Chezmoi Configuration

The chezmoi config template (`.chezmoi.toml.tmpl`) defines:

- **Source directory** — Where chezmoi reads managed files from
- **User data** — Name and email used in templates
- **Git settings** — Auto-commit and auto-push are disabled by default
- **Encryption** — Commented out; uncomment and configure `age` for secret file encryption

## Troubleshooting

### chezmoi apply fails with permission errors

Some KDE config files require specific ownership. Run:

```bash
chezmoi apply --force
```

If that doesn't help, check file ownership:

```bash
ls -la ~/.config/kdeglobals
```

### Ansible playbook fails on AUR packages

AUR packages are installed via `yay`. If yay itself isn't installed yet, the base role installs it first. If it still fails, install yay manually:

```bash
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay && makepkg -si
```

Then re-run the playbook.

### SDDM doesn't start after reboot

Ensure the service is enabled:

```bash
sudo systemctl enable sddm
sudo systemctl start sddm
```
