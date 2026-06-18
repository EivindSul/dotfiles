ANTIDOTEDIR=$ZDOTDIR/antidote

if [ -f $ANTIDOTEDIR/antidote.zsh ]; then
	source $ANTIDOTEDIR/antidote.zsh

	antidote load
fi

# https://thevaluable.dev/zsh-install-configure-mouseless/
# https://grml.org/zsh/zsh-lovers.html
# https://github.com/KulkarniKaustubh/dotfiles/blob/main/zsh/.zshrc

# - - - - - - - - - - - - - - - EXTERNAL SCRIPTS - - - - - - - - - - - - - - - #

eval "$(starship init zsh)"

eval "$(zoxide init --cmd cd zsh)"

# eval "$(uv generate-shell-completion zsh)"

source <(fzf --zsh)

export FZF_CTRL_R_OPTS='--style minimal --color 16 --info inline --no-sort --no-preview'

# - - - - - - - - - - - - - - - OPTIONS - - - - - - - - - - - - - - - #

bindkey -a -r '\e' # For insert
bindkey -r '\e' # For normal

bindkey -M vicmd '^d' vi-cmd-mode
bindkey -M viins '^d' vi-cmd-mode

bindkey -M vicmd 'i' vi-insert
bindkey -M vicmd 'I' vi-insert-bol
bindkey -M vicmd 'a' vi-add-next
bindkey -M vicmd 'A' vi-add-eol

setopt auto_cd
setopt auto_pushd

# Edit current line in vim
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# - - - - - - - - - - - - - - - COMPLETIONS - - - - - - - - - - - - - - - #

_comp_options+=(globdots)

# https://unix.stackexchange.com/questions/214657/what-does-zstyle-do
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' \
	'r:|=*' \
	'l:|= r:|=*'

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "$fg[yellow]%B-- %d --%b%f"
zstyle ':completion:*:messages' format '%d'
# zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:warnings' format ""
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

autoload -Uz compinit && compinit

zmodload zsh/complist
bindkey -M menuselect '^n' down-line-or-search
bindkey -M menuselect '^p' up-line-or-search
bindkey -M menuselect '^y' accept-line
bindkey -M menuselect '\e' send-break

bindkey -M viins '^n' menu-complete
bindkey -M viins '^p' reverse-menu-complete

# - - - - - - - - - - - - - - - ALIASES - - - - - - - - - - - - - - - #

alias zs="source $ZDOTDIR/.zshrc"

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'

# print full path to one or more files
pwd() {
	if [[ "$#" -eq 0 ]]; then
		echo "$PWD"
		return
	fi
	printf "$PWD/%s\n" "$@"
}

if command -v fzf >/dev/null 2>&1; then
	alias mvd='ls ~/Downloads/ | fzf --multi | xargs -I {} mv ~/Downloads/{} .'
	alias mvp='ls ~/Pictures/ | fzf --multi | xargs -I {} mv ~/Pictures/{} .'
	if command -v firefox >/dev/null 2>&1; then
		alias ff='ls *.pdf | fzf | xargs -I {} firefox {}'
	else
		alias ff='echo "firefox does not exist!" >&2'
	fi
else
	alias mvd='echo "fzf does not exist!" >&2'
	alias mvp='echo "fzf does not exist!" >&2'
	alias ff='echo "fzf does not exist!" >&2'
fi

if command -v python3 >/dev/null 2>&1; then
	alias py='python3'
elif command -v python >/dev/null 2>&1; then
	alias py='python'
fi

if command -v bat >/dev/null 2>&1; then
	alias cat='bat'
fi

if command -v eza >/dev/null 2>&1; then
	alias ls='eza'
	alias ll='eza -l'
	alias la='eza -la'
	alias tree='eza --tree'
else
	alias ll='ls -l'
	alias la='ls -la'
fi

if command -v brew >/dev/null 2>&1; then
	function brewup () {
		echo "Running \"brew update\"..."
		if ! brew update; then
			echo "Failed to update!"
			return
		fi
		echo "Done with update."
		echo "Running \"brew upgrade\"..."
		if ! brew upgrade; then
			echo "Failed to upgrade!"
			return
		fi
		echo "Done with upgrade."
	}
fi

alias cp='cp -i'
alias mv='mv -i'

alias gs='git status --short'
alias gd='git diff --output-indicator-new=" " --output-indicator-old=" "'
alias gds='git diff --output-indicator-new=" " --output-indicator-old=" " --staged'

alias ga='git add'
alias gap='git add --patch'
alias gc='git commit'

alias gP='git push'
alias gp='git pull'

alias gl="git log --all --graph --pretty=format:'%C(magenta)%h %C(white) %an %ar%C(auto) %D%n%s%n'"
alias gb='git branch'
alias gba='git branch --all'

alias gi='git init'
alias gcl='git clone'

if [ ! -z $ZELLIJ ]; then
	function zr () { zellij run --name "$*" -- zsh -ic "$*";}
	function zrf () { zellij run --name "$*" --floating -- zsh -ic "$*";}
	function zri () { zellij run --name "$*" --in-place -- zsh -ic "$*";}
	function ze () { zellij edit "$*";}
	function zef () { zellij edit --floating "$*";}
	function zei () { zellij edit --in-place "$*";}
	function zpipe () { 
	  if [ -z "$1" ]; then
		zellij pipe;
	  else 
		zellij pipe -p $1;
	  fi
	}
fi

# - - - - - - - - - - - - - - - FUNCTIONS - - - - - - - - - - - - - - - #

editrc() {
	local floating=0
	local configfiles=("$ZDOTDIR/.zshrc" "$ZDOTDIR/.zprofile" "$HOME/.zshenv")

	while getopts "f" in opt; do
		echo "opt is $opt"
		case $opt in
			f) floating=1 ;;
		esac
	done

	if [ -z "${ZELLIJ}" ]; then
		local editor="${EDITOR:-nvim}"
		"$editor" "${configfiles[@]}"
	else
		zellij edit --cwd "$ZDOTDIR" --floating "$ZDOTDIR/.zshrc"
		# TODO: Fiks arg parsing og array indexing
		# if (( floating )); then
		# 	echo 'floating true'
		# 	zellij edit --cwd "$ZDOTDIR" --floating "${configfiles[0]}"
		# else
		# 	echo 'floating false'
		# 	zellij edit --cwd "$ZDOTDIR" "${configfiles[0]}"
		# fi
	fi
}

untar() {
	while (( $# )); do
		if [[ ! -f $1 ]] then;
			echo "File not found: $1" >&2
			return 1
		fi
		if [[ "$1" == *.tar.gz ]]; then
			tar -xvfz $file ||
		elif [[ "$1" == *.tar.xz ]]; then
			tar -xvf $file
		else
			echo "$1 is not a tar file" >&2
			return 1
		fi
		shift
	done
}
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# - - - - - - - - - - - - - - - MAC - - - - - - - - - - - - - - - #
export HOMEBREW_NO_ENV_HINTS=1

# - - - - - - - - - - - - - - - MISC - - - - - - - - - - - - - - - #

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.local/opt/sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"

. "$HOME/.local/bin/env"
