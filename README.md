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

## firefox userChrome.css
ref: [Customizing the Firefox UI with CSS](https://www.reddit.com/r/firefox/wiki/userchrome/)
1. enable customization
    
    1. navigate to `about:config`
    2. set `toolkit.legacyUserProfileCustomizations.stylesheets` to 
2. find the profile folder
    
    1. navigate to `about:support`
    2. click `about:profiles`
    3. get the "Root Directory" of `dev-edition-default` profile

3. create folder and file

    1. create `chrome` folder under the profile folder
    2. create `userChrome.css` in `chrome` folder