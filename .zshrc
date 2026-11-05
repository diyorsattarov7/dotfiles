autoload -U colors && colors
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats ' on %F{#A5D6FF}%b%f'

setopt PROMPT_SUBST

PROMPT='%F{#7EE787}%n%f at %F{#D2A8FF}%m%f in %F{#79C0FF}%~%f${vcs_info_msg_0_}
%(?.%F{#7EE787}>%f.%F{#FF7B72}>%f) '

alias ls='ls -G'
alias ll='ls -la'

export GPG_TTY=$(tty)
export CPATH="$(brew --prefix)/include:$CPATH"
export LIBRARY_PATH="$(brew --prefix)/lib:$LIBRARY_PATH"

bindkey -v

function zle-line-init { zle vi-cmd-mode }

zle -N zle-line-init

bindkey '^?' backward-delete-char
export KEYTIMEOUT=1

neofetch

# Docker CLI completions
fpath=("$HOME/.docker/completions" $fpath)
autoload -Uz compinit
(( ${+_comps[docker]} )) || compinit
