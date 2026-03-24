# Installation

## Prerequisites

- A working **Arch Linux** base install (pacstrap, locale, user account, and internet connectivity)
- An active internet connection
- A non-root user with `sudo` access

## Automated Setup (Recommended)

The bootstrap script handles everything — installing Ansible, cloning the repo, running the playbook, and applying dotfiles:

```bash
bash <(curl -fsLS raw.githubusercontent.com/rainyroot/dotfiles/main/bootstrap.sh)
```

You will be prompted for your sudo password during the Ansible playbook run.

### Skip NVIDIA Drivers

On machines without NVIDIA GPUs:

```bash
SKIP_NVIDIA=1 bash <(curl -fsLS raw.githubusercontent.com/rainyroot/dotfiles/main/bootstrap.sh)
```

### What the bootstrap script does

1. Installs `ansible`, `git`, and `ansible-core` via pacman
2. Installs the `community.general` Ansible collection
3. Clones this repo to `~/dotfiles`
4. Runs the Ansible playbook (installs all packages, enables services)
5. Runs `chezmoi init --apply` to deploy all dotfiles

After completion, reboot to start KDE Plasma via SDDM.

## Manual Setup

If you prefer to run steps individually:

### 1. Install prerequisites

```bash
sudo pacman -Sy ansible git ansible-core
ansible-galaxy collection install community.general
```

### 2. Clone the repository

```bash
git clone https://github.com/rainyroot/dotfiles.git ~/dotfiles
```

### 3. Run the Ansible playbook

```bash
ansible-playbook ~/dotfiles/ansible/playbook.yml --ask-become-pass
```

To skip NVIDIA drivers:

```bash
ansible-playbook ~/dotfiles/ansible/playbook.yml --ask-become-pass --skip-tags nvidia
```

### 4. Apply dotfiles with chezmoi

```bash
chezmoi init --apply rainyroot/dotfiles
```

### 5. Reboot

```bash
sudo reboot
```

## AMD Systems

Edit `ansible/vars/packages.yml` and replace `intel-ucode` with `amd-ucode` before running the playbook.

## Post-Install Steps

1. **SSH keys** — Generate or copy your SSH keys:
   ```bash
   ssh-keygen -t ed25519
   ```

2. **GitHub CLI** — Authenticate:
   ```bash
   gh auth login
   ```

3. **Wallpapers** — Deployed automatically to `~/Pictures/Wallpapers/` by the `run_once_setup-wallpapers.sh` script on first chezmoi apply.
