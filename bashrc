# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# First install ncurses-term to get expanded terminal settings
# if 256 version exist, change Term to 256colors
if [ -e /lib/terminfo/x/xterm-256color ]; then
	export TERM='xterm-256color'
else
	export TERM='xterm-color'
fi


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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
    #PS1='\[`[ $? = 0 ] && X=2 || X=1; tput setaf $X`\]\h\[`tput sgr0`\]:$PWD\n\$ '
    #PS1='\u@\h $(pwd | sed "s@^/home/krg85/stackoverflow/\?@@")\$ '
else
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    export MYPS='$(echo -n "${PWD/#$HOME/~}" | awk -F "/" '"'"'{
    if (length($0) > 14) { if (NF>4) print $1 "/" $2 "/.../" $(NF-1) "/" $NF;
    else if (NF>3) print $1 "/" $2 "/.../" $NF;
    else print $1 "/.../" $NF; }
    else print $0;}'"'"')'
    PS1='$(eval "echo ${MYPS}")$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || \
        eval "$(dircolors -b)"
    [ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
    [ -e "$DIR_COLORS" ] || DIR_COLORS=""
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || \
    echo error)" "$(history|tail -n1| \
    sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


MACHTYPE=x86_64
export MACHTYPE

VCFTOOLS=/home/escott/Packages/vcftools_0.1.12a/bin
#export PPH=/home/escott/Packages/pph
#POLYPHEN=$PPH/bin
BLAT=/home/escott/bin/x86_64
SBIN=/sbin
USERSBIN=/usr/sbin
export JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
JAVA=$JAVA_HOME/bin
PICARD=/home/escott/Packages/picard-tools-1.96
MSMS=/home/escott/Packages/msms/bin
BEDTOOLS=/home/escott/Packages/bedtools2/bin
BEAGLE=/home/escott/Packages/Beagle
IMAGEJ=/home/escott/Packages/ImageJ
MERLIN=/home/escott/Packages/merlin-1.1.2/executables
CIRCOS=/home/escott/Packages/ciros-0.66/bin
FSuite=/home/escott/Packages/FSuite_1.0.2/FSuite
EIGENSOFT=/home/escott/Packages/EIG5.0.2/bin
HAPMIX=/home/escott/Packages/HapmixRelease/bin
ANNOVAR=/home/escott/Packages/annovar/
RVMBIN=$HOME/.rvm/bin
STARALN=/home/escott/workspace/mboat7/packages/STAR-STAR_2.4.2a/source
SRATOOLS=/home/escott/Packages/sratoolkit/sratoolkit.2.5.4-1-ubuntu64/bin
VCFLIB=/home/escott/Packages/vcflib/bin

export PATH=$VCFTOOLS:$VCFLIB:$STARANL:$SRATOOLS:$BEDTOOLS:$BEAGLE:$BLAT:$JAVA:$PICARD:$MSMS:$IMAGEJ:$MERLIN:$CIRCOS:$FSuite:$EIGENSOFT:$ANNOVAR:$RVMBIN:$SBIN:$USERSBIN:$PATH

#export PERL5LIB=/usr/lib/perl5/site_perl/5.14.2/Vcf
export PERL5LIB=/home/escott/Packages/vcftools_0.1.12a/perl/

export LD_LIBRARY_PATH=$HOME/lib:$LD_LIBRARY_PATH

export PKG_CONFIG_PATH=$HOME/lib/pkgconfig:$PKG_CONFIG_PATH

source /home/escott/.rvm/scripts/rvm

