cite about-plugin
about-plugin 'Additional python functions'

function pip3f() {
  if ! [ -z "$1" ]; then
    pip3 list | grep -i "$1"
  fi
}

function pypa_build_wheel() {
  python_clean
  python3 setup.py sdist bdist_wheel
  whl=$(find dist -name \*.whl)
  pip3 install $whl
}

