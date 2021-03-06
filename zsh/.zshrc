# Switch Ctrl and Caplocks
# usr/bin/setxkbmap -option "ctrl:swapcaps"

# oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh
ZSH_THEME='bureau'

# oh-my-zsh plugins
PRODUCTIVITY=(colorize command-not-found)
BUILD=(bower docker git vagrant)
NODEJS=(node nvm bower)
RUBY=(ruby gem)
PYTHON=(pip python)
DISTRO=(systemd)

plugins=($PRODUCTIVITY $BUILD $NODEJS $PYTHON $DISTRO)

# oh-my-zsh
if [ -f $ZSH/oh-my-zsh.sh ]; then
    source "$ZSH/oh-my-zsh.sh"
fi

# nvm
if [ -f $HOME/.nvm/nvm.sh ]; then
    source "$HOME/.nvm/nvm.sh"
    nvm use stable
fi

# alias
command -v python3 >/dev/null && alias pip3='python3 -m pip'
command -v git >/dev/null && \
alias gpull="git pull origin $(git branch | grep \* | cut -d ' ' -f2)" && \
alias gpush="git push origin $(git branch | grep \* | cut -d ' ' -f2)"
