function is_installed { 
    which $1 &> /dev/null 
}


if [[ "$OSTYPE" == "linux-gnu" ]]; then
    function installer {
        apt-get install $1
    }
elif [[ "$OSTYPE" == "darwin"* ]]; then
    function installer {
        brew install
    }
else
    echo "OS not planned for yet..."
fi




function install {
  is_installed $1

  if [ $? -ne 0 ]; then
    echo "Installing: ${1}..."
    installer $1
  else
    echo "Already installed: ${1}"
  fi
}

# Basics that needed to setup everything else
install curl
install git

# Oh my zsh
# 
if [[ ! -f ~/.oh-my-zsh/oh-my-zsh.sh ]]; then
    echo "Installing Oh My ZSH"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [[ ! -f ~/.oh-my-zsh/custom/themes/powerlevel9k ]]; then
    echo "Installing Powerlevel9k"
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
    echo "Install nerd fonts: https://github.com/ryanoasis/nerd-fonts"
fi

# if [[ ! is_installed powerline ]]
#     pip3 install --user powerline-status
# fi
