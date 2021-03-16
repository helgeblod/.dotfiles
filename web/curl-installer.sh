#!/usr/bin/env bash
set -euo pipefail

echo "👨‍🍳 Preparing your system for dotfiles"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # TODO Add support for other package managers
    echo "I know this, this is a Linux system 🐧"
    apt-get update
    # Use homebrew on linux to avoid hassle with sudo and missing packages
    apt-get install build-essential curl file git
    # Install homebrew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    brew install git fish exa procs dust tealdeer sd htop

elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "I know this, this is MacOS 🍏"
    brew update
    brew install git fish exa sd bat procs dust tealdeer htop
elif [[ "$OSTYPE" == "freebsd"* ]]; then
    echo "I know this, this i a FreeBSD system 😈"
    pkg update
    pkg install git fish exa sd bat procs dust tealdeer htop
else
    echo "I don't know this system 😞"
    exit 1
fi

echo "📦 Fetching dotfiles repo"
git clone https://github.com/helgeblod/.dotfiles.git ~/.dotfiles

echo "Running dotfile installer"
~/.dotfiles/install

echo "Changing shell to 🐟"
chsh -s $(which fish)

echo "Dotfiles set up ✨"
