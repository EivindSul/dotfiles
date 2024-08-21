if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Include all custom completion files
for file in ~/.config/fish/completions/*.fish
    source $file
end

# Zoxide init
zoxide init --cmd cd fish | source

starship init fish | source

set -x XDG_CONFIG_HOME ~/.config
set -x CARGO_HOME ~/programs/cargo
set -x GOPATH ~/programs/go
set -x EDITOR nvim
set -x VISUAL nvim
set -x MANPAGER "nvim +Man!"
# set -x TASKRC "$HOME/.config/task/taskrc"
# set -x TASKDATA "$HOME/.local/share/task"
