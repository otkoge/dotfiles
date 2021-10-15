
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


source "${DIR}/zsh/scripts/update_my_tools"
install jq
install tmux
install nodejs
install npm
install git
install zsh
install curl
update_go
update_lsd
update_nvim

## VirtualEnvWrapper
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    export VIRTUALENVWRAPPER_PYTHON="/usr/bin/python3"
    export WORKON_HOME=~/.venv
    export PATH=/usr/local/go/bin/:$PATH
elif [[ "$OSTYPE" == "darwin"* ]]; then
    export VIRTUALENVWRAPPER_PYTHON="/usr/local/bin/python3"
    export WORKON_HOME=~/.virtualenvs
    export PATH=/usr/local/go/bin/:$PATH
fi
export PIP_VIRTUALENV_BASE=$WORKON_HOME
install_python


## Language servers
is_installed bash-language-server
if [[ $? -ne 0 ]]; then
    sudo npm i -g bash-language-server
fi

npm list -g  | grep  vscode-html-languageserver-bin &> /dev/null
if [ $? -ne 0 ]; then
    sudo npm install -g vscode-html-languageserver-bin
fi

npm list -g  | grep  yaml-language-server &> /dev/null
if [ $? -ne 0 ]; then
    sudo npm install -g yaml-language-server
fi

npm list -g  | grep vscode-json-languageserver &> /dev/null
if [ $? -ne 0 ]; then
    sudo npm install -g vscode-json-languageserver
fi

npm list -g  | grep vim-language-server &> /dev/null
if [ $? -ne 0 ]; then
    sudo npm install -g vim-language-server
fi

pip3 freeze | grep "python-language-server=" &> /dev/null
if [ $? -ne 0 ]; then
    sudo pip3 install --upgrade 'python-language-server[all]'
fi
 
pip install 'python-language-server[all]'


function symlink_it {
    if [ ! -L $1 ]; then
        echo "Symlinking $1 to $2"
    else
        rm $1
        echo "Replacing existing link $1 to $2"
    fi
    ln -s $2 $1
}

COMP_DIR="$HOME/.completions"
symlink_it $COMP_DIR "$DIR/zsh/completions" 

ALIAS_FILE="$HOME/.aliases"
symlink_it $ALIAS_FILE "$DIR/zsh/aliases" 

ZSHRCFILE="$HOME/.zshrc"
symlink_it $ZSHRCFILE "$DIR/zsh/zshrc" 

P9KFILE="$HOME/.powerlevel9k"
symlink_it $P9KFILE "$DIR/zsh/powerlevel9k" 

SCRIPTFOLDER="$HOME/.scripts"
symlink_it $SCRIPTFOLDER "$DIR/zsh/scripts"

TMUXCONF="$HOME/.tmux.conf"
symlink_it $TMUXCONF "$DIR/tmux.conf"

NVIM_CONF_FOLDER="$HOME/.config/nvim"
if [ ! -d $NVIM_CONF_FOLDER ]; then
    mkdir -p $NVIM_CONF_FOLDER
fi

NVIMCONF="$NVIM_CONF_FOLDER/init.vim"
symlink_it $NVIMCONF "$DIR/vim/init.vim"

NVIMSLINE="$NVIM_CONF_FOLDER/statusline.vim"
symlink_it $NVIMSLINE "$DIR/vim/statusline.vim"

NVIMLUA="$NVIM_CONF_FOLDER/lua"
symlink_it $NVIMLUA "$DIR/vim/lua"

git clone git@github.com:otkoge/snippets.git $HOME/.snippets
symlink_it $HOME/.snippets/navi $HOME/.local/share/navi/cheats/mysnippets


for SCRIPT in "$SCRIPTFOLDER/*"; do
    chmod u+x $SCRIPT
done

if [[ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]]; then
    sh -c 'curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

if [[ ! -d "$WORKON_HOME/nvim" ]]; then
    mkvirtualenv nvim
    $WORKON_HOME/nvim/bin/pip install black pynvim
fi

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
cat $DIR/tools/go_tools | grep -v '#' | grep -v -e '^$' | while read line; do
    is_installed $(echo $line | rev | cut  -d"/" -f1 | rev)
    if [[ $? -ne 0 ]]; then
        go get $line
    fi
done 


