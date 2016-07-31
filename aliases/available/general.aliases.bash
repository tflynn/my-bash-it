cite about-alias
about-alias 'general aliases'

shopt -s expand_aliases

alias g="grep"
alias gi="grep -i"

alias a=alias
alias ag="alias | gi"

alias h=history
alias gh="h | gi"
alias hf="h | gi"

alias p="echo \$PATH"


#  
# Long directory listing through more
#
# Arguments: [directory] Optional directory. Defaults to current if not specified
#            
# Outputs:  Long directory listing piped through more
# Side-effects: None 
#
ltm () {
  if [ X$1 == X ]
  then
    ls -lt . | more
  else
    ls -lt $1 | more
  fi
}

