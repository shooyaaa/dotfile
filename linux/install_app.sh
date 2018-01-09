#!/bin/bash

sudo apt-get install build-essential cmake vim sysstat golang npm htop

#swap caps and ctrl super as ctrl to copy and paste

sed -i 's/XKBOPTIONS=""/XKBOPTIONS="ctrl:swapcaps,ctrl:swap_lwin_lctl"/g' /etc/default/keyboard
