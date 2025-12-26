#!/usr/bin/env bash

# -------------------------
# Colors (ANSI)
# -------------------------
RESET="\[\e[0m\]"

# Directory box
DIR="\[\e[37;40m\]"
END_DIR="\[\e[30m\]"

# Git branch box
GIT="\[\e[34;40m\]"
END_GIT="\[\e[30m\]"

# Python virtualenv box
PY_ENV="\[\e[30;42m\]"    # black on green
END_PY="\[\e[30m\]"

# Success/error symbols
SYMBOL_OK="󰆧"
SYMBOL_ERR="󰯈"

# -------------------------
# Helper functions
# -------------------------

short_pwd() {
        local pwd="${PWD/#$HOME/~}"
        IFS='/' read -ra parts <<< "$pwd"

        local out=""
        local last_index=$((${#parts[@]} - 1))

                for i in "${!parts[@]}"; do
                        if (( i == 0 || i == last_index )); then
                                out+="/${parts[i]}"
                        else
                                out+="/${parts[i]:0:3}"
                        fi
                done

                echo "${out#/}"
        }

git_branch() {
        git rev-parse --abbrev-ref HEAD 2>/dev/null
}

python_venv() {
        if [[ -n "$VIRTUAL_ENV" ]]; then
                echo "$(basename "$VIRTUAL_ENV")"
        fi
}

battery_status() {
        if command -v upower >/dev/null; then
                local battery=$(upower -i $(upower -e | grep BAT) 2>/dev/null)
                local percent=$(echo "$battery" | awk '/percentage:/ {print $2}')
                echo "$percent"
        fi
}

# -------------------------
# Main prompt builder
# -------------------------
custom_prompt() {
        local exit_code=$?
        local symbol="${SYMBOL_OK}"
        [[ $exit_code -ne 0 ]] && symbol="${SYMBOL_ERR}"

        # Directory box
        local dir_box="${END_DIR}${DIR}$(short_pwd)${RESET}${END_DIR}${RESET}"

        # Git box
        local git=$(git_branch)
        local git_box=""
        if [[ -n "$git" ]]; then
                # append symbols after branch name
                git_box=" ${END_GIT}${GIT} $git"
                git_box+="${RESET}${END_GIT}${RESET}"
        fi

        # Python virtualenv box
        local py=$(python_venv)
        local py_box=""
        [[ -n "$py" ]] && py_box=" ${END_PY}${PY_ENV}  $py ${RESET}${END_PY}${RESET}"

        # Assemble final PS1
        PS1="\n${dir_box}${git_box}${py_box}${rust_box} ${symbol} "
}

# -------------------------
# Export PS1 via PROMPT_COMMAND
# -------------------------
PROMPT_COMMAND=custom_prompt
