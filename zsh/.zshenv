export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

export PATH="$HOME/.local/bin:$PATH"
[ -e "/usr/local/go/bin" ] && export PATH="/usr/local/go/bin:$PATH"

export CARGO_HOME="$XDG_DATA_HOME/cargo"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export PATH="$CARGO_HOME/bin:$PATH"

export GOPATH="$XDG_DATA_HOME/go"
export GOBIN="$HOME/.local/bin" # Er denne vits i?

export EDITOR=nvim
export VISUAL=nvim
export MANPAGER="nvim +Man!"
export XDG_CURRENT_DESKTOP=Hyprland
export TASKRC="$XDG_CONFIG_HOME/task/taskrc"
export TASKDATA="$XDG_DATA_HOME/task"

eval "$(/opt/homebrew/bin/brew shellenv)" # Greit å ha denne her? Kanskje den skal i zprofile/zshrc

[ -f "$ZDOTDIR/.zshenv" ] && source "$ZDOTDIR/.zshenv"
