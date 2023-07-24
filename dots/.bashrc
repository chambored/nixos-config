# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ip='ip --color=auto'
alias l='command ls -Av1h --color=always --time-style=long-iso --group-directories-first'

    # -A: show all, including dotfiles, except . and ..
    # -v: natural sort of number
    # -1 (one): list (use -l for long version)
    # -h: human-readable sizes

    alias rm='command rm -Iv'

    # -I: prompt once before removing more than three files or recursively
    # -v: verbose
PS1='[\u@\h \W]\$ '

alias upcon="./updateConfigs.sh"

export GPG_TTY=$(tty)
