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
  if [[ $1 == "vim" ]]; then
    # https://itsfoss.com/vim-8-release-install/
    sudo add-apt-repository ppa:jonathonf/vim
  fi
  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    sudo apt install $1
  else
    echo "Already installed: ${1}"
  fi
}

function install_lsd {
  is_installed lsd
  if [ $? -ne 0 ]; then
      TMP_FILE="$(mktemp)"
      wget "https://github.com/Peltoche/lsd/releases/download/0.19.0/lsd_0.19.0_amd64.deb" -O $TMP_FILE
      sudo dpkg -i "$TMP_FILE"
      rm -f "$TMP_FILE"
  else
       echo "LSD already installed"
  fi

}


install git
install zsh
install curl
install vim
install python3-pip
install_lsd
install tmux
