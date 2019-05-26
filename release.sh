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
cp ~/.emacs ~/dotfiles/.emacs
mkdir -p .emacs.d
cp ~/.emacs.d/configuration.org ~/dotfiles/.emacs.d/configuration.org
cp ~/.emacs.d/configuration.el ~/dotfiles/.emacs.d/configuration.el

cd ~/dotfiles
git add .
git commit
git push origin master && echo "=== Released Dotfiles ===" || echo "=== Unable to push repository, try again later"
# if git push origin master; then
#     echo "=== Released Dotfiles ==="
# else 
#     echo "=== Unable to push repository, try again later"
# fi
