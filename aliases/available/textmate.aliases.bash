cite 'about-alias'
about-alias 'textmate abbreviations'

echo "DEBUG textmate_aliases.bash loading"

case $OSTYPE in
  darwin*)
    # Textmate
    alias e='mate . &'
    alias et='mate app config db lib public script test spec config.ru Gemfile Rakefile README &'
    t() {
        echo "DEBUG textmate_aliases.bash t()"
        if [ "$1" == "" ]; then
            mate .
        else
            mate "$@"
        fi

    }
    alias tb="mate ~/.bash_ext ~/.bash_ext_local"
    ;;
esac
