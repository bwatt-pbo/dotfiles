#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
<<<<<<< HEAD
files="bashrc vimrc vim zshrc tmux.conf git.scmbrc"    # list of files/folders to symlink in homedir
apt=`command -v apt-get`
yum=`command -v yum`
packages="tmux vim htop ncdu zsh python-virtualenv"
=======
files="bashrc vimrc vim zshrc tmux.conf oh-my-zsh git.scmbrc"    # list of files/folders to symlink in homedir
apt=`command -v apt-get`
yum=`command -v yum`
packages="tmux vim htop ncdu zsh python-virtualenv fortune-fr"
>>>>>>> cfc9e7e3b9cd2b127b3308e0b53280248c82aabb
packages_apt="virtualenvwrapper"
packages_yum="python-vitualenvwrapper"

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

if [ -n "$apt" ]; then
    for pack in $packages; do
	sudo apt-get install -y $pack
    done
    for pack in $packages_apt; do
	sudo apt-get install -y $pack
    done
elif [ -n "$yum" ]; then
    for pack in $packages; do
	sudo yum install -y $pack
    done
    for pack in $packages_apt; do
	sudo yum install -y $pack
    done
fi	

install_zsh () {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Clone my oh-my-zsh repository from GitHub only if it isn't already present
<<<<<<< HEAD
    if [[ ! -d ~/.oh-my-zsh/ ]]; then
        git clone http://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    fi
=======
    if [[ ! -d $dir/oh-my-zsh/ ]]; then
        git clone http://github.com/robbyrussell/oh-my-zsh.git
    fi
    mv $dir/oh-my-zsh ~/.oh-my-zsh
>>>>>>> cfc9e7e3b9cd2b127b3308e0b53280248c82aabb
    rm ~/.oh-my-zsh/oh-my-zsh.sh
    cp $dir/oh-my-zsh.sh ~/.oh-my-zsh/oh-my-zsh.sh
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh)
    fi
else
    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    # If the platform is Linux, try an apt-get to install zsh and then recurse
    if [[ $platform == 'Linux' ]]; then
	if [ -n "$apt" ]; then
            sudo apt-get -y install zsh
	elif [ -n "$yum" ]; then
            sudo yum -y install zsh
	else
	    echo "Err: no path to apt-get or yum";
	    exit 1
	fi
        install_zsh
    # If the platform is OS X, tell the user to install zsh :)
    elif [[ $platform == 'Darwin' ]]; then
        echo "Please install zsh, then re-run this script!"
        exit
    fi
fi
}

install_zsh

# install scm_breeze
echo "Cloning scm_breeze"
<<<<<<< HEAD
if [[ ! -d ~/.scm_breeze ]]; then
    git clone https://github.com/ndbroadbent/scm_breeze.git ~/.scm_breeze
fi
=======
git clone https://github.com/ndbroadbent/scm_breeze.git ~/.scm_breeze
>>>>>>> cfc9e7e3b9cd2b127b3308e0b53280248c82aabb

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done
