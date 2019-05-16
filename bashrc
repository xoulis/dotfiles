#
# ~/.bashrc
#

[[ $- != *i* ]] && return

colors() {
        local fgc bgc vals seq0

        printf "Color escapes are %s\n" '\e[${value};...;${value}m'
        printf "Values 30..37 are \e[33mforeground colors\e[m\n"
        printf "Values 40..47 are \e[43mbackground colors\e[m\n"
        printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

        # foreground colors
        for fgc in {30..37}; do
                # background colors
                for bgc in {40..47}; do
                        fgc=${fgc#37} # white
                        bgc=${bgc#40} # black

                        vals="${fgc:+$fgc;}${bgc}"
                        vals=${vals%%;}

                        seq0="${vals:+\e[${vals}m}"
                        printf "  %-9s" "${seq0:-(default)}"
                        printf " ${seq0}TEXT\e[m"
                        printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
                done
                echo; echo
        done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Change the window title of X terminals
case ${TERM} in
        xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
                PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
                ;;
        screen*)
                PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
                ;;
esac

use_color=true
# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
        && type -P dircolors >/dev/null \
        && match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
        # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
        if type -P dircolors >/dev/null ; then
                if [[ -f ~/.dir_colors ]] ; then
                        eval $(dircolors -b ~/.dir_colors)
                elif [[ -f /etc/DIR_COLORS ]] ; then
                        eval $(dircolors -b /etc/DIR_COLORS)
                fi
        fi

        if [[ ${EUID} == 0 ]] ; then
                PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
        else
                PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
        fi

        alias ls='ls --color=auto'
        alias grep='grep --colour=auto'
        alias egrep='egrep --colour=auto'
        alias fgrep='fgrep --colour=auto'
else
        if [[ ${EUID} == 0 ]] ; then
                # show root@ when we don't have colors
                PS1='\u@\h \W \$ '
        else
                PS1='\u@\h \w \$ '
        fi
fi

unset use_color safe_term match_lhs sh

xhost +local:root > /dev/null 2>&1

complete -cf sudo

shopt -s cdspell
shopt -s checkwinsize
shopt -s cmdhist
shopt -s dotglob
shopt -s expand_aliases
shopt -s extglob
shopt -s histappend
shopt -s hostcomplete

##Set vi mode
set -o vi
## Exports
export HISTSIZE=10000
export HISTFILESIZE=${HISTSIZE}
export HISTCONTROL=ignoreboth
export JAVA_FONTS=/usr/share/fonts/TTF
export EDITOR=/usr/bin/vim
export MSF_DATABASE_CONFIG=~/.msf4/database.yml

## Aliases
alias ls='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano PKGBUILD'
alias fixit='sudo rm -f /var/lib/pacman/db.lck && sudo pacman-mirrors -g && sudo pacman -Syyuu  && 
sudo pacman -Suu'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias gw='gcalcli calw -w 20 --military'
alias ga='gcalcli quick'
alias gd='gcalcli delete'
#alias msfconsole="msfconsole --quiet -x \"db_connect ${USER}@msf\"" 	#metasploit
alias switchnv='optimus-manager --no-confirm --switch nvidia'
alias switchin='optimus-manager --no-confirm --switch intel'
# ex - archive extractor
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

## prompt
PS1='[\u@\h \W]\$ '

## 24h Time Format
export LC_TIME="C"

## better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"

## thefuck
#eval $(thefuck --alias)

###POWERLINE
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh
## Screenfetch
neofetch
export PATH=/bin/lscript:/bin/lscript:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/var/lib/snapd/snap/bin:/home/xoulis/.gem/ruby/2.5.0/bin:/home/xoulis/Applications/Scripts

### Weather
alias weather='curl wttr.in/her'
alias moon='curl wttr.in/Moon'

### Autojump
source /usr/share/autojump/autojump.bash

### Odt to PDF
alias topdf='libreoffice --headless --convert-to pdf'

###fzf
source /usr/share/fzf/completion.bash && source /usr/share/fzf/key-bindings.bash
# When selecting files with fzf, we show file content with syntax highlighting,
# or without highlighting if it's not a source file. If the file is a directory,
# we use tree to show the directory's contents.
# We only load the first 200 lines of the file which enables fast previews
# of large text files.
# Requires highlight and tree: pacman -S highlight tree
export FZF_DEFAULT_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null ||
cat {} || tree -C {}) 2> /dev/null | head -200'"
#Path completion
#use zathura for opening pdf
#complete -o bashdefault -o default -F _fzf_path_completion zathura

