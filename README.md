# dotfiles

## Usage

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