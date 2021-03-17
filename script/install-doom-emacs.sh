#!/usr/bin/env bash
set -euo pipefail

if test ! -d ~/.emacs.d
then
    echo "Installing Doom-Emacs"
    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
    ~/.emacs.d/bin/doom install
else
    echo "Doom Emacs installed, skipping ..."
        ~/.emacs.d/bin/doom sync
fi
