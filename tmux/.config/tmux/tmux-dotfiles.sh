#!/bin/sh

selected="$(find "$HOME"/.dotfiles -type f ! -path "*.git/*" | sort | fzf --preview "bat -n --color always {}")"
[ -z "$selected" ] && exit 0
path="$selected"
name="$(echo "${selected#/*/*/}" | tr "/." "_")"
if tmux lsw | grep -q ": $name"; then
    tmux selectw -t "$name"
else
    tmux neww -n "$name" -c sh "nvim $path"
fi
