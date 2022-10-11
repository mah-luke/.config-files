
# Enable colors
autoload -U colors && colors

# enable color support of ls and also add handy aliases
  if [ -x /usr/bin/dircolors ]; then
      test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
      alias ls='ls --color=auto'
      alias dir='dir --color=auto'
      alias vdir='vdir --color=auto'
      alias grep='grep --color=auto'
      alias fgrep='fgrep --color=auto'
      alias egrep='egrep --color=auto'
  fi

# ls aliases
    alias ll='ls -AlF'
    alias la='ls -A'
    alias l='ls -CF'

# History
HISTFILE=~/.cache/zsh/history
HISTSIZE=1000
SAVEHIST=1000

fpath+=~/.zfunc

# Basic auto/tab completion
autoload -Uz compinit
zstyle ':completion:*' menu select
# case-insensitive autocompletion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
# zle -N zle-keymaphip init zsh)"-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

autoload -Uz promptinit
promptinit

# gpg pinentry
export GPG_TTY=$(tty)

SSH_ENV="$HOME/.ssh/agent-environment"

# plugins=(git)

# syntax highlighting
if [ -d "/usr/share/zsh/plugins/zsh-syntax-highlighting" ]; then
	source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# add .local/bin to PATH for pip executables
export PATH=~/.local/bin:$PATH

# Load aliases
. $HOME/.config/shell/aliases.sh

# Load environment
. $HOME/.config/shell/environment.sh

# Add to path
export PATH=~/.config-files/scripts:$PATH

# Starship prompt
eval "$(starship init zsh)"