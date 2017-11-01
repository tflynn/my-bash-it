cite about-plugin
about-plugin 'Additional git functions'


git_active_branch () {
  active_branch=''
  cwd=`pwd`
  if [[ -d "${cwd}/.git" ]]
  then
    active_branch=`git branch | grep "^\*" | sed -e "s/^\* //"`
  fi
  echo $active_branch
}


#pushit () {
gpush(){
  active_branch=`git_active_branch`
  git push origin ${active_branch}
}

#pullit () {
gpull () {  
  active_branch=`git_active_branch`
  git pull --rebase origin ${active_branch}
}

gpullm () {  
  git pull --rebase origin master
}



gpushback() {
  active_branch=`git_active_branch`
  git push -f backup ${active_branch}
}

gpullback () {
  active_branch=`git_active_branch`
  git pull --rebase backup ${active_branch}
}

gpushdev() {
  active_branch=`git_active_branch`
  git push -f dev ${active_branch}
}

gpushbase() {
  active_branch=`git_active_branch`
  git push -f base ${active_branch}
}

gpulldev () {
  active_branch=`git_active_branch`
  git pull --rebase dev ${active_branch}
}

# #rebasedev() {
# grebasebackup() {
#   git pull --rebase origin master
# }

#revert_all() {
grevert_all() {
  files_to_revert=`git status | grep 'modified' | sed -e "s/^#[[:space:]]modified:   //"`
  for file_to_revert in $files_to_revert
  do
    echo 'About to revert ' $file_to_revert
    git checkout $file_to_revert
  done
}
