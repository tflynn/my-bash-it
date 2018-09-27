cite about-plugin
about-plugin 'sublime text functions'

function s() {
  if [ -z "$1" ]; then
    subl -n "./."
  else
    subl -n $@
  fi
}
