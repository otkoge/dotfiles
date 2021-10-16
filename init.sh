DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


function symlink_it {
    if [ ! -L $1 ]; then
        echo "Symlink $1 was missing; creating $1 -> $2"
    else
        rm $1
    fi
    ln -s $2 $1
}

symlink_it $HOME/.completions "$DIR/zsh/completions" 
symlink_it $HOME/.aliases "$DIR/zsh/aliases" 
symlink_it $HOME/.zshrc "$DIR/zsh/zshrc" 
symlink_it $HOME/.powerlevel9k "$DIR/zsh/powerlevel9k" 
symlink_it $HOME/.scripts "$DIR/zsh/scripts"
symlink_it $HOME/.tmux.conf "$DIR/tmux.conf"
symlink_it $HOME/.snippets/navi $HOME/.local/share/navi/cheats/mysnippets

NVIM_CONF_FOLDER="$HOME/.config/nvim"
if [ -d $NVIM_CONF_FOLDER ]; then
    symlink_it $NVIM_CONF_FOLDER/init.vim "$DIR/vim/init.vim"
    symlink_it $NVIM_CONF_FOLDER/statusline.vim "$DIR/vim/statusline.vim"
    symlink_it $NVIM_CONF_FOLDER/lua "$DIR/vim/lua"
fi

source $DIR/update_tools.sh
wget -q --spider https://github.com
if [ $? -eq 0 ]; then
    update_lsd
    update_go
    update_fzf
fi

cd $DIR && git pull
cd $HOME/.snippets && git pull
