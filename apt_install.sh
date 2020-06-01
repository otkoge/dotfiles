# All the needed tools

function is_installed { 
    if [[ $1 == "python3-pip" ]]; then
        which pip3 &> /dev/null
    else
        which $1 &> /dev/null 
    fi
}

function install {
  is_installed $1
  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo apt install $1
  else
    echo "Already installed: ${1}"
  fi
}

sudo add-apt-repository ppa:jonathonf/vim

install git
install zsh
install curl
install tmux
install vim
install python3-pip
