cite about-alias
about-alias 'general aliases'

shopt -s expand_aliases

export HISTFILESIZE=10000
export HISTSIZE=10000

# Append ~/bin to search path
export PATH=${PATH}:~/bin

alias g="grep"
alias gi="grep -i"

# export GREP_OPTIONS="--color=never"
#
# alias grep="/usr/bin/grep --color=never"
# alias gi="grep -i"

alias a=alias
alias ag="alias | gi"

alias h=history
alias gh="h | gi"
alias hf="h | gi"

alias p="echo \$PATH"

alias rmr="rm -rf"

