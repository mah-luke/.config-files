
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
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/frank/.zshrc'

autoload -Uz promptinit
promptinit
# End of lines added by compinstall


# alias
# source "$XDG_CONFIG_HOME/zsh/aliasrc"

# gpg pinentry
export GPG_TTY=$(tty)

# ssh-agent
#if ! pgrep -u "$USER" ssh-agent > /dev/null; then
#    ssh-agent -t 24h > "$XDG_RUNTIME_DIR/ssh-agent.env"
#fi
#if [[ ! "$SSH_AUTH_SOCK" ]]; then
#    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
#fi

#SSH_ENV="$HOME/.ssh/agent-environment"

#function start_agent {
#    echo "Initialising new SSH agent..."
#    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
#    echo succeeded
#    chmod 600 "${SSH_ENV}"
#    . "${SSH_ENV}" > /dev/null
#    /usr/bin/ssh-add;
#}

# Source SSH settings, if applicable

#if [ -f "${SSH_ENV}" ]; then
#    . "${SSH_ENV}" > /dev/null
#    #ps ${SSH_AGENT_PID} doesn't work under cywgin
#    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
#        start_agent;
#    }
#else
#    start_agent;
#fi


# syntax highlighting
if [ -d "/usr/share/zsh-syntax-highlighting" ]; then
	source "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# Load aliases
. $HOME/.config/shell/aliases.sh

# Load environment
. $HOME/.config/shell/environment.sh

# Starship prompt
eval "$(starship init zsh)"