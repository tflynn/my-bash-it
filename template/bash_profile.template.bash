#!/usr/bin/env bash

# Path to the bash it configuration
export BASH_IT="{{BASH_IT}}"

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME="{{BASH_IT_THEME}}"

# Path to the bash it configuration
export MY_BASH_IT="{{MY_BASH_IT}}"

# Load original Bash It
source $BASH_IT/bash_it.sh

# Load my-bash-it
source $MY_BASH_IT/my-bash-it.sh
