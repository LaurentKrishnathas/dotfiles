echo "source $HOME/.zprezto/zshrc ..."

# export ZDOTDIR="$HOME/Projects/github/prezto.git"
[[ -s "$HOME/.zprezto/.zshrc" ]] && source $HOME/.zprezto/.zshrc || echo "$HOME/.zprezto/.zshrc missing"

# echo "ZDOTDIR===${ZDOTDIR:-$HOME}"
# for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
#   echo "ln -s $rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t} "
# done