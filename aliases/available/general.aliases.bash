cite about-alias
about-alias 'general aliases'

shopt -s expand_aliases

export HISTFILESIZE=100000
export HISTSIZE=10000

# Append ~/bin to search path
export PATH=${PATH}:~/bin

alias g="grep"
alias gi="grep -iH"

# export GREP_OPTIONS="--color=never"
#
# alias grep="/usr/bin/grep --color=never"
# alias gi="grep -i"

alias a=alias
alias ag="alias | grep -i"

alias h=history
alias gh="h | grep -i"
alias hf="h | grep -i"

alias p="echo \$PATH"

alias rmr="rm -rf"

alias lh="ls -lh"

alias sub="sudo bash"


