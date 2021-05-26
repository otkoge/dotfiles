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

function install_lsd {
  is_installed lsd
  if [ $? -ne 0 ]; then
      TMP_FILE="$(mktemp)"
      wget "https://github.com/Peltoche/lsd/releases/download/0.20.1/lsd_0.20.1_amd64.deb" -O $TMP_FILE
      sudo dpkg -i "$TMP_FILE"
      rm -f "$TMP_FILE"
  else
       echo "LSD already installed"
  fi

}

function install_go {
    VERSION=$(curl -s https://golang.org/doc/install | grep goVersion | cut -d'"' -f2)
    curl -O -L "https://golang.org/dl/${VERSION}.linux-amd64.tar.gz"
    sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf "${VERSION}.linux-amd64.tar.gz"
    sudo rm "${VERSION}.linux-amd64.tar.gz"
}

function install_nvim {
    mkdir ~/.appimages
    curl -L -o ~/.appimages/nvim https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x ~/.appimages/nvim
}


install git
install zsh
install curl
install python3-pip
install_lsd
install tmux
install_go
install_nvim
