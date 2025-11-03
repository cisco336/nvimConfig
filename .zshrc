export REGISTRY_TOKEN="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"

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"


alias refresh="source ~/.zshrc"
alias fzf="fzf --preview='bat --color=always {}'"
alias branch="git branch | fzf | xargs git checkout"
alias tag="git tag | fzf | xargs git checkout"
alias ls="eza --icons=always -a"
alias lsl="eza --icons=always -a -l"
alias fonts="atsutil fonts -list"
alias cd="z"
alias coverageweb="npm run test:unit:coverage"
alias fetch="git fetch --all"
alias push="git push"
alias pull="git pull"
alias commit="git cz c"
alias status="git status"
alias rundev="npm run dev"
alias pulldevelop="git checkout develop && git pull"
alias pullmain="git checkout main && git pull"
alias runproxy="cd ~/workspace/british/ancillaires-scripts/shoppingCartProxy && npm run start"
alias lg="lazygit"
alias gitDelete="git branch -D $(git branch | grep -v 'main' | grep -v 'develop')"
alias chromenocors='open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security'

source /Users/francisco.arleo/workspace/british/ancillaires-scripts/portforward.sh
source /Users/francisco.arleo/workspace/british/ancillaires-scripts/setprofile.sh
source /Users/francisco.arleo/workspace/british/ancillaires-scripts/convertmp.sh

export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# starship
eval "$(starship init zsh)"

# FZF
source <(fzf --zsh)

# zoxide
eval "$(zoxide init zsh)"

# the fuck
eval "$(thefuck --alias=fuck)"

# History setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

alias chromenocors='open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security'

source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
