set -o vi

#alias sc='cat ~/.ssh/config'
alias gs='git status' 
alias gl='git log --all --decorate --oneline --graph'
alias gll='git log'
alias c='clear'
alias sv='source Documents/venv/env/bin/activate' #source venv
alias sb='source ~/.bash_profile' #source bash profile
alias ob='vim ~/.bash_profile' #open bash profile
alias ov='vim ~/.vimrc' #open vim config
alias os='vim ~/.ssh/config' #open ssh config
alias ..='cd ..'
alias ...='cd ../..'
alias c='cheat' #quick access to cheat function

#[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

complete -f -d -W "$(grep '[Hh]ost ' ~/.ssh/config | grep -v '*' | awk '{print $2}')" ssh scp

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;
		# nocaseglob notes
		# cd foo*
		# will change to the Foobar directory (assuming there is no other match), if you've set the nocaseglob option.

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;
		# cdspell notes
		# cd /etc/mall
		#-bash: cd: /etc/mall: No such file or directory
		#
		# shopt -s cdspell
		#
		# cd /etc/mall
		#
		# pwd
		#/etc/mail
		#
		#[Note: By mistake, when I typed mall instead of mail,
		#          cd corrected it automatically]

# Autocorrect on directory names to match a glob.
shopt -s dirspell 2> /dev/null

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

# highlighting inside manpages and elsewhere
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

export CLICOLOR=1

## *** terminal color settings start ***
#
## set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#	xterm-color) color_prompt=yes;;
#esac
#
## uncomment for a colored prompt, if the terminal has the capability; turned
## off by default to not distract the user: the focus in a terminal window
## should be on the output of commands, not on the prompt
#force_color_prompt=yes
#
#if [ -n "$force_color_prompt" ]; then
#	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
#		# We have color support; assume it's compliant with Ecma-48
#		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
#		# a case would tend to support setf rather than setaf.)
#		color_prompt=yes
#	else
#		color_prompt=
#	fi
#fi
#
#if [ "$color_prompt" = yes ]; then
###	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#	PS1='${debian_chroot:+($debian_chroot)}\[\e[01;94m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$ '
#else
#	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#
#unset color_prompt force_color_prompt
#
## If this is an xterm set the title to user@host:dir
#case "$TERM" in
#	xterm*|rxvt*)
#		PS1="\\[\\e]0;${debian_chroot:+($debian_chroot)}\\u@\\h: \\w\\a\\]$PS1"
#		;;
#	*)
#		;;
#esac
#
## *** terminal color settings end***

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
export HISTTIMEFORMAT='%F %T '

# keep history up to date, across sessions, in realtime
#  http://unix.stackexchange.com/a/48113
export HISTCONTROL="ignoredups"       # no duplicate entries, but keep space-prefixed commands
export HISTSIZE=100000                          # big big history (default is 500)
export HISTFILESIZE=$HISTSIZE                   # big big history
type shopt &> /dev/null && shopt -s histappend  # append to history, don't overwrite it

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Save multi-line commands as one command
shopt -s cmdhist

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Git autocompletion feature at command line
# https://apple.stackexchange.com/questions/55875/git-auto-complete-for-branches-at-the-command-line
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

#
# If we're connecting via SSH then the prompt will show the username.
#
#if [ -n "$SSH_CONNECTION" ]; then
#
#    #
#    # Remote.
#    #
#    export PS1='\[\033[01;31m\]\u\[\033[01;33m\]@\[\033[01;36m\]\h \[\033[01;33m\]\w \[\033[01;35m\]\$ \[\033[00m\]'
#
#else
#
#    #
#    # Local.
#    #
    export PS1='\[\033[01;36m\]\h \[\033[01;33m\]\w \[\033[01;35m\]\$ \[\033[00m\]'
#
#fi

# show colored output for grep, fgrep or egrep commands"

if echo x | grep --color=auto x >/dev/null 2>&1; then
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# Required setting for autojump. 
# https://github.com/wting/autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# cheat function very similar to tldr.
# https://news.ycombinator.com/item?id=18898523
# Example : # cheat tar . This will be similar to 'tldr tar'. Output will help you by providing quick and common usage of the command.

function cheat() {
      curl cht.sh/$1
  }
