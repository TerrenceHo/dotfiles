#!/bin/bash

echo "=== Copying Dotfiles ==="
cp ~/.gitignore ~/dotfiles/.gitignore
cp ~/.gitconfig ~/dotfiles/.gitconfig
cp ~/.bash_profile ~/dotfiles/.bash_profile
cp ~/.tmux.conf ~/dotfiles/.tmux.conf
cp ~/.vimrc ~/dotfiles/.vimrc
cp ~/.zshrc ~/dotfiles/.zshrc
cp ~/.zshenv ~/dotfiles/.zshenv
cp ~/.config/nvim/init.vim ~/dotfiles/init.vim

cd ~/dotfiles
git add .
echo "=== Add Commit Message ==="
git commit
git push origin master && echo "=== Released Dotfiles ===" || echo "=== Unable to push repository, try again later"
# if git push origin master; then
#     echo "=== Released Dotfiles ==="
# else 
#     echo "=== Unable to push repository, try again later"
# fi
