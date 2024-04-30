if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Include all custom completion files
for file in ~/.config/fish/completions/*.fish
    source $file
end

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# if test -f /home/eivind/programs/miniconda3/bin/conda
#     eval /home/eivind/programs/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# else
#     if test -f "/home/eivind/programs/miniconda3/etc/fish/conf.d/conda.fish"
#         . "/home/eivind/programs/miniconda3/etc/fish/conf.d/conda.fish"
#     else
#         set -x PATH "/home/eivind/programs/miniconda3/bin" $PATH
#     end
# end
# # <<< conda initialize <<<

# Zoxide init
zoxide init --cmd cd fish | source

starship init fish | source

set -x CARGO_HOME ~/programs/cargo
set -x GOPATH ~/programs/go
set -x EDITOR nvim
set -x VISUAL nvim
