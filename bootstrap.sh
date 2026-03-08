#!/usr/bin/env bash
# rainyroot's Arch Linux setup bootstrap
# Run this AFTER a base Arch install (pacstrap, locale, user setup, etc.):
#
#   bash <(curl -fsLS raw.githubusercontent.com/rainyroot/dotfiles/main/bootstrap.sh)
#
# Skip NVIDIA drivers on non-NVIDIA machines:
#   SKIP_NVIDIA=1 bash <(curl -fsLS ...)

set -euo pipefail

DOTFILES_REPO="https://github.com/rainyroot/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

echo "==> Installing prerequisites (ansible, git)..."
sudo pacman -Sy --noconfirm ansible git ansible-core

echo "==> Installing community.general Ansible collection..."
ansible-galaxy collection install community.general

echo "==> Cloning dotfiles repo..."
if [ -d "$DOTFILES_DIR/.git" ]; then
  echo "    Repo already exists, pulling latest..."
  git -C "$DOTFILES_DIR" pull
else
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
fi

echo "==> Running Ansible playbook..."
ANSIBLE_FLAGS="--ask-become-pass"
if [ "${SKIP_NVIDIA:-0}" = "1" ]; then
  ANSIBLE_FLAGS="$ANSIBLE_FLAGS --skip-tags nvidia"
fi

ansible-playbook "$DOTFILES_DIR/ansible/playbook.yml" $ANSIBLE_FLAGS

echo "==> Applying dotfiles via chezmoi..."
export PATH="$HOME/.local/bin:$PATH"
chezmoi init --apply rainyroot/dotfiles

echo ""
echo "Setup complete! Please reboot to start KDE."
echo ""
echo "Next steps:"
echo "  1. Reboot: sudo reboot"
echo "  2. Future config changes: chezmoi add <file> && chezmoi cd && git push"
