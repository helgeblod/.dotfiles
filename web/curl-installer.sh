#!/usr/bin/env bash
set -euo pipefail

echo "👨‍🍳 Preparing your system for dotfiles"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # TODO Add support for other package managers
    echo "I know this, this is a Linux system 🐧"
    apt update
    apt install git fish
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "I know this, this is MacOS 🍏"
    brew update
    brew install git fish
elif [[ "$OSTYPE" == "freebsd"* ]]; then
    echo "I know this, this i a FreeBSD system 😈"
    pkg update
    pkg install git fish
else
    echo "I don't know this system 😞"
    exit 1
fi

echo "📦 Fetching dotfiles repo"
git clone https://github.com/helgeblod/.dotfiles.git ~/.dotfiles
echo "Running dotfile installer"
~/.dotfiles/install

echo "You might want to change your shell to fish 'chsh -s /usr/local/bin/fish' (or similar)"
echo "Dotfiles set up ✨"
