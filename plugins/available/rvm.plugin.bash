cite about-plugin
about-plugin 'load rvm, if you are using it'

# Load RVM dynamically - avoids conflcts with other package managers if only loaded on-demand

# rvm_on_present=$(alias | grep rvm_on | xargs)
# if [ ! "$rvm_on_present" == "" ]; then
#   unalias rvm_on
# fi

# This should also work
#unalias rvm_on &>/dev/null

rvm_on() {
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

    # Check to make sure that RVM is actually loaded before adding
    # the customizations to it.
    if [ "$rvm_path" ]
    then
        # Load the auto-completion script if RVM was loaded.
        [[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

        switch () {
          rvm $1
          local v=$(rvm_version)
          rvm wrapper $1 textmate
          echo "Switch to Ruby version: "$v
        }

        rvm_default () {
          rvm --default $1
          rvm wrapper $1 textmate
        }

        function rvm_version () {
          ruby --version
        }

    fi

}
