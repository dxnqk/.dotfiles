#!/usr/bin/zsh

HISTFILE="$XDG_CACHE_HOME"/zsh-history
HISTSIZE=10000
SAVEHIST=10000

setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt share_history

[ -f "$XDG_CONFIG_HOME"/shell/alias.sh ] && source "$XDG_CONFIG_HOME"/shell/alias.sh

zstyle :compinstall filename "$ZDOTDIR"/.zshrc
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME"/zsh-comp
zmodload zsh/complist
_comp_options+=(globdots)
zstyle ":completion:*" menu select

bindkey -v
bindkey -M menuselect "h" vi-backward-char
bindkey -M menuselect "j" vi-down-line-or-history
bindkey -M menuselect "k" vi-up-line-or-history
bindkey -M menuselect "l" vi-forward-char
bindkey "^?" backward-delete-char

autoload -Uz vcs_info
autoload -U colors && colors

zstyle ":vcs_info:*" enable git
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info)
setopt prompt_subst
zstyle ":vcs_info:git*+set-message:*" hooks git-untracked

+vi-git-untracked() {
    if  [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == true ]] && git status --porcelain | grep "??" &> /dev/null; then
        hook_com[staged]+="!"
    fi
}

zstyle ":vcs_info:*" check-for-changes true
zstyle ":vcs_info:git:*" formats " %{$fg[blue]%}(%{$fg[red]%}%m%u%c%{$fg[yellow]%}%{$fg[magenta]%} %b%{$fg[blue]%})%{$reset_color%}"

PROMPT="%{$fg[cyan]%}%c %(?:%{$fg[green]%}:%{$fg[red]%})%{$reset_color%}"
PROMPT+="\$vcs_info_msg_0_ "

# source <(fzf --zsh)

load_plugin() {
    command -v git > /dev/null || return

    plugins_dir="$XDG_DATA_HOME"/zsh/plugins
    plugin="$(printf "$1" | cut -d "/" -f 2)"

    [ -d "$plugins_dir"/"$plugin" ] || git clone --depth 1 "https://github.com/$1.git" "$plugins_dir"/"$plugin"

    source "$plugins_dir"/"$plugin"/"$plugin".plugin.zsh || source "$plugins_dir"/"$plugin"/"$plugin".zsh
}

load_plugin "zsh-users/zsh-syntax-highlighting"
load_plugin "zsh-users/zsh-autosuggestions"

unset -f load_plugin
