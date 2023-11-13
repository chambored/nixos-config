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

alias upcon="updateConfigs.sh"
alias tidyhere="./tidy_all.sh"
alias feh="feh -."
alias bruno='appimage-run ~/data/appimages/bruno_1.1.0_x86_64_linux.AppImage'
export GPG_TTY=$(tty)
export PATH="$HOME/data/.cfg/scripts:$PATH"

export HISTCONTROL=ignoreboth:erasedups
shopt -s histappend

join() {
    if [[ $# -ne 2 ]]; then
        echo "Usage: join <network_name> <password>"
        return 1
    fi
    
    local ssid="$1"
    local password="$2"

    sudo nmcli device wifi connect "$ssid" password "$password"
}
