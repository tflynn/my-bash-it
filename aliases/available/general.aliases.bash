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


# Find matching entries in ps output
fps(){
    PS_OPTIONS="alwwwx"
    ps ${PS_OPTIONS} | head -1
	ps ${PS_OPTIONS} | grep -v grep | grep -i $1
}

alias rmr="rm -rf"


sha256file() {
  if [ "X$1" == "X" ]; then
    echo "Usage: nixsum file-name"
  else
    input_file=$1
    sha_file="$1.sha256"
    sha256=`shasum -a 256 $1 | awk '{print $1}'`
    echo $sha256
    echo $sha256 > $sha_file
  fi
}



