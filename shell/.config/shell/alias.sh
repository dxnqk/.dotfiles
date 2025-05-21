#!/bin/sh

alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ip="ip --color=auto"

alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"

alias ls="eza --icons --group-directories-first"
alias la="eza -a --icons --group-directories-first -a"
alias ll="eza -alghF --icons --group-directories-first"
alias lt="eza -alghF --icons --group-directories-first --tree"

alias t="tmux a 2> /dev/null || tmux new-session -s $USER -c $HOME"
alias v="nvim"
alias g="git"
