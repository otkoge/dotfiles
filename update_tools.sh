# All the needed tools

function is_installed { 
    which $1 &> /dev/null 
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

function install_python {
    is_installed pip3  
    if [ $? -ne 0 ]; then
        sudo apt install python3-pip
        sudo pip3 install --upgrade pip
    fi
    pip3 freeze | grep "virtualenv=" &> /dev/null
    if [ $? -ne 0 ]; then
        sudo pip3 install --upgrade virtualenv
    fi
    pip3 freeze | grep "virtualenvwrapper=" &> /dev/null
    if [ $? -ne 0 ]; then
        sudo pip3 install --upgrade virtualenvwrapper
    fi
}

function update_lsd {
    VERSION=$(curl -s -L -H "Accept: application/json" https://github.com/Peltoche/lsd/releases/latest | jq -r '.tag_name')
    is_installed lsd
    if [ $? -ne 0 ] || [ "$(lsd --version | cut -d" " -f2)" != "$VERSION" ]; then
        echo "Updating lsd ${VERSION}"
        TMP_FILE="$(mktemp)"
        wget "https://github.com/Peltoche/lsd/releases/download/${VERSION}/lsd_${VERSION}_amd64.deb" -O $TMP_FILE
        sudo dpkg -i "$TMP_FILE"
        rm -f "${TMP_FILE}"
    else
        echo "lsd is already latest version"
    fi

}

function update_go {
    VERSION=$(curl -s https://golang.org/dl/ | grep linux-amd64 | head -1 | grep -oP 'go[0-9\.]+')
    is_installed "go"
    if [ $? -eq 0 ] && [[ "$(go version | cut -d" " -f3)" == "$VERSION" ]]; then
        echo "${VERSION} is already installed"
    else
        echo "Updating ($VERSION)"
        TMP_FILE="$(mktemp)"
        echo "Downloading https://golang.org/dl/${VERSION}linux-amd64.tar.gz"
        curl -o $TMP_FILE -L "https://golang.org/dl/${VERSION}linux-amd64.tar.gz"
        sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf "${TMP_FILE}"
        sudo rm "${TMP_FILE}"
    fi
}

function update_nvim {
    # echo "Updating Neovim ${VERSION}"
    rm -f ~/.local/bin/nvim
    mkdir -p ~/.local/bin
    curl -L -o ~/.local/bin/nvim https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
    chmod u+x ~/.local/bin/nvim
}

function update_fzf {
    if [ -d $HOME/.fzf ]; then
       cd $HOME/.fzf/ && git remote update && git status -uno | grep "is behind" 2> /dev/null
        if [ $? -eq 0 ]; then
            git pull
            $HOME/.fzf/install
        fi
    else
        git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
        $HOME/.fzf/install
    fi
}

function install_navi {
    bash <(curl -sL https://raw.githubusercontent.com/denisidoro/navi/master/scripts/install)
}


