#!/bin/bash

PWD=`pwd`
DOTFILES=`find . -name '\.*' -type f|xargs basename`
BASHPROFILES=( .bash_profile .bashrc )
NEEDSOURCE=(.alias .export .bash_funplus)
HOME=`echo $HOME`

for profile in ${BASHPROFILES[@]};do
    if [ -f "${HOME}/${profile}" ];then
        ETCFILE="${HOME}/${profile}"
        break
    fi
done

if [ -z ${ETCFILE} ];then
    echo 'no bash etc file found'
    exit
else
    echo "add dotfile to etc file:${ETCFILE}"
fi
for file in ${DOTFILES};do
    FULLPATH=${PWD}/$file
    ln -s -f ${FULLPATH} ${HOME}/${file} 
    echo "source $file" >> ${ETCFILE}
    
done
