set -o vi

alias sc='cat ~/.ssh/config'

complete -f -d -W "$(grep '[Hh]ost ' ~/.ssh/config | grep -v '*' | awk '{print $2}')" ssh scp

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

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

# *** terminal color settings start ***

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
	xterm*|rxvt*)
		PS1="\\[\\e]0;${debian_chroot:+($debian_chroot)}\\u@\\h: \\w\\a\\]$PS1"
		;;
	*)
		;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	# shellcheck disable=SC2015
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# *** terminal color settings end***
