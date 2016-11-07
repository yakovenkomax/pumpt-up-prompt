# Add aliases if present
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# Charset global fixes
export LANG="UTF-8"
export LESSCHARSET=utf-8

# Git completion and prompt plugins:
# https://github.com/git/git/tree/master/contrib/completion
source ~/.git-completion.bash
source ~/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1

# Special symbols
# Requires Menlo for Powerline font:
# https://github.com/abertsch/Menlo-for-Powerline
SYM_BRANCH=""
SYM_SEPARATOR=""

# Colors array
colors=("black" "red" "green" "yellow" "blue" "magenta" "cyan" "white" "default" "reset")
# Color codes arrays
fg_colors=("\[\e[0;30m\]" "\[\e[0;31m\]" "\[\e[0;32m\]" "\[\e[0;33m\]" "\[\e[0;34m\]" "\[\e[0;35m\]" "\[\e[0;36m\]" "\[\e[0;37m\]" "\[\e[0;39m\]" "\[\e[0m\]")
bg_colors=("\[\e[40m\]" "\[\e[41m\]" "\[\e[42m\]" "\[\e[43m\]" "\[\e[44m\]" "\[\e[45m\]" "\[\e[46m\]" "\[\e[47m\]" "\[\e[49m\]" "\[\e[0m\]")

# Color getters
# Ex.: fg black
# Ex.: bg yellow
fg() {
    echo ${fg_colors[$(get_index colors $1)]}
}
bg() {
    echo ${bg_colors[$(get_index colors $1)]}
}

# Get item index from an array
# Ex.: get_index array_name item_value
get_index() {
    array_name=$1[@]
    array=("${!array_name}")
    value=$2

    for i in ${!array[@]}; do
        if [[ ${array[$i]} = $value ]]; then
            echo "${i}";
        fi
    done
}

# Separator generation
# Ex.: separator bg_color next_bg_color
separator() {
    if [[ -z "$2" ]]; then
        echo $(bg reset)$(fg $1)$SYM_SEPARATOR
    else
        echo $(bg $1)$(fg $2)$SYM_SEPARATOR
    fi
}

# Prompt line generation
generate_prompt() {
    # Settings
    # is enabled | part generation function | foreground color | background color
    virtualenv_part_settings=(true virtualenv_part black magenta)
    dir_part_settings=(true dir_part black blue)
    git_part_settings=(true git_part black yellow)

    # Parts settings array (change parts order here)
    settings=(virtualenv_part_settings dir_part_settings git_part_settings)

    # Current directory part
    dir_part="\w"

    # Git branch part
    git_part=""
    GIT_PROMPT=$(__git_ps1 " %s")
    if [[ -n $GIT_PROMPT ]]; then
        git_part=$SYM_BRANCH$GIT_PROMPT
    fi

    # Python virtual environment part
    virtualenv_part=""
    if [[ -n $VIRTUAL_ENV ]]; then
       virtualenv_part=$(basename $VIRTUAL_ENV)
    fi

    # Filter enabled nonempty parts
    enabled_parts=""
    for i in ${!settings[@]}; do
        part=${settings[$i]}
        part_name=$part[@]
        part_settings=("${!part_name}")
        part_value=${!part_settings[1]}

        if [[ ${part_settings[0]} = true && -n $part_value ]]; then
            enabled_parts+=${settings[$i]}" "
        fi
    done
    enabled_parts=($enabled_parts)

    # Generate prompt string
    PS1=""
    for i in ${!enabled_parts[@]}; do
        part=${enabled_parts[$i]}
        part_name=$part[@]
        part_settings=("${!part_name}")
        part_value=${!part_settings[1]}
        fg_color=${part_settings[2]}
        bg_color=${part_settings[3]}

        # Append part content
        PS1+=$(fg $fg_color)$(bg $bg_color)" "$part_value" "

        # Check if current part is last
        if [[ $(($i + 1)) -lt ${#enabled_parts[@]} ]]; then
            next_part=${enabled_parts[$(($i + 1))]}
            next_part_name=$next_part[@]
            next_part_settings=("${!next_part_name}")
            next_bg_color=${next_part_settings[3]}
        else
            next_bg_color=default
        fi

        # Append separator
        PS1+=$(separator $bg_color $next_bg_color)
    done

    # Check if empty
    if [[ -z "$PS1" ]]; then
        PS1+=$(separator default)
    fi

    # Reset colors and add space in the end
    PS1+=$(fg reset)" "
}
PROMPT_COMMAND=generate_prompt
