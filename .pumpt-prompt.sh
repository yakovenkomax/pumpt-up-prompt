# A pumped shell prompt.
# https://github.com/yakovenkomax/pumpt-prompt

##################################
#            Settings
##################################

# is enabled | part generation function name | foreground color | background color
time_part_settings=(false time_part white black)
dir_part_settings=(true dir_part black blue)
git_part_settings=(true git_part black yellow)
venv_part_settings=(true venv_part black magenta)
ssh_part_settings=(true ssh_part black white)
screen_part_settings=(true screen_part black blue)

# Icons
    # Separator symbols
    SYM_SEPARATOR=""
    SYM_SEPARATOR_THIN=""
    # Separator symbols with reduced height
    # SYM_SEPARATOR=""
    # SYM_SEPARATOR_THIN=""
    # Branch symbol
    SYM_BRANCH=""


# Parts settings array (change parts order here)
settings=(time_part_settings ssh_part_settings screen_part_settings venv_part_settings dir_part_settings git_part_settings)


##################################
#             Colors
##################################

# Colors
colors=("black" "red" "green" "yellow" "blue" "magenta" "cyan" "white" "default" "reset")
# Color codes
fg_colors=("\[\e[0;30m\]" "\[\e[0;31m\]" "\[\e[0;32m\]" "\[\e[0;33m\]" "\[\e[0;34m\]" "\[\e[0;35m\]" "\[\e[0;36m\]" "\[\e[0;37m\]" "\[\e[0;39m\]" "\[\e[0m\]")
bg_colors=("\[\e[40m\]" "\[\e[41m\]" "\[\e[42m\]" "\[\e[43m\]" "\[\e[44m\]" "\[\e[45m\]" "\[\e[46m\]" "\[\e[47m\]" "\[\e[49m\]" "\[\e[0m\]")

# Color -> code translation functions
#   Ex.: fg black
#   Ex.: bg yellow
fg() {
    echo ${fg_colors[$(get_index colors $1)]}
}
bg() {
    echo ${bg_colors[$(get_index colors $1)]}
}


##################################
#            Helpers
##################################

# Get item index from an array helper
#   Ex.: get_index myArray myItemName
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

# Separator generation function
#   Ex.: separator bg_color [next_bg_color]
separator() {
    if [[ $# -eq 1 ]]; then
        echo $(bg reset)$(fg $1)$SYM_SEPARATOR
    else
        if [[ "$1" == "$2" ]]; then
            echo $(fg "black")$(bg $2)$SYM_SEPARATOR_THIN
        else
            echo $(fg $1)$(bg $2)$SYM_SEPARATOR
        fi
    fi
}


##################################
#          Main function
##################################

generate_prompt() {

    ##################################
    #    Parts generation functions
    ##################################

    # Time part
    time_part=""
    time_part() {
        time_part=$(date +"%T")
    }

    # Current directory part
    dir_part=""
    dir_part() {
        dir_part="\w"
    }

    # Git branch part
    git_part=""
    git_part() {
        # Git completion and prompt:
        #   Requires git prompt and completion plugins:
        #   https://github.com/git/git/tree/master/contrib/completion
        source ~/.git-completion.bash
        source ~/.git-prompt.sh

        # Settings
        GIT_PS1_SHOWDIRTYSTATE=1

        GIT_PROMPT=$(__git_ps1 " %s")
        if [[ -n $GIT_PROMPT ]]; then
            git_part=$SYM_BRANCH$GIT_PROMPT
        fi
    }

    # Python virtual environment part
    venv_part=""
    venv_part() {
        if [[ -n $VIRTUAL_ENV ]]; then
           venv_part=$(basename $VIRTUAL_ENV)
        fi
    }

    # SSH part
    ssh_part=""
    ssh_part() {
        if [[ "$SSH_CONNECTION" && "$SSH_TTY" == $(tty) ]]; then
            ssh_user=$(id -un)
            ssh_host=$(hostname)
            ssh_part="${ssh_user}@${ssh_host}"
        fi
    }

    # Screen part
    screen_part=""
    screen_part() {
        if [[ -n $STY ]]; then
            screen_part=$STY
        fi
    }


    ##################################
    #         Parts filtering
    ##################################

    enabled_parts=""
    for i in ${!settings[@]}; do
        part=${settings[$i]}
        part_name=$part[@]
        part_settings=("${!part_name}")

        if [[ ${part_settings[0]} = true ]]; then
            # Call the part generation function
            eval ${part_settings[1]}
            part_value=${!part_settings[1]}

            if [[ -n $part_value ]]; then
                enabled_parts+=${settings[$i]}" "
            fi
        fi
    done
    enabled_parts=($enabled_parts)


    ##################################
    #       Parts concatenation
    ##################################

    PS1=""
    for i in ${!enabled_parts[@]}; do
        part=${enabled_parts[$i]}
        part_name=$part[@]
        part_settings=("${!part_name}")
        part_value=${!part_settings[1]}
        fg_color=${part_settings[2]}
        bg_color=${part_settings[3]}

        # Append part content to the prompt string
        PS1+=$(fg $fg_color)$(bg $bg_color)" "$part_value" "

        # Check if the current part is the last
        if [[ $(($i + 1)) -lt ${#enabled_parts[@]} ]]; then
            next_part=${enabled_parts[$(($i + 1))]}
            next_part_name=$next_part[@]
            next_part_settings=("${!next_part_name}")
            next_bg_color=${next_part_settings[3]}
            # Append a separator
            PS1+=$(separator $bg_color $next_bg_color)
        else
            # Append a separator
            PS1+=$(separator $bg_color)
        fi
    done

    # Check if the prompt string is empty
    if [[ -z "$PS1" ]]; then
        PS1+=$(separator default)
    fi

    # Reset colors and append a space in the end
    PS1+=$(fg reset)" "
}
PROMPT_COMMAND=generate_prompt
