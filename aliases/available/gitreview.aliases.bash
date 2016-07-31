cite about-alias
about-alias 'git-review aliases'

# Submit a review with an explicit topic
git_rewiew_with_topic(){
  active_branch=`git_active_branch`
  topic_file=".topic-${active_branch}"
  if [ -f "${topic_file}" ]; then
    topic=`cat ${topic_file}`
    echo "git review -t \"${topic}\""
    git review -t "${topic}"
  else
    echo "git review"
    git review
  fi
}

alias gitr="git_rewiew_with_topic"


