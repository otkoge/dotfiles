DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

COMP_DIR="$HOME/.completions"
if [ ! -L $COMP_DIR ]; then
    ln -s "$DIR/zsh/completions" "$COMP_DIR"
fi

ALIAS_FILE="$HOME/.aliases"
if [ ! -L $ALIAS_FILE ]; then
    ln -s "$DIR/zsh/aliases" "$ALIAS_FILE"
fi

VIMRCFILE="$HOME/.vimrc"
if [ ! -L $VIMRCFILE ]; then
    ln -s "$DIR/vim/vimrc" "$VIMRCFILE"
fi


VIMPLUGINS="$HOME/.plugins.vim"
if [ ! -L $VIMPLUGINS ]; then
    ln -s "$DIR/vim/plugins.vim" "$VIMPLUGINS"
fi

ZSHRCFILE="$HOME/.zshrc"
if [ ! -L $ZSHRCFILE ]; then
    ln -s "$DIR/zsh/zshrc" "$ZSHRCFILE"
fi

P9KFILE="$HOME/.powerlevel9k"
if [ ! -L $P9KFILE ]; then
    ln -s "$DIR/zsh/powerlevel9k" "$P9KFILE"
fi

SCRIPTFOLDER="$HOME/.scripts"
if [ ! -L $SCRIPTFOLDER ]; then
    ln -s "$DIR/scripts" "$SCRIPTFOLDER"
fi

for SCRIPT in "$SCRIPTFOLDER/*"; do
    chmod u+x $SCRIPT
done
