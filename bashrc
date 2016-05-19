
# Only if running interactively
if [[ -n "$PS1" ]]
then

    # don't put duplicate lines or lines starting with space in the history.
    HISTCONTROL=ignoreboth

    # append to the history file, don't overwrite it
    shopt -s histappend

    # history size
    HISTSIZE=20000
    HISTFILESIZE=60000

    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
    shopt -s checkwinsize

    if ! shopt -oq posix; then
      if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
      elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
      fi
    fi
 

    # Colours and aliases for ls.
    if [[ -x /usr/bin/dircolors ]]
    then
        eval $(dircolors -b)
        alias ls='ls --color=auto'
        alias dir='ls --color=auto --format=vertical'
        alias ll="ls --color=auto -lart"
    fi

    # set a fancy prompt
    if [[ "$UID" == "0" ]]
    then
        # root - red
        __pscolor=31
    else
        case $HOSTNAME in
        pocky|twirl|toblerone)
            # laptops - green
            __pscolor=32
            ;;
        kitkat|mars|pc????)
            # desktops - yellow
            __pscolor=33
            ;;
        mars-*|toblerone-*|pc????-*)
            # virtual machines - cyan
            __pscolor=36
            ;;
        *)
            # default (servers) - magenta
            __pscolor=35
            ;;
        esac
    fi

    PROMPT_COMMAND="__rc=\$?;echo;"
    PROMPT_COMMAND+="[[ \$__rc -eq 0 ]] || echo -n -e '\e[31;1m'\$__rc' \e[0m';"
    PROMPT_COMMAND+="echo -n -e '\e[$__pscolor;1m'\$USER@\${HOSTNAME%%.*}' \e[34;1m'\${PWD/\$HOME/\\~}'\e[0m';"
    if [[ $(type -t __git_ps1) == 'function' ]]
    then
      PROMPT_COMMAND+="echo -n -e '\e[36m'\$(__git_ps1)'\e[0m';"
    fi
    case "$TERM" in
    xterm*|rxvt*)
       PROMPT_COMMAND+="echo -n -e '\e]0;'\${HOSTNAME%%.*}':'\${PWD/\$HOME/\\~}'\a';"
       ;;
    esac
    PROMPT_COMMAND+="echo;"
    export PROMPT_COMMAND

    export PS1='\[\e[34;1m\]\$ \[\e[37;0m\]'

    unset __pscolor

    alias dosvim='vim -c "set ff=dos"'
    alias kp='kpcli --kdb=/home/mark/Dropbox/KeePass/keepass.kdb'

    for __aliasfile in $HOME/.bash_aliases $HOME/.bash_aliases_local
    do
        if [[ -f $__aliasfile ]]
        then
            . $__aliasfile
        fi
    done
fi


upto ()
{
    if [ -z "$1" ]; then
        return
    fi
    local newpath=$1
    local upto=${newpath%%/*}
    cd "${PWD/\/$upto\/*//$newpath}"
}

_upto()
{
    local newpath=${COMP_WORDS[COMP_CWORD]}
    local upto=${newpath%%/*}
    local subpath=${newpath#*/}
    if [[ "$subpath" = "$newpath" ]]
    then
      local d=${PWD//\//\ }
      COMPREPLY=( $( compgen -S / -W "$d" -- "$upto" ) )
    else
      local b="${PWD/\/$upto\/*//$upto}"
      COMPREPLY=( $( cd $b && compgen -P "$upto/" -S / -d "$subpath" ) )
    fi
}
complete -o nospace -F _upto upto

jd(){
    if [ -z "$1" ]; then
        echo "Usage: jd [directory]";
        return 1
    else
        cd $(find . -type d | /bin/grep "/$1\$")
    fi
}

_jd()
{
  local cur=${COMP_WORDS[COMP_CWORD]}
  local d=$(find . -name '.git' -prune -o -type d -print | sed 's/.*\///' | sort | uniq -u | less)
  COMPREPLY=( $( compgen -W "$d" -- "$cur" ) )
}
complete -F _jd jd

ui()
{
  cd $HOME/icp/$1
}

unset MAILCHECK
