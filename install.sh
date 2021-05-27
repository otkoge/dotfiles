
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


source "${DIR}/zsh/scripts/update_my_tools"

install_base_tools



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

# Go tools

# cat $DIR/tools/go_tools | grep -v '#' | grep -v -e '^$' | while read line; do
#     is_installed $(echo $line | rev | cut  -d"/" -f1 | rev)
#     if [[ $? -ne 0 ]]; then
#         go get $line
#     fi
# done 


function symlink_if_needed {
    if [ ! -L $1 ]; then
        ln -s $2 $1
        echo "Symlinking $1 to $2"
    else
        echo "Link $1 already exists: $(ls -la $1 | rev | cut -d" " -f1 | rev)"
    fi
}

COMP_DIR="$HOME/.completions"
symlink_if_needed $COMP_DIR "$DIR/zsh/completions" 

ALIAS_FILE="$HOME/.aliases"
symlink_if_needed $ALIAS_FILE "$DIR/zsh/aliases" 

ZSHRCFILE="$HOME/.zshrc"
symlink_if_needed $ZSHRCFILE "$DIR/zsh/zshrc" 

P9KFILE="$HOME/.powerlevel9k"
symlink_if_needed $P9KFILE "$DIR/zsh/powerlevel9k" 

SCRIPTFOLDER="$HOME/.scripts"
symlink_if_needed $SCRIPTFOLDER "$DIR/zsh/scripts"

TMUXCONF="$HOME/.tmux.conf"
symlink_if_needed $TMUXCONF "$DIR/tmux.conf"



NVIM_CONF_FOLDER="$HOME/.config/nvim"
if [ ! -d $NVIM_CONF_FOLDER ]; then
    mkdir -p $NVIM_CONF_FOLDER
fi

NVIMCONF="$NVIM_CONF_FOLDER/init.vim"
symlink_if_needed $NVIMCONF "$DIR/vim/init.vim"

NVIMSLINE="$NVIM_CONF_FOLDER/statusline.vim"
symlink_if_needed $NVIMSLINE "$DIR/vim/statusline.vim"

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

for SCRIPT in "$SCRIPTFOLDER/*"; do
    chmod u+x $SCRIPT
done
