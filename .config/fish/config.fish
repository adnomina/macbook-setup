# Variables
set -gx EDITOR hx
set -gx PATH /run/current-system/sw/bin $PATH
set -gx PNPM_HOME /Users/nicolas/Library/pnpm
if not string match -q -- "$PNPM_HOME/bin" $PATH
    set -gx PATH "$PNPM_HOME/bin" $PATH
end

# Functions
function fish_greeting
    printf (set_color --bold 00FFFF)"Greetings, User. Welcome to the Grid.\n"(set_color normal)
end

function rr
    set cmd (history | fzf --header "Choose the command to rerun.")

    eval "$cmd"
end

# Aliases
alias la="ls -la"
alias vi='nvim'
alias vim='nvim'

alias ga="git add"
alias gb="git branch -l"
alias gc="git commit"
alias gd="git diff"
alias gf="git fetch"
alias gl="git log"
alias gm="git merge"
alias gpl="git pull"
alias gps="git push"
alias gr="git restore"
alias gst="git status"
alias gsc="git switch -c"
alias gsw="git switch"

alias dcu="docker compose up"
alias dcd="docker compose down"
alias dcp="docker compose ps"
alias dcl="docker compose logs -f"

alias cc="nono run --profile claude --allow . -- claude"
alias oc="nono run --profile opencode --allow . -- opencode"
alias co="nono run --profile copilot-cli --allow-cwd -- copilot"

# Init scripts
starship init fish | source
zoxide init fish | source
eval "$(fnm env --use-on-cd --version-file-strategy=recursive)"
mise activate fish | source
