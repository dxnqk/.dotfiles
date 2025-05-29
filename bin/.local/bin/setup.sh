#!/bin/sh

PING_DESTINATION="google.com"
USER_INPUT_FILE="/tmp/setup-user-input.txt"

BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
RESET=$(tput sgr0)

logger() {
    printf "${GREEN}[SETUP]${RESET} %s.\n" "$1"
}

error_logger() {
    printf "${RED}[SETUP]${RESET} %s.\n" "$1"
}

panic() {
    printf "${RED}[SETUP]${RESET} %s.\n" "$1"
    exit 1
}

check_connection() {
    (ping -c 1 -W 1 "$PING_DESTINATION" > /dev/null \
        && logger "Internet connection online") \
        || panic "Unable to establish an internet connection"
}

check_distribution() {
    (grep -qi "arch linux" /etc/os-release \
        && logger "Arch is the correct Linux distribution") \
        || panic "The required Linux distribution is Arch"
}

get_user_input() {
    while true; do
        input_print "$1"
        read -r user_input

        if [ -z "$user_input" ]; then
            error_logger "Input cannot be empty"
            continue
        fi

        break
    done

    printf "%s" "$user_input" > "$USER_INPUT_FILE"
}

sudo pacman -S --noconfirm --needed git

setup_dotfiles() {
    get_user_input "Enter dotfiles repo URL"
    dotfiles_repo="$(cat "$USER_INPUT_FILE")"

    if [ -d "$HOME/.dotfiles" ]; then
        cd "$HOME/.dotfiles" || exit
        git pull origin main
        cd || exit
    else
        git clone "$dotfiles_repo" "$HOME/.dotfiles" 2> /dev/null
    fi

    sudo pacman -S --noconfirm --needed - < "$HOME/.dotfiles/pacman.txt"

    cd "$HOME/.dotfiles" && stow -v --target="$HOME" -- */
}

set_user_shell() {
    # TODO: check if zsh is installed
    [ "$SHELL" = /usr/bin/zsh ] || sudo chsh --shell /usr/bin/zsh "$USER"
}

set_default_shell() {
    # TODO: check if dash is installed
    [ "$(readlink /bin/sh)" = dash ] || sudo ln -sf dash /bin/sh
}

setup_ufw() {
    sudo systemctl enable --now ufw.service
    sudo ufw enable
}

setup_docker() {
    sudo systemctl enable --now docker.service
    sudo usermod -aG docker "$USER"
}

delete_bash_files() {
    rm -f "$HOME"/.bash*
}

cd || exit

init_neovim() {
    nvim --headless +qa
}

init_rust() {
    rustup install stable
}

log_out() {
    sudo killall -u "$USER"
}

create_default_dirs() {
    [ -d "$HOME/.config" ] || mkdir "$HOME/.config"
    [ -d "$HOME/.local/share" ] || mkdir -p "$HOME/.local/share"
}
