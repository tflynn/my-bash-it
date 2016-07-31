cite about-plugin
about-plugin 'Manipulate terminal title'

#
# Set the terminal title 
#
# Title format is <hostname>:<directory name>>:[git]:[git branch]
#
# If a short system name is set in /etc/shortname, then use it, else use hostname
# Directory name is the basename of the directory only
# If a git repository, the string 'git'
# If a git repository, the active branch
#
# Arguments: none
# Outputs: none
# Side-effects: Terminal title is set
#
terminaltitle () {

  cwd=`pwd`

  if [[ -e '/etc/shortname' ]]
  then
    hostname=`cat /etc/shortname`
  else
    hostname=`hostname`
  fi

  directory_basename=`basename "$cwd"`
  default_title="${hostname}:${directory_basename}"

  # if [[ $X_GIT == true ]]
  # then
  #   git_title=`git_terminal_title`
  #   default_title="${default_title}:${git_title}"
  #   x_debugmsg "Default title with active branch is ${default_title}"
  # fi
  # Finally, set the prompt and the terminal title
  echo -ne "\033]0;${default_title}\007"

}

#
# Set the terminal title to the specified string or the default (see terminaltitle above)
#
# Arguments: [terminal_title] Optional terminal title
# Outputs: none
# Side-effects: Terminal title is set
#
tt () {
  if [ ! "$1" == "" ]
  then
    echo -ne "\033]0;$1\007"
  else
    terminaltitle
  fi
}

