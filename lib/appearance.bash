#!/usr/bin/env bash

# colored ls
export LSCOLORS='Gxfxcxdxdxegedabagacad'

if [[ -z "$MY_BASH_IT_CUSTOM_THEME_DIR" ]]; then
    MY_BASH_IT_CUSTOM_THEME_DIR="${MY_BASH_IT_CUSTOM:=${MY_BASH_IT}/custom}/themes"
fi

# Load the theme

if [[ $MY_BASH_IT_THEME ]]; then
    if [[ -f $MY_BASH_IT_THEME ]]; then
        source $MY_BASH_IT_THEME
    elif [[ -f "$MY_CUSTOM_THEME_DIR/$MY_BASH_IT_THEME/$MY_BASH_IT_THEME.theme.bash" ]]; then
        source "$MY_CUSTOM_THEME_DIR/$MY_BASH_IT_THEME/$MY_BASH_IT_THEME.theme.bash"
    else
        source "$MY_BASH_IT/themes/$MY_BASH_IT_THEME/$MY_BASH_IT_THEME.theme.bash"
    fi
fi
