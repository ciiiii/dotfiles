# dotfiles

## yadm Usage

```bash
# commit file
yadm add .
yadm commit -m "commit message"

# commit encrypted file
echo 'path/to/file' > ~/.config/yadm/encrypt
yadm encrypt
yadm commit -m "commit message"

# use in new device
yadm clone https://github.com/ciiiii/dotfiles
yadm submodule update --init --recursive

# sync config
yadm submodule update --recursive --remote
```

## brew
```bash
# init brew and yadm
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval $(/opt/homebrew/bin/brew shellenv)
brew install yadm

# install package
brew bundle
```

## krew
```bash
krew install < ~/Krewfile
```

## sdkman
```bash
# https://sdkman.io/install
curl -s "https://get.sdkman.io" | bash
```