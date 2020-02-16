function is_installed { 
    which $1 &> /dev/null 
}


if [[ "$OSTYPE" == "linux-gnu" ]]; then
    function installer {
        apt-get install $1
    }
elif [[ "$OSTYPE" == "darwin"* ]]; then
    function installer {
        brew install $1
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

if [[ ! -d ~/.oh-my-zsh/custom/themes/powerlevel9k ]]; then
    echo "Installing Powerlevel9k"
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
    echo "Install nerd fonts: https://github.com/ryanoasis/nerd-fonts"
fi

if [[ ! -d ~/.vim/bundle/Vundle.vim ]]; then
    echo "Installing Vundle"
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi


# Go tools
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cat $DIR/tools/go_tools | grep -v '#' | grep -v -e '^$' | while read line; do
    is_installed $(echo $line | rev | cut  -d"/" -f1 | rev)
    if [[ $? -ne 0 ]]; then
        go get $line
    fi
done 
