# A pumped shell prompt.
# https://github.com/yakovenkomax/pumpt-prompt

##################################
#             Icons
##################################
    # Separator symbols
    SYM_SEPARATOR=""
    SYM_SEPARATOR_THIN=""
    # Separator symbols with reduced height
    # SYM_SEPARATOR=""
    # SYM_SEPARATOR_THIN=""
    # Branch symbol
    SYM_TIME=""
    SYM_USER=""
    SYM_DIR=""
    SYM_GIT=""
    SYM_VENV=""
    SYM_SSH=""
    SYM_SCREEN=""


##################################
#            Settings
##################################

# Segments settings      segment function | is enabled | has icon | icon symbol | foreground | background
time_segment_settings=(  time_segment       false        false      "$SYM_TIME"   white        black)
user_segment_settings=(  user_segment       false        false      "$SYM_USER"   black        blue)
dir_segment_settings=(   dir_segment        true         false      "$SYM_DIR"    black        blue)
git_segment_settings=(   git_segment        true         true       "$SYM_GIT"    black        yellow)
venv_segment_settings=(  venv_segment       true         false      "$SYM_VENV"   black        magenta)
ssh_segment_settings=(   ssh_segment        true         false      "$SYM_SSH"    black        white)
screen_segment_settings=(screen_segment     true         false      "$SYM_SCREEN" black        blue)

# Segments settings array (change segments order here)
settings=(time_segment_settings ssh_segment_settings screen_segment_settings venv_segment_settings user_segment_settings dir_segment_settings git_segment_settings)


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
        [[ ${array[$i]} = $value ]] && echo "${i}"
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
    #       Segments generation
    ##################################

    # Time segment
    time_segment=""
    time_segment() {
        time_segment=$(date +"%T")
    }

    # Current user segment
    user_segment=""
    user_segment() {
        user_segment="\u"
    }

    # Current directory segment
    dir_segment=""
    dir_segment() {
        dir_segment="\w"
    }

    # Git branch segment
    git_segment=""
    git_segment() {
        # Git completion and prompt:
        #   Requires git prompt and completion plugins:
        #   https://github.com/git/git/tree/master/contrib/completion
        source ~/.git-completion.bash
        source ~/.git-prompt.sh

        # Settings
        GIT_PS1_SHOWDIRTYSTATE=1

        GIT_PROMPT=$(__git_ps1 "%s")
        [[ -n $GIT_PROMPT ]] && git_segment=$GIT_PROMPT
    }

    # Python virtual environment segment
    venv_segment=""
    venv_segment() {
        [[ -n $VIRTUAL_ENV ]] && venv_segment=$(basename $VIRTUAL_ENV)
    }

    # SSH segment
    ssh_segment=""
    ssh_segment() {
        if [[ "$SSH_CONNECTION" && "$SSH_TTY" == $(tty) ]]; then
            ssh_user=$(id -un)
            ssh_host=$(hostname)
            ssh_segment="${ssh_user}@${ssh_host}"
        fi
    }

    # Screen segment
    screen_segment=""
    screen_segment() {
        [[ -n $STY ]] && screen_segment=$STY
    }


    ##################################
    #       Segments filtering
    ##################################

    enabled_segments=""
    for i in ${!settings[@]}; do
        segment=${settings[$i]}
        segment_name=$segment[@]
        segment_settings=("${!segment_name}")

        if [[ ${segment_settings[1]} = true ]]; then
            # Call the segment generation function
            eval ${segment_settings[0]}
            segment_value=${!segment_settings[0]}

            [[ -n $segment_value ]] && enabled_segments+=${settings[$i]}" "
        fi
    done
    enabled_segments=($enabled_segments)


    ##################################
    #     Segments concatenation
    ##################################

    PS1=""
    for i in ${!enabled_segments[@]}; do
        segment=${enabled_segments[$i]}
        segment_name=$segment[@]
        segment_settings=("${!segment_name}")
        segment_value=${!segment_settings[0]}
        segment_icon=""
        [[ ${segment_settings[2]} = true ]] && segment_icon=${segment_settings[3]}" "
        fg_color=${segment_settings[4]}
        bg_color=${segment_settings[5]}

        # Append segment content to the prompt string
        PS1+=$(fg $fg_color)$(bg $bg_color)" "$segment_icon$segment_value" "

        # Check if the current segment is the last
        if [[ $(($i + 1)) -lt ${#enabled_segments[@]} ]]; then
            next_segment=${enabled_segments[$(($i + 1))]}
            next_segment_name=$next_segment[@]
            next_segment_settings=("${!next_segment_name}")
            next_bg_color=${next_segment_settings[5]}
            # Append a separator
            PS1+=$(separator $bg_color $next_bg_color)
        else
            # Append a separator
            PS1+=$(separator $bg_color)
        fi
    done

    # Check if the prompt string is empty
    [[ -z "$PS1" ]] && PS1+=$(separator default)

    # Reset colors and append a space in the end
    PS1+=$(fg reset)" "
}
PROMPT_COMMAND=generate_prompt
