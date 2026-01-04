# .bashrc

# completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
fi
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source "$HOME/dotfiles/scripts/bash-prompt.sh"

# eval "$(starship init bash)"
export TERMINAL=alacritty

source "$HOME/.cargo/env"
source "$HOME/.bash_aliases"
export PATH="$HOME/.local/bin:$PATH"
