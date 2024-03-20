if status is-interactive
    # Commands to run in interactive sessions can go here
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/eivind/programs/miniconda3/bin/conda
    eval /home/eivind/programs/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/eivind/programs/miniconda3/etc/fish/conf.d/conda.fish"
        . "/home/eivind/programs/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/eivind/programs/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

starship init fish | source
