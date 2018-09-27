cite about-alias
about-alias 'Python aliases'

#
# Python
#
alias 2="python2"
alias 3="python3"
alias py2="2"
alias py3="3"

function pip3f() {
  if ! [ -z "$1" ]; then
    pip3 list | grep -i "$1"
  fi
}

alias pcl="python_clean"
alias pypa_build="python_clean; python3 setup.py install"
alias pb="pypa_build"
alias pypa_build_pip3="python_clean; pip3 install -e ."
alias pb3="pypa_build_pip3"

function pypa_build_wheel() {
  python_clean
  python3 setup.py sdist bdist_wheel
  whl=$(find dist -name \*.whl)
  pip3 install $whl
}
alias pbw="pypa_build_wheel"

alias pyinit="touch __init__.py"

# Nose
alias nose="nosetests"
