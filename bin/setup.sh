#!/bin/sh

logger() {
    printf "[SETUP] %s\n" "$1"
}

error=""

ping -c 1 -W 1 google.com > /dev/null || error="internet connection is missing"
grep -qi "arch linux" /etc/os-release || error="linux distro must be arch"

[ -z "$error" ] || { logger "$error"; exit 1; }

sudo pacman -S --noconfirm --needed git

echo "" 
read -r dotfiles_repo

if [ -d "$HOME"/.dotfiles ]; then
    cd "$HOME"/.dotfiles || exit
    git pull origin main
    cd || exit
else
    git clone "$dotfiles_repo" "$HOME"/.dotfiles 2> /dev/null
fi

sudo pacman -S --noconfirm --needed - < "$HOME"/.dotfiles/pacman.txt

cd "$HOME"/.dotfiles && stow -v --target="$HOME" -- */

[ "$SHELL" = /usr/bin/zsh ] || sudo chsh --shell /usr/bin/zsh "$USER"

[ "$(readlink /bin/sh)" = dash ] || sudo ln -sf dash /bin/sh

sudo systemctl enable --now ufw.service && sudo ufw enable

sudo systemctl enable --now docker.service

sudo usermod -aG docker "$USER"

rm -f "$HOME"/.bash*

cd || exit

nvim --headless +qa

rustup install stable

sudo killall -u "$USER"
