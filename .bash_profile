# Charset global fixes
export LANG="UTF-8"
export LESSCHARSET=utf-8

# Add aliases if present
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# Enable Sensible Bash (https://github.com/mrzool/bash-sensible)
[[ -f ~/sensible.bash ]] && . ~/sensible.bash

# Enable Pumped Up Prompt (https://github.com/yakovenkomax/pumpt-up-prompt)
[[ -f ~/pumpt-up-prompt.sh ]] && . ~/pumpt-up-prompt.sh
