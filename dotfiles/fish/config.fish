function fish_greeting
    echo "Hello, Nicolas ✨"
end

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish

alias la="ls -la"
alias vi='nvim'
alias vim='nvim'

starship init fish | source
