#!/usr/bin/env bash

SCM_THEME_PROMPT_DIRTY=" ${red}✗"
SCM_THEME_PROMPT_CLEAN=" ${bold_green}✓"
SCM_THEME_PROMPT_PREFIX=" ${green}|"
SCM_THEME_PROMPT_SUFFIX="${green}|"

GIT_THEME_PROMPT_DIRTY=" ${red}✗"
GIT_THEME_PROMPT_CLEAN=" ${bold_green}✓"
GIT_THEME_PROMPT_PREFIX=" ${green}|"
GIT_THEME_PROMPT_SUFFIX="${green}|"

RVM_THEME_PROMPT_PREFIX="|"
RVM_THEME_PROMPT_SUFFIX="|"

NODE_THEME_PROMPT_PREFIX="%"
NODE_THEME_PROMPT_SUFFIX="%"

PYTHON_THEME_PROMPT_PREFIX="!"
PYTHON_THEME_PROMPT_SUFFIX="!"

function node_version_prompt {
  if which node &> /dev/null; then
    node_version=$(node --version | cut -d'v' -f2)
    echo -e "$NODE_THEME_PROMPT_PREFIX$node_version$NODE_THEME_PROMPT_SUFFIX"
  fi
}

function python_version_prompt {
  if which python &> /dev/null; then
    if which pyenv &> /dev/null; then
      python_version="$(pyenv version | cut -d' ' -f1)"
      echo -e "$PYTHON_THEME_PROMPT_PREFIX$python_version$PYTHON_THEME_PROMPT_SUFFIX"
    fi
  fi
}


__bobby_clock() {
  printf "$(clock_prompt) "

  # if [ "${THEME_SHOW_CLOCK_CHAR}" == "true" ]; then
  #   printf "$(clock_char) "
  # fi
}

function prompt_command() {
    #PS1="${bold_cyan}$(scm_char)${green}$(scm_prompt_info)${purple}$(ruby_version_prompt) ${yellow}\h ${reset_color}in ${green}\w ${reset_color}\n${green}→${reset_color} "
    #PS1="\n$(battery_char) $(__bobby_clock)${yellow}$(ruby_version_prompt) ${green}$(python_version_prompt) ${orange}$(node_version_prompt) ${purple}\h ${reset_color}in ${green}\w\n${bold_cyan}$(scm_prompt_char_info) ${green}→${reset_color} "
    PS1="\n$(__bobby_clock)${yellow}$(ruby_version_prompt) ${green}$(python_version_prompt) ${orange}$(node_version_prompt) ${purple}\h ${reset_color}in ${green}\w\n${bold_cyan}$(scm_prompt_char_info) ${green}→${reset_color} "
}

THEME_SHOW_CLOCK_CHAR=${THEME_SHOW_CLOCK_CHAR:-"true"}
THEME_CLOCK_CHAR_COLOR=${THEME_CLOCK_CHAR_COLOR:-"$red"}
THEME_CLOCK_COLOR=${THEME_CLOCK_COLOR:-"$bold_cyan"}
THEME_CLOCK_FORMAT=${THEME_CLOCK_FORMAT:-"%Y-%m-%d %H:%M:%S"}

safe_append_prompt_command prompt_command
