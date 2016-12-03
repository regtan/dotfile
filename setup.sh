#!/bin/sh

echo 'Hello! new Mac!'
cd ~
echo 'generate keypair?[Y/n]'
read ANSWER

case $ANSWER in
  "" | "Y" | "y" )
    ssh-keygen;;
  * ) echo "generate keypair skip";;
esac

echo 'clone dotfiles?[Y/n]'
read ANSWER

case $ANSWER in
  "" | "Y" | "y" )
    git clone git@github.com:regtan/dotfile.git
  * ) echo "clone dotfile skip";;
esac

echo 'install homebrew?[Y/n]'
case $ANSWER in
  "" | "Y" | "y" )
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  * ) echo "install homebrew skip";;
esac

echo 'install ansible?[Y/n]'
case $ANSWER in
  "" | "Y" | "y" )
    brew install python
    brew install ansible
    rehash
  * ) echo "install homebrew skip";;
esac

echo 'run ansible?[Y/n]'
case $ANSWER in
  "" | "Y" | "y" )
    cd ~/dotfile
    HOMEBREW_CASK_OPTS="--appdir=/Applications" ansible-playbook -i hosts -vv localhost.yml
  * ) echo "install homebrew skip";;
esac

echo 'setup dotfiles?[Y/n]'
case $ANSWER in
  "" | "Y" | "y" )
    echo 'copy dotfiles ~/dotfile -> ~/config'
    mkdir ~/config/zsh
    mkdir ~/config/vim
    cp ~/dotfile/.zshrc ~/config/zsh/.zshrc
    cp ~/dotfile/.vimrc ~/config/vim/.zimrc
    echo 'create .zshrc symbolic link'
    ln -s ~/config/zsh/.zshrc ~/.zshrc
  * ) echo "install homebrew skip";;
esac

echo 'new Mac setup finished!! Please run chsh /bin/zsh'