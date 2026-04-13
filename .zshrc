export REGISTRY_TOKEN=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

# Performance optimization: skip global compinit
export skip_global_compinit=1

export EDITOR="nvim"

# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"

# Minimal plugin set for faster startup
plugins=(
  git
  npm
  eza
  sudo
  extract
  history
)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Aliases (grouped by functionality)
# General shortcuts
alias refresh="source ~/.zshrc"
alias aliases="~/alias_reminder.sh"
alias cd="z"

# Git aliases (kept only non-duplicates)
# Removed: push (use gp), pull (use gl), status (use gst), chk (use gco), chkb (use gcb)
alias fetch="git fetch --all"
alias ph="git push"  # short alias for gp
alias pl="git pull"  # short alias for gl
alias commit="git cz c"  # commitizen specific
alias sts="git status"  # shorter than gst
alias greset='git reset --hard HEAD'
alias pulldevelop="git checkout develop && git pull"
alias pullmain="git checkout main && git pull"
alias lg="lazygit"

# Development aliases
alias rundev="npm run dev"  # could use npmrd but this is clearer
alias coverageweb="npm run test:unit:coverage"

# Utility aliases
alias fonts="atsutil fonts -list"
alias chromenocors='open -n -a /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --args --user-data-dir="/tmp/chrome_dev_test" --disable-web-security'
alias bravenocors='open -n -a /Applications/Brave\ Browser.app/Contents/MacOS/Brave\ Browser --args --user-data-dir="/tmp/brave_dev" --disable-web-security'

# Conditional sourcing of external scripts
[ -f "/Users/francisco.arleo/workspace/british/ancillaries-scripts/portforward.sh" ] && source /Users/francisco.arleo/workspace/british/ancillaries-scripts/portforward.sh
[ -f "/Users/francisco.arleo/workspace/british/ancillaries-scripts/setprofile.sh" ] && source /Users/francisco.arleo/workspace/british/ancillaries-scripts/setprofile.sh
[ -f "/Users/francisco.arleo/workspace/british/ancillaries-scripts/convertmp.sh" ] && source /Users/francisco.arleo/workspace/british/ancillaries-scripts/convertmp.sh

# --- Terminal Utilities ---

# Weather (Usage: weather or weather London)
weather() { curl -s "wttr.in/${1:-}" }

# Dictionary (Usage: define apple)
define() { curl -s "dict://dict.org/d:${1}" }

# Cheat Sheet (Usage: cheat tar or cheat python/read)
cheat() { curl -s "cheat.sh/${1}" }

# IP & Network (Usage: myip or geoip)
alias myip='curl -s ifconfig.me; echo'
alias geoip='curl -s ipinfo.io'

# QR Code Generator (Usage: echo "Hello" | qr)
alias qr='curl -F "-=<-" qrenco.de'

# Stocks (Usage: stock AAPL)
stock() { curl -s "terminal-stocks.dev/${1}" }

# News (Usage: news or news tech)
news() { curl -s "getnews.tech/${1:-}" }

# Fun & Random
alias quote='curl -s https://api.quotable.io/random | jq -r ".content + \" — \" + .author"'
alias advice='curl -s https://api.adviceslip.com/advice | jq -r ".slip.advice"'

# --- End Utilities ---

# Lazy load NVM for faster startup
export NVM_DIR="$HOME/.nvm"
nvm() {
    unset -f nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    nvm "$@"
}

# Lazy load thefuck for better performance
fuck() {
    unset -f fuck
    eval "$(thefuck --alias=fuck)"
    fuck "$@"
}

# Lazy load zsh-syntax-highlighting (moved to end for performance)
zsh_syntax_highlighting() {
    if [ -f "$ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
        source "$ZSH/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    elif [ -f "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
        source "/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    fi
}

# Initialize essential tools
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# FZF setup with performance check
if command -v fzf &> /dev/null; then
    [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh || source <(fzf --zsh)
    alias fzf="fzf --preview='bat --color=always {}'"
    alias branch="git branch | fzf | xargs git checkout"
    alias tag="git tag | fzf | xargs git checkout"
fi

# Load zsh-autosuggestions if available
[ -f "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"

# History configuration (optimized)
HISTFILE=$HOME/.zhistory
SAVEHIST=10000
HISTSIZE=10000
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
setopt hist_ignore_space

# Key bindings for history search
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

export PATH="$PATH:/opt/homebrew/Cellar/ffmpeg-full/8.0.1_3/bin"

# Load syntax highlighting last for better performance
zsh_syntax_highlighting

# Mole shell completion
if output="$(mole completion zsh 2>/dev/null)"; then eval "$output"; fi
