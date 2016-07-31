cite about-alias
about-alias 'Additional git aliases'

# bash_it style aliases - variants of existing aliases
alias gconf="cat .git/config"
alias gconf-t="t .git/config"

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
alias gswip="git stash save 'WIP '\`datetime_stamp\`' '"
#alias stl="stash list"
alias gstl="gstash list"
#alias sta="stash apply"
alias gsta="gstash apply"
#alias sts="stash save"
alias gsts="gstash save"
#alias stc="stash clear"
alias gstc="gstash clear"

alias gdiff="git diff"
alias gshow="git show"

alias gssha="git rev-parse --short HEAD"
alias gcall="git commit -v -a -m"

