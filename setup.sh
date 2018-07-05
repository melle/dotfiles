#!/bin/bash
set -ef

FORCE=false
if [ "$1XX" = "-fXX" ]; then
  FORCE=true
fi

function symlink {
  if [ -f ~/$1 ] && [ $FORCE = "false" ]; then
    echo "❌ Target file $1 exists already!"
    exit 1
  fi 

  if [ $FORCE = "true" ]; then
    rm -f ~/$1
  fi

  ln -sv $(pwd)/$1 ~/ 
}

# setup keyboard prefs
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 1

# setup Finder 
chflags nohidden ~/Library                               # Show Library folder
defaults write com.apple.finder AppleShowAllFiles YES    # Show hidden files
defaults write com.apple.finder ShowPathbar -bool true   # Show path bar
defaults write com.apple.finder ShowStatusBar -bool true # Show status bar

# symlink everything
symlink .bashrc
symlink .bash_config
symlink .bash_environment
symlink .bash_aliases
symlink .profile
symlink .bash_sensible
symlink .git-completion.sh
symlink .config
