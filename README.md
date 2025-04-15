# dotfiles

- Install brew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

- Install gnupg and git
```bash
brew install gnupg git
```

- set up gnupg
```bash
echo 'export GPG_TTY=$(tty)' >> ~/.zshrc
source ~/.zshrc
```

```bash
gpg --full-generate-key
```

```bash
gpg --list-secret-keys --keyid-format=long
```

```bash
git config --global user.signingkey KEY_ID
git config --glopbal commit.gpgsign true
```

- add public key to github
```bash
gpg --armor --export KEY_ID
```

set up ssh key
```bash
ssh-keygen -t ed25519 -C "youremail@example.com"
```

add ssh key to the ssh-agent
```bash
eval "$(ssh-agent -s)"
```

add key to it

```bash
ssh-add ~/.ssh/id_ed25519
```

add ssh key to github
```bash
cat ~/.ssh/id_ed25519.pub
```

Test your connection
```bash
ssh -T git@github.com
```

initialize dotfiles git repo
```bash
git init
```

create .gitignore
```bash
touch .gitignore
```

add and commit .gitignore to git
```bash
git add .gitignore
git commit -m "feat: Create .gitignore"
```

add remote git repo
```bash
git remote add origin git@github.com:yourusername/dotfiles.git
```

```bash
git push origin master
```

- add to .zshrc
```bash
autoload -U colors && colors
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats ' on %F{cyan}%b%f'

setopt PROMPT_SUBST
PROMPT='%F{green}%n%f at %F{yellow}%m%f in %F{blue}%~%f${vcs_info_msg_0_}
%(?.%F{magenta}>%f.%F{red}>%f) '

alias ls='ls -G'
alias ll='ls -la'
```
