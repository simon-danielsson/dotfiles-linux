alias ls='eza -la --icons --header --sort time --no-permissions --total-size'
alias in='sudo xbps-install -Syu'
alias re='sudo xbps-remove -R'
alias v='nvim'
alias date='date'
alias notes="cd ~/notes"
alias sbash="source ~/.bashrc"
alias dev="cd ~/dev"
alias pass="~/dotfiles/executables/passgen --quiet"
alias anna="~/dotfiles/executables/anna --quiet"
alias timer="~/dotfiles/scripts/timer.sh"
alias emoji="~/dotfiles/scripts/emoji-picker.sh"
alias devicon="~/dotfiles/scripts/devicon-picker.sh"
alias ff="cd && clear && fastfetch"

# nvim version using bob (nightly | stable)
alias nvim="bob run nightly"

# open in eog
img() {
        command eog "$@" >/dev/null 2>&1 &
}

gcommit() {
        git add --all &&
                git commit -m "$*"
        }

gpush() {
        git add --all &&
                git commit -m "$*" &&
                git push
        }

# open in files
files() {
        command pcmanfm "$@" >/dev/null 2>&1 &
}

# create and enter dir
mkcd() {
        mkdir -p "$1" && cd "$1"
}

# cd and ls
cl() {
        cd "$1" &
        sleep 0.1
        ls "$1"
}

# add to clipboard (example: 'ls ~ | clip')
clip() {
        xclip -selection clipboard
}

# search processes
psg() {
        ps aux | grep -i "$1" | grep -v grep
}

# extract archive
extract() {
        [ -f "$1" ] || { echo "file not found"; return 1; }
        case "$1" in
                *.tar.bz2) tar xjf "$1" ;;
                *.tar.gz)  tar xzf "$1" ;;
                *.tar.xz)  tar xJf "$1" ;;
                *.bz2)     bunzip2 "$1" ;;
                *.gz)      gunzip "$1" ;;
                *.xz)      unxz "$1" ;;
                *.zip)     unzip "$1" ;;
                *.7z)      7z x "$1" ;;
                *.rar)     unrar x "$1" ;;
                *) echo "cannot extract '$1'" ;;
        esac
}

# get dictionary definition of word with "dict" using "d"
unalias d 2>/dev/null
d() {
        if [ -z "$1" ]; then
                echo "Usage: define <word>"
                return 1
        fi
        dict -C "$1" | less
}

# terminate nvim, tmux and ultimately alacritty using "q"
unalias q 2>/dev/null
q() {
        pkill nvim
        tmux kill-session
        exit
}

# quickly create markdown notes with "n" followed by note title
unalias n 2>/dev/null
n() {
        local name="$*"
        today=$(date "+%Y-%m-%d")
        local dir="$HOME/notes"
        if [ -z "$name" ]; then
                name="note"
        fi
        name=$(echo "$name" | xargs | tr -s ' ' '-' | sed 's/-$//' | tr '[:upper:]' '[:lower:]')
        local file="$dir/${name}_${today}.md"
        mkdir -p "$dir"
        [ -f "$file" ] || touch "$file"
        nvim "$file"
}

# Local search from current directory
unalias s 2>/dev/null
s() {
        local target
        target=$(fd --type f --type d --hidden | fzf --preview='[[ -d {} ]] && eza -al --color=always {} || bat --style=numbers --color=always {}') || return
        if [[ -d $target ]]; then
                cd "$target"

        elif [[ -f $target ]]; then
                if [[ $target == *.AppImage ]]; then
                        chmod +x "$target" 2>/dev/null
                        "$target" & disown
                else
                        nvim "$target"
                fi
        fi
}

# Global search from home directory
unalias ss 2>/dev/null
ss() {
        local target
        target=$(fd --type f --type d --hidden . ~ | \
                fzf --preview='[[ -d {} ]] && eza -al --color=always {} || bat --style=numbers --color=always {}') || return

        if [[ -d $target ]]; then
                cd "$target"

        elif [[ -f $target ]]; then
                if [[ $target == *.AppImage ]]; then
                        chmod +x "$target" 2>/dev/null
                        "$target" & disown
                else
                        nvim "$target"
                fi
        fi
}

