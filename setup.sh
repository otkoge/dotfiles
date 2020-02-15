DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

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

VIMRCFILE="$HOME/.vimrc"
symlink_if_needed $VIMRCFILE "$DIR/vim/vimrc" 


VIMPLUGINS="$HOME/.vim/plugins.vim"
symlink_if_needed $VIMPLUGINS "$DIR/vim/plugins.vim" 

VIMSTL="$HOME/.vim/statusline.vim"
symlink_if_needed $VIMSTL "$DIR/vim/statusline.vim" 

ZSHRCFILE="$HOME/.zshrc"
symlink_if_needed $ZSHRCFILE "$DIR/zsh/zshrc" 

P9KFILE="$HOME/.powerlevel9k"
symlink_if_needed $P9KFILE "$DIR/zsh/powerlevel9k" 

SCRIPTFOLDER="$HOME/.scripts"
symlink_if_needed $SCRIPTFOLDER "$DIR/scripts"

TMUXCONF="$HOME/.tmux.conf"
symlink_if_needed $TMUXCONF "$DIR/tmux/tmux.conf"

for SCRIPT in "$SCRIPTFOLDER/*"; do
    chmod u+x $SCRIPT
done
