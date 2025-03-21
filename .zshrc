autoload -U colors && colors
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats ' on %F{cyan}%b%f'

setopt PROMPT_SUBST
PROMPT='%F{green}%n%f at %F{yellow}%m%f in %F{blue}%~%f${vcs_info_msg_0_}
%(?.%F{magenta}❯%f.%F{red}❯%f) '

alias ls='ls -G'
alias ll='ls -la' 
alias vi='nvim'
alias vim='nvim'

export GPG_TTY=$(tty)
export CPATH="$(brew --prefix)/include:$CPATH"
export LIBRARY_PATH="$(brew --prefix)/lib:$LIBRARY_PATH"
export PATH="/Applications/Xcode.app/Contents/Developer/usr/bin:$PATH"
export PATH="/usr/local/texlive/2024/bin/universal-darwin:$PATH"

neofetch
