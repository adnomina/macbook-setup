function fish_greeting
    printf (set_color --bold 00FFFF)"Greetings, User. Welcome to the Grid.\n"(set_color normal)
end

set -gx EDITOR nvim

alias la="ls -la"
alias vi='nvim'
alias vim='nvim'

starship init fish | source
