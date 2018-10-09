#!/usr/bin/env bash
# Initialize Bash It

# Reload Library
case $OSTYPE in
  darwin*)
    alias reload='source ~/.bash_profile'
    ;;
  *)
    alias reload='source ~/.bashrc'
    ;;
esac

# Only set $MY_BASH_IT if it's not already set
if [ -z "$MY_BASH_IT" ];
then
    # Setting $BASH to maintain backwards compatibility
    # TODO: warn users that they should upgrade their .bash_profile
    export MY_BASH_IT=$BASH
    export BASH=`bash -c 'echo $BASH'`
fi

# libraries, but skip appearance (themes) for now
LIB="${MY_BASH_IT}/lib/*.bash"
APPEARANCE_LIB="${MY_BASH_IT}/lib/appearance.bash"
for config_file in $LIB
do
  if [ $config_file != $APPEARANCE_LIB ]; then
    source $config_file
  fi
done

# appearance (themes) now, after all dependencies
# shellcheck source=./lib/appearance.bash
source "$APPEARANCE_LIB"

# Load enabled aliases, completion, plugins
for file_type in "aliases" "completion" "plugins"
do
  _load_my_bash_it_files $file_type
done

