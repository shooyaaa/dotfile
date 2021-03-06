#!/bin/bash

USER=`whoami`
OS="`uname`"
case $OS in
      'Linux')
        OS='linux'
        ;;
        'Darwin')
        OS='mac'
        ;;
esac
echo ${OS}

BASEDIR=$(dirname "$0")
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"  )" && pwd  )"

DOTFILES=`find ${DIR} -maxdepth 1 -name '\.*' -type f |sort`
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
FIRSTINSTALL=0
for file in ${DOTFILES};do
    file=`basename ${file}`
    FULLPATH=${DIR}/$file
    ln -s -f ${FULLPATH} ${HOME}/${file}
    SOURCECMD="source ~/$file"
    HASSOURCE=`grep "${SOURCECMD}" ${ETCFILE}|wc -l`
    if [ 0 -eq ${HASSOURCE} ];then
        echo "${SOURCECMD}" >> ${ETCFILE}
        FIRSTINSTALL=1
    fi
done

if [ ${FIRSTINSTALL} -eq 1 ];then
    echo 'install crontab '
    line="* 5 * * * cd ${DIR};git pull"
    (crontab -u ${USER} -l; echo "$line" ) | crontab -u ${USER} -
    source ${DIR}/${OS}/install_app.sh
    [ -f ~/bin ] && echo '' || mkdir ~/bin
    curl http://beyondgrep.com/ack-2.14-single-file > ~/bin/ack && chmod 0755 !#:3
fi

LINKFILES=`find ${DIR}/soft_links -maxdepth 1 -name '\.*' -type f`
for file in ${LINKFILES};do
    BASENAME=`basename $file`
    ln -s -f ${file} ${HOME}/${BASENAME}
done

#process vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

cd ~/.vim/bundle/YouCompleteMe
./install.py

echo ${DIR}


SOURCEPATH=${HOME}/code/source_code
mkdir -p ${SOURCEPATH}
cd ${SOURCEPATH}
git clone https://github.com/facebook/watchman.git
cd watchman
git checkout v4.9.0  # the latest stable release
./autogen.sh
./configure
make
sudo make install
