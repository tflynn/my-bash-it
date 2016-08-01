cite 'about-alias'
about-alias 'textmate abbreviations'

case $OSTYPE in
  darwin*)
    # Textmate
    alias e='mate . &'
    alias et='mate app config db lib public script test spec config.ru Gemfile Rakefile README &'
    t() {
        if [ "$1" == "" ]; then
            mate .
        else
            mate "$@"
        fi

    }
    alias tb="mate ~/.bash_local ~/.bashrc ~/.bash_profile"
    ;;
esac
