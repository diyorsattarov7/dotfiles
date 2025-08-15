# dotfiles setup

## 1. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## 2. Install Git

```bash
brew install git
```

## 3. Clone your dotfiles repository

```bash
git clone https://github.com/diyorsattarov7/dotfiles.git 
```

## 4. Make the bootstrap script executable

```bash
chmod +x ~/dotfiles/.scripts/mac/bootstrap.sh
```

## 5. Run the bootstrap script

```bash
~/dotfiles/.scripts/mac/bootstrap.sh
```

