#zmodload zsh/zprof
source ~/.zsh_aliases

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="wezm"

plugins=(
    git
    git-auto-fetch
)


source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR='nvim'
export GIT_EDITOR='nvim'

for file in ~/github/dotfiles/zsh/*; do
  [ -f "$file" ] && source "$file"
done


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


#zprof

set -o vi
