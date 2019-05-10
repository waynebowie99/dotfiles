#!/usr/bin/env sh

# Get Linux Version
OS=lsb_release -ds 2>/dev/null || cat /etc/*release 2>/dev/null | head -n1 || uname -om

if (OS | grep Arch)
    sudo pacman -S neovim, neovim-qt, python, termite, python-language-server, google-java-format, uncrustify, prettier
fi

# Language Server Installation
pip install python-Language-server

cp -r linux/* ~/.config/nvim/
