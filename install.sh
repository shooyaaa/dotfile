#!/bin/bash

BASEDIR=$(dirname "$0")
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )"

DOTFILES=`find ${DIR} -maxdepth 1 -name '\.*' -type f`
BASHPROFILES=( .bash_profile .bashrc )
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
    file=`basename ${file}`
    FULLPATH=${DIR}/$file
    ln -s -f ${FULLPATH} ${HOME}/${file} 
    SOURCECMD="source $file"
    HASSOURCE=`grep "${SOURCECMD}" ${ETCFILE}|wc -l`
    if [ 0 -eq ${HASSOURCE} ];then
        echo "${SOURCECMD}" >> ${ETCFILE}
    fi
    
done

LINKFILES=`find ${DIR}/soft_links -maxdepth 1 -name '\.*' -type f`
for file in ${LINKFILES};do
    BASENAME=`basename $file`
    ln -s -f ${file} ${HOME}/${BASENAME} 
done
