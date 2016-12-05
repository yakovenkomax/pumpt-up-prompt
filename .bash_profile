# Charset global fixes
export LANG="UTF-8"
export LESSCHARSET=utf-8

# Add aliases if present
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# Enable the pumpt prompt
[[ -f ~/.pumpt-prompt.sh ]] && . ~/.pumpt-prompt.sh