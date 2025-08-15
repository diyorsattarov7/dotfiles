if [ -n "$ZSH_VERSION" ]; then
    autoload -U colors && colors
    autoload -Uz vcs_info
    precmd() { vcs_info }

    zstyle ':vcs_info:git:*' formats ' on %F{cyan}%b%f'

    setopt PROMPT_SUBST
    PROMPT='%F{green}%n%f at %F{yellow}%m%f in %F{blue}%~%f${vcs_info_msg_0_} %(?.%F{magenta}>%f.%F{red}>%f) '
fi

alias ls='ls -G'
alias ll='ls -la'

export GPG_TTY=$(tty)
export CPATH="$(brew --prefix)/include:$CPATH"
export LIBRARY_PATH="$(brew --prefix)/lib:$LIBRARY_PATH"
