autoload -U colors && colors

autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats ' on %F{cyan}%b%f'

setopt PROMPT_SUBST
PROMPT='%F{green}%n%f at %F{yellow}%m%f in %F{blue}%~%f${vcs_info_msg_0_}
%(?.%F{magenta}❯%f.%F{red}❯%f) '

alias ls='ls -G'  # Colorize ls output
alias ll='ls -la' # Detailed list

export GPG_TTY=$(tty)

export CPATH="$(brew --prefix)/include:$CPATH"
export LIBRARY_PATH="$(brew --prefix)/lib:$LIBRARY_PATH"
export LD_LIBRARY_PATH="$(brew --prefix)/lib:$LD_LIBRARY_PATH"  # Needed for runtime linking
export PATH="/Applications/Xcode.app/Contents/Developer/usr/bin:$PATH"

neofetch
