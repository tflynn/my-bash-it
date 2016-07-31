# Helper function loading various enable-able files
function _load_my_bash_it_files() {
  subdirectory="$1"
  if [ ! -d "${MY_BASH_IT}/${subdirectory}/enabled" ]
  then
    continue
  fi
  FILES="${MY_BASH_IT}/${subdirectory}/enabled/*.bash"
  for config_file in $FILES
  do
    if [ -e "${config_file}" ]; then
      source $config_file
    fi
  done
}

# Function for reloading aliases
function my_reload_aliases() {
  _load_my_bash_it_files "aliases"
}

# Function for reloading auto-completion
function my_reload_completion() {
  _load_my_bash_it_files "completion"
}

# Function for reloading plugins
function my_reload_plugins() {
  _load_my_bash_it_files "plugins"
}

my-bash-it ()
{
    about 'my-bash-it help and maintenance'
    param '1: verb [one of: help | show | enable | disable | update | search ] '
    param '2: component type [one of: alias(es) | completion(s) | plugin(s) ] or search term(s)'
    param '3: specific component [optional]'
    example '$ my-bash-it show plugins'
    example '$ my-bash-it help aliases'
    example '$ my-bash-it enable plugin git [tmux]...'
    example '$ my-bash-it disable alias hg [tmux]...'
    example '$ my-bash-it update'
    example '$ my-bash-it search ruby [[-]rake]... [--enable | --disable]'
    typeset verb=${1:-}
    shift
    typeset component=${1:-}
    shift
    typeset func
    case $verb in
         show)
             func=_my-bash-it-$component;;
         enable)
             func=_my-enable-$component;;
         disable)
             func=_my-disable-$component;;
         help)
             func=_my-help-$component;;
         search)
             _my-bash-it-search $component $*
             return;;
         update)
             func=_my-bash-it_update;;
         *)
             reference my-bash-it
             return;;
    esac

    # pluralize component if necessary
    if ! _my_is_function $func; then
        if _my_is_function ${func}s; then
            func=${func}s
        else
            if _my_is_function ${func}es; then
                func=${func}es
            else
                echo "oops! $component is not a valid option!"
                reference bash-it
                return
            fi
        fi
    fi

    if [ x"$verb" == x"enable" -o x"$verb" == x"disable" ];then
        for arg in "$@"
        do
            $func $arg
        done
    else
        $func $*
    fi
}

_my_is_function ()
{
    _about 'sets $? to true if parameter is the name of a function'
    _param '1: name of alleged function'
    _group 'lib'
    [ -n "$(LANG=C type -t $1 2>/dev/null | grep 'function')" ]
}

_my-bash-it-aliases ()
{
    _about 'summarizes available bash_it aliases'
    _group 'lib'

    _my-bash-it-describe "aliases" "an" "alias" "Alias"
}

_my-bash-it-completions ()
{
    _about 'summarizes available bash_it completions'
    _group 'lib'

   _my-bash-it-describe "completion" "a" "completion" "Completion"
}

_my-bash-it-plugins ()
{
    _about 'summarizes available bash_it plugins'
    _group 'lib'

    _my-bash-it-describe "plugins" "a" "plugin" "Plugin"
}

_my-bash-it_update() {
  _about 'updates my-bash-it'
  _group 'lib'

  cd "${MY_BASH_IT}"
  if [ -z $MY_BASH_IT_REMOTE ]; then
    MY_BASH_IT_REMOTE="origin"
  fi
  git fetch &> /dev/null
  local status="$(git rev-list master..${MY_BASH_IT_REMOTE}/master 2> /dev/null)"
  if [[ -n "${status}" ]]; then
    git pull --rebase &> /dev/null
    if [[ $? -eq 0 ]]; then
      echo "my-bash-it successfully updated, enjoy!"
      reload
    else
      echo "Error updating my-bash-it, please, check if your Bash-it installation folder (${MY_BASH_IT}) is clean."
    fi
  else
    echo "my-bash-it is up to date, nothing to do!"
  fi
  cd - &> /dev/null
}

_my-bash-it-describe ()
{
    _about 'summarizes available my-bash-it components'
    _param '1: subdirectory'
    _param '2: preposition'
    _param '3: file_type'
    _param '4: column_header'
    _example '$ _my-bash-it-describe "plugins" "a" "plugin" "Plugin"'

    subdirectory="$1"
    preposition="$2"
    file_type="$3"
    column_header="$4"

    typeset f
    typeset enabled
    printf "%-20s%-10s%s\n" "$column_header" 'Enabled?' 'Description'
    for f in $MY_BASH_IT/$subdirectory/available/*.bash
    do
        if [ -e $MY_BASH_IT/$subdirectory/enabled/$(basename $f) ]; then
            enabled='x'
        else
            enabled=' '
        fi
        printf "%-20s%-10s%s\n" "$(basename $f | cut -d'.' -f1)" "  [$enabled]" "$(cat $f | metafor about-$file_type)"
    done
    printf '\n%s\n' "to enable $preposition $file_type, do:"
    printf '%s\n' "$ my-bash-it enable $file_type  <$file_type name> [$file_type name]... -or- $ bash-it enable $file_type all"
    printf '\n%s\n' "to disable $preposition $file_type, do:"
    printf '%s\n' "$ my-bash-it disable $file_type <$file_type name> [$file_type name]... -or- $ bash-it disable $file_type all"
}

_my-disable-plugin ()
{
    _about 'disables bash_it plugin'
    _param '1: plugin name'
    _example '$ disable-plugin rvm'
    _group 'lib'

    _my-disable-thing "plugins" "plugin" $1
}

_my-disable-alias ()
{
    _about 'disables bash_it alias'
    _param '1: alias name'
    _example '$ disable-alias git'
    _group 'lib'

    _my-disable-thing "aliases" "alias" $1
}

_my-disable-completion ()
{
    _about 'disables bash_it completion'
    _param '1: completion name'
    _example '$ disable-completion git'
    _group 'lib'

    _my-disable-thing "completion" "completion" $1
}

_my-disable-thing ()
{
    _about 'disables a bash_it component'
    _param '1: subdirectory'
    _param '2: file_type'
    _param '3: file_entity'
    _example '$ _disable-thing "plugins" "plugin" "ssh"'

    subdirectory="$1"
    file_type="$2"
    file_entity="$3"

    if [ -z "$file_entity" ]; then
        reference "disable-$file_type"
        return
    fi

    if [ "$file_entity" = "all" ]; then
        typeset f $file_type
        for f in $MY_BASH_IT/$subdirectory/available/*.bash
        do
            plugin=$(basename $f)
            if [ -e $MY_BASH_IT/$subdirectory/enabled/$plugin ]; then
                rm $MY_BASH_IT/$subdirectory/enabled/$(basename $plugin)
            fi
        done
    else
        typeset plugin=$(command ls $MY_BASH_IT/$subdirectory/enabled/$file_entity.*bash 2>/dev/null | head -1)
        if [ -z "$plugin" ]; then
            printf '%s\n' "sorry, $file_entity does not appear to be an enabled $file_type."
            return
        fi
        rm $MY_BASH_IT/$subdirectory/enabled/$(basename $plugin)
    fi

    printf '%s\n' "$file_entity disabled."
}

_my-enable-plugin ()
{
    _about 'enables bash_it plugin'
    _param '1: plugin name'
    _example '$ enable-plugin rvm'
    _group 'lib'

    _enable-thing "plugins" "plugin" $1
}

_my-enable-alias ()
{
    _about 'enables bash_it alias'
    _param '1: alias name'
    _example '$ enable-alias git'
    _group 'lib'

    _my-enable-thing "aliases" "alias" $1
}

_my-enable-completion ()
{
    _about 'enables bash_it completion'
    _param '1: completion name'
    _example '$ enable-completion git'
    _group 'lib'

    _my-enable-thing "completion" "completion" $1
}

_my-enable-thing ()
{
    cite _about _param _example
    _about 'enables a bash_it component'
    _param '1: subdirectory'
    _param '2: file_type'
    _param '3: file_entity'
    _example '$ _enable-thing "plugins" "plugin" "ssh"'

    subdirectory="$1"
    file_type="$2"
    file_entity="$3"

    if [ -z "$file_entity" ]; then
        reference "enable-$file_type"
        return
    fi

    if [ "$file_entity" = "all" ]; then
        typeset f $file_type
        for f in $MY_BASH_IT/$subdirectory/available/*.bash
        do
            plugin=$(basename $f)
            if [ ! -h $MY_BASH_IT/$subdirectory/enabled/$plugin ]; then
                ln -s ../available/$plugin $MY_BASH_IT/$subdirectory/enabled/$plugin
            fi
        done
    else
        typeset plugin=$(command ls $MY_BASH_IT/$subdirectory/available/$file_entity.*bash 2>/dev/null | head -1)
        if [ -z "$plugin" ]; then
            printf '%s\n' "sorry, $file_entity does not appear to be an available $file_type."
            return
        fi

        plugin=$(basename $plugin)
        if [ -e $MY_BASH_IT/$subdirectory/enabled/$plugin ]; then
            printf '%s\n' "$file_entity is already enabled."
            return
        fi

        mkdir -p $MY_BASH_IT/$subdirectory/enabled

        ln -s ../available/$plugin $MY_BASH_IT/$subdirectory/enabled/$plugin
    fi

    printf '%s\n' "$file_entity enabled."
}

_my-help-completions()
{
  _about 'summarize all completions available in bash-it'
  _group 'lib'

  _my-bash-it-completions
}

_my-help-aliases()
{
    _about 'shows help for all aliases, or a specific alias group'
    _param '1: optional alias group'
    _example '$ alias-help'
    _example '$ alias-help git'

    if [ -n "$1" ]; then
        cat $MY_BASH_IT/aliases/available/$1.aliases.bash | metafor alias | sed "s/$/'/"
    else
        typeset f
        for f in $MY_BASH_IT/aliases/enabled/*
        do
            typeset file=$(basename $f)
            printf '\n\n%s:\n' "${file%%.*}"
            # metafor() strips trailing quotes, restore them with sed..
            cat $f | metafor alias | sed "s/$/'/"
        done
    fi
}

_my-help-plugins()
{
    _about 'summarize all functions defined by enabled bash-it plugins'
    _group 'lib'

    # display a brief progress message...
    printf '%s' 'please wait, building help...'
    typeset grouplist=$(mktemp /tmp/grouplist.XXXX)
    typeset func
    for func in $(typeset_functions)
    do
        typeset group="$(typeset -f $func | metafor group)"
        if [ -z "$group" ]; then
            group='misc'
        fi
        typeset about="$(typeset -f $func | metafor about)"
        letterpress "$about" $func >> $grouplist.$group
        echo $grouplist.$group >> $grouplist
    done
    # clear progress message
    printf '\r%s\n' '                              '
    typeset group
    typeset gfile
    for gfile in $(cat $grouplist | sort | uniq)
    do
        printf '%s\n' "${gfile##*.}:"
        cat $gfile
        printf '\n'
        rm $gfile 2> /dev/null
    done | less
    rm $grouplist 2> /dev/null
}

_my-help-update () {
  _about 'help message for update command'
  _group 'lib'

  echo "Check for a new version of Bash-it and update it."
}

my-all_groups ()
{
    about 'displays all unique metadata groups'
    group 'lib'

    typeset func
    typeset file=$(mktemp /tmp/composure.XXXX)
    for func in $(typeset_functions)
    do
        typeset -f $func | metafor group >> $file
    done
    cat $file | sort | uniq
    rm $file
}

# if ! type pathmunge > /dev/null 2>&1
# then
#   function pathmunge () {
#     about 'prevent duplicate directories in you PATH variable'
#     group 'lib helpers'
#     example 'pathmunge /path/to/dir is equivalent to PATH=/path/to/dir:$PATH'
#     example 'pathmunge /path/to/dir after is equivalent to PATH=$PATH:/path/to/dir'
#
#     if ! [[ $PATH =~ (^|:)$1($|:) ]] ; then
#       if [ "$2" = "after" ] ; then
#         export PATH=$PATH:$1
#       else
#         export PATH=$1:$PATH
#       fi
#     fi
#   }
# fi
