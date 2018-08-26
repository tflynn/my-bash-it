cite about-alias
about-alias 'Additional git aliases'

gconf_dir_find(){
  if [ -n "$1" ]; then
    current_dir="$1"
  else
    current_dir=$(pwd)
  fi
  git_dir="${current_dir}/.git"
  #echo "at start current_dir ${current_dir} git_dir ${git_dir}"
  if [ -e  ${git_dir} ]; then
    #echo "Found .git in current directory ${git_dir}"
    echo "${git_dir}"
  else
    pushd "${current_dir}/.." &> /dev/null
    current_dir=$(pwd)
    #echo "processing current_dir ${current_dir}"
    if [ "${current_dir}" == "${HOME}" ]; then
      # Gone as far as possible
      last_dir=${current_dir}
      #echo "Stop recursion ${last_dir}"
      popd &>/dev/null
      echo ${last_dir}
    else
      popd &>/dev/null
      #echo "recursing to ${current_dir}" 
      gconf_dir_find ${current_dir}
    fi
  fi
}

# bash_it style aliases - variants of existing aliases
alias gconf="eval \"cat \$(gconf_dir_find)/config\""
alias gconf-t="eval \"mate \$(gconf_dir_find)/config\""


# alias revert="git checkout"
alias grev="git checkout"

# alias ggm="git checkout master"
alias gcom="git checkout master"

# alias log="git log"
alias gl="git log"

# alias add="git add"
# alias com="git commit"

# alias coma="git commit --amend"
alias gca="git commit --amend"

#alias cherry="git cherry-pick"
alias gcherry="git cherry-pick"

alias gr="git review"
alias gpatch="git format-patch -1 --stdout"
alias gapply="git am"

#alias blame="git blame"
alias gblame="git blame"

alias datetime_stamp="date '+%F %H:%M:%S'"

#alias stash="git stash"
alias gstash="git stash"
#alias swip="stash save 'WIP '\`datetime_stamp\`' '"
alias gswip="git stash push -m 'WIP '\`datetime_stamp\`' '"
#alias stl="stash list"
alias gstl="gstash list"
#alias sta="stash apply"
alias gsta="gstash apply"
#alias sts="stash save"
alias gsts="gstash push"
#alias stc="stash clear"
alias gstc="gstash clear"

alias gdiff="git diff"
alias gshow="git show"

alias gssha="git rev-parse --short HEAD"
alias gcall="git commit -v -a -m"
gcallp(){
  git commit -v -a -m "$1" && gpush
}

