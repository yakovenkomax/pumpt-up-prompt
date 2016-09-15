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
SYM_BRANCH=''
SYM_SEPARATOR=''

# Colors array
colors=('black' 'red' 'green' 'yellow' 'blue' 'magenta' 'cyan' 'white' 'default' 'reset')
fg_colors=('\[\e[0;30m\]' '\[\e[0;31m\]' '\[\e[0;32m\]' '\[\e[0;33m\]' '\[\e[0;34m\]' '\[\e[0;35m\]' '\[\e[0;36m\]' '\[\e[0;37m\]' '\[\e[0;39m\]' '\[\e[0m\]')
bg_colors=('\[\e[40m\]' '\[\e[41m\]' '\[\e[42m\]' '\[\e[43m\]' '\[\e[44m\]' '\[\e[45m\]' '\[\e[46m\]' '\[\e[47m\]' '\[\e[49m\]' '\[\e[0m\]')

# Color getters
fg() {
    echo ${fg_colors[$(get_index colors $1)]}
}
bg() {
    echo ${bg_colors[$(get_index colors $1)]}
}

# Get item index from an array
get_index() {
    arrayName=$1[@]
    array=("${!arrayName}")
    value=$2

    for i in ${!array[@]}; do
        if [[ ${array[$i]} = $value ]]; then
            echo "${i}";
        fi
    done
}

# Prompt line generation
generate_prompt() {
    # is virtual environment activated?
    if [[ -n $VIRTUAL_ENV ]]; then
       ve_part=`basename $VIRTUAL_ENV`
       ve_part=$(fg white)$(bg magenta)$ve_part' '$(fg magenta)$(bg blue)$SYM_SEPARATOR
    else
        ve_part=''
    fi;

    # Current directory
    dir_part=$(fg black)$(bg blue)' \w '

    # Git repo
    GIT_PROMPT=$(__git_ps1 ' %s')
    if [[ -n $GIT_PROMPT ]]; then
        git_part=$(fg blue)$(bg yellow)$SYM_SEPARATOR$(fg black)$(bg yellow)' '$SYM_BRANCH$GIT_PROMPT' '
    else
        git_part=''
    fi

    # Ending
    if [[ -n $GIT_PROMPT ]]; then
        end_part=$(fg yellow)$(bg default)$SYM_SEPARATOR$(bg reset)' '
    else
        end_part=$(fg blue)$(bg default)$SYM_SEPARATOR$(bg reset)' '
    fi

    PS1=$ve_part$dir_part$git_part$end_part
}
PROMPT_COMMAND=generate_prompt
