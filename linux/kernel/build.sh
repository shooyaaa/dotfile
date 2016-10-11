#!/bin/bash


TOOLS=(install libncurses5-dev gcc make git exuberant-ctags bc libssl-dev)

function join_by { local IFS="$1"; shift; echo "$*";  }


#ubuntu

sudo apt-get install `join_by ' ' "${TOOLS[@]}"`


#minimal config
ktest.pl

