cite about-plugin
about-plugin 'general functions'


#
# Find in short directory listing
#
# Arguments: [directory] Optional directory. Defaults to current if not specified
#            <string_to_find> String to find
# Outputs:   Any matching output
# Side-effects: None
#
lg () {
if [[ "$2" == "" ]]
then
  ls | grep -i $1
else
  ls $1 | grep -i $2
fi
}

#
# Find in short directory listing
#
# Arguments: [directory] Optional directory. Defaults to current if not specified
#            <string_to_find> String to find
# Outputs:   Any matching output
# Side-effects: None
#
llg () {
if [[ "$2" == "" ]]
then
  ls -a | grep -i $1
else
  ls -a $1 | grep -i $2
fi
}


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
    PS_OPTIONS="alx"
    ps ${PS_OPTIONS} | head -1
	  ps ${PS_OPTIONS} | grep -v grep | grep -i $1
}


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

# Handle all startup files

all_startup() {
  if [ -z "$1" ]; then
    action="status"
  else
    action=$1
  fi

  all_startup_dirs=("$BASH_IT" "$MY_BASH_IT" "$DOTFILES" "$MYBIN")
  for startup_dir in "${all_startup_dirs[@]}"
  do
    pushd $startup_dir &>/dev/null
    echo "Processing $startup_dir"

    if [ $action == "status" ]; then
      (git status | grep -q modified) &>/dev/null
      git_status=$?
      if [ $git_status == 0 ]; then
        echo "$startup_dir modifications found"
      else
        echo "$startup_dir no changes"
      fi

    elif [ $action == "update" ]; then
      (git status | grep -q modified) &>/dev/null
      git_status=$?
      if [ $git_status == 0 ]; then
        echo "$startup_dir Can't update. Changes found"
      else
        echo "$startup_dir Updating ..."
        git pull
      fi
    
    else
      echo "Unknown action $action. Skipping ..."      
    fi

    popd &>/dev/null

  done

}


