
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

unset MAILCHECK