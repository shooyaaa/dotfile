#!/bin/bash

echo 'start install mac app'

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install macvim --with-cscope --with-lua
brew install ack
