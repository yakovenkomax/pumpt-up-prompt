# Charset global fixes
export LANG="UTF-8"
export LESSCHARSET=utf-8

# Remove duplicates from input history
export HISTCONTROL=ignoreboth:erasedups

# Change autocomplete default behaviour
bind 'set menu-complete-display-prefix on'
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'

# Add aliases if present
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# Enable the pumpt prompt
[[ -f ~/.pumpt-up-prompt.sh ]] && . ~/.pumpt-up-prompt.sh
