# dotfiles

## 1. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## 2. Install Required Packages

```bash
brew install gnupg git
```

## 3. Set Up GnuPG

Add GPG TTY export to `.zshrc`:

```bash
echo 'export GPG_TTY=$(tty)' >> ~/.zshrc
source ~/.zshrc
```

Generate a GPG key:

```bash
gpg --full-generate-key
```

List secret keys:

```bash
gpg --list-secret-keys --keyid-format=long
```

Configure Git to sign commits:

```bash
git config --global user.signingkey KEY_ID
git config --global commit.gpgsign true
```

## 4. Add Public GPG Key to GitHub

Export your GPG public key:

```bash
gpg --armor --export KEY_ID
```

## 5. Set Up SSH Key

Generate a new SSH key:

```bash
ssh-keygen -t ed25519 -C "youremail@example.com"
```

Start the SSH agent:

```bash
eval "$(ssh-agent -s)"
```

Add your SSH private key:

```bash
ssh-add ~/.ssh/id_ed25519
```

Add the public key to GitHub:

```bash
cat ~/.ssh/id_ed25519.pub
```

Test your GitHub SSH connection:

```bash
ssh -T git@github.com
```

## 6. Initialize Dotfiles Repository

Initialize Git:

```bash
git init
```

Create a `.gitignore` file:

```bash
touch .gitignore
```

Add and commit:

```bash
git add .gitignore
git commit -m "feat: Create .gitignore"
```

Add remote origin:

```bash
git remote add origin git@github.com:yourusername/dotfiles.git
```

Push to GitHub:

```bash
git push origin master
```

## 7. Customize `.zshrc`

Add the following to `.zshrc`:

```bash
autoload -U colors && colors
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats ' on %F{cyan}%b%f'

setopt PROMPT_SUBST
PROMPT='%F{green}%n%f at %F{yellow}%m%f in %F{blue}%~%f${vcs_info_msg_0_} %(?.%F{magenta}>%f.%F{red}>%f) '

alias ls='ls -G'
alias ll='ls -la'
```

## 8. `.gitignore` Rules

Ignore all files, but unignore `.gitignore` and `.zshrc`:

```gitignore
*
!.gitignore
!.zshrc
```
