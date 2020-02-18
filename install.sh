# Oh my zsh
if [[ ! -f ~/.oh-my-zsh/oh-my-zsh.sh ]]; then
    echo "Installing Oh My ZSH"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Powerlevel9k
if [[ ! -d ~/.oh-my-zsh/custom/themes/powerlevel9k ]]; then
    echo "Installing Powerlevel9k"
    git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
    echo "Install nerd fonts: https://github.com/ryanoasis/nerd-fonts"
fi


# Install vundle 
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
