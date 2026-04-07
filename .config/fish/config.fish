function fish_greeting
    printf (set_color --bold 00FFFF)"Greetings, User. Welcome to the Grid.\n"(set_color normal)
end

set -gx EDITOR nvim
set -gx PATH /run/current-system/sw/bin $PATH

alias la="ls -la"
alias vi='nvim'
alias vim='nvim'
alias cat="bat"
alias less="bat"
alias cc="claude"
alias oc="opencode"
alias z="zeditor"
alias find="fd"

starship init fish | source

# pnpm
set -gx PNPM_HOME "/Users/nicolas/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/nicolas/.lmstudio/bin
# End of LM Studio CLI section
