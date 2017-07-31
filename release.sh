#!/bin/bash

echo "=== Copying Dotfiles ==="
cp ~/.gitignore ~/dotfiles/.gitignore
cp ~/.gitconfig ~/dotfiles/.gitconfig
cp ~/.bash_profile ~/dotfiles/.bash_profile
cp ~/.tmux.conf ~/dotfiles/.tmux.conf
cp ~/.vimrc ~/dotfiles/.vimrc
cp ~/.zshrc ~/dotfiles/.zshrc
cp ~/.zshenv ~/dotfiles/.zshenv

cd ~/dotfiles
git add .
echo "=== Add Commit Message ==="
git commit
git push origin master

echo "=== Released Dotfiles ==="

