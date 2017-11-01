cite about-alias
about-alias 'my-bash-it  aliases'

# Flush dns
case $OSTYPE in
  darwin*)
      alias startup="cd ~/Everything/Startup"
      alias startupt="cd ~/Everything/Startup; mate ."
      alias my="cd ~/Everything/Startup/my-bash-it"
      alias myt="cd ~/Everything/Startup/my-bash-it; mate ."
    ;;
esac
