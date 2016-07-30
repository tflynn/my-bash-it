#!/usr/bin/env bash
# my-bash-it installer

# Show how to use this installer
function show_usage() {
  echo -e "\n$0 : Install my-bash-it"
  echo -e "Usage:\n$0 [arguments] \n"
  echo "Arguments:"
  echo "--help (-h): Display this help message"
  echo "--silent (-s): Install default settings without prompting for input";
  echo "--interactive (-i): Interactively choose plugins"
  exit 0;
}

# enable a thing
function load_one() {
  file_type=$1
  file_to_enable=$2
  mkdir -p "$MY_BASH_IT/${file_type}/enabled"

  dest="${MY_BASH_IT}/${file_type}/enabled/${file_to_enable}"
  if [ ! -e "${dest}" ]; then
    ln -sf "../available/${file_to_enable}" "${dest}"
  else
    echo "File ${dest} exists, skipping"
  fi
}

# Interactively enable several things
function load_some() {
  file_type=$1
  [ -d "$MY_BASH_IT/$file_type/enabled" ] || mkdir "$MY_BASH_IT/$file_type/enabled"
  for path in `ls $MY_BASH_IT/${file_type}/available/[^_]*`
  do
    file_name=$(basename "$path")
    while true
    do
      read -e -n 1 -p "Would you like to enable the ${file_name%%.*} $file_type? [y/N] " RESP
      case $RESP in
      [yY])
        ln -s "../available/${file_name}" "$MY_BASH_IT/$file_type/enabled"
        break
        ;;
      [nN]|"")
        break
        ;;
      *)
        echo -e "\033[91mPlease choose y or n.\033[m"
        ;;
      esac
    done
  done
}

# Back up existing profile and create new one for my-bash-it
function backup_new() {
  test -w "$HOME/$CONFIG_FILE" &&
  cp -aL "$HOME/$CONFIG_FILE" "$HOME/${CONFIG_FILE}.mybashit.bak" &&
  echo -e "\033[0;32mYour original $CONFIG_FILE has been backed up to ${CONFIG_FILE}.mybashit.bak\033[0m"
  sed "s|{{MY_BASH_IT}}|$MY_BASH_IT|" "$MY_BASH_IT/template/bash_profile.template.bash" > "$HOME/${CONFIG_FILE}.tmp.a"
  cat "$HOME/$CONFIG_FILE.tmp.a" | sed "s|{{BASH_IT}}|$BASH_IT|"  > "$HOME/$HOME/${CONFIG_FILE}.tmp.b"
  cat "$HOME/$CONFIG_FILE.tmp.b" | sed "s|{{BASH_IT_THEME}}|$BASH_IT_THEME|"  > "$HOME/$HOME/${CONFIG_FILE}"
  rm "$HOME/${CONFIG_FILE}.tmp.a" "$HOME/$HOME/${CONFIG_FILE}.tmp.b"
  echo -e "\033[0;32mCopied the template $CONFIG_FILE into ~/$CONFIG_FILE, edit this file to customize my-bash-it\033[0m"
}

for param in "$@"; do
  shift
  case "$param" in
    "--help")        set -- "$@" "-h" ;;
    "--silent")      set -- "$@" "-s" ;;
    "--interactive") set -- "$@" "-i" ;;
    *)               set -- "$@" "$param"
  esac
done

OPTIND=1
while getopts "hsi" opt
do
  case "$opt" in
  "h") show_usage; exit 0 ;;
  "s") silent=true ;;
  "i") interactive=true ;;
  "?") show_usage >&2; exit 1 ;;
  esac
done
shift $(expr $OPTIND - 1)

if [[ $silent ]] && [[ $interactive ]]; then
  echo -e "\033[91mOptions --silent and --interactive are mutually exclusive. Please choose one or the other.\033[m"
  exit 1;
fi

MY_BASH_IT="$(cd "$(dirname "$0")" && pwd)"

case $OSTYPE in
  darwin*)
    CONFIG_FILE=.bash_profile
    ;;
  *)
    CONFIG_FILE=.bashrc
    ;;
esac

BACKUP_FILE=${CONFIG_FILE}.mybashit.bak
echo "Installing my-bash-it"
if [ -e "$HOME/$BACKUP_FILE" ]; then
  echo -e "\033[0;33mBackup file already exists. Make sure to backup your .bashrc before running this installation.\033[0m" >&2
  while ! [ $silent ];  do
    read -e -n 1 -r -p "Would you like to overwrite the existing backup? This will delete your existing backup file ($HOME/$BACKUP_FILE) [y/N] " RESP
    case $RESP in
    [yY])
      break
      ;;
    [nN]|"")
      echo -e "\033[91mInstallation aborted. Please come back soon!\033[m"
      exit 1
      ;;
    *)
      echo -e "\033[91mPlease choose y or n.\033[m"
      ;;
    esac
  done
fi

while ! [ $silent ]; do
  read -e -n 1 -r -p "Would you like to keep your $CONFIG_FILE and append my-bash-it templates at the end? [y/N] " choice
  case $choice in
  [yY])
    test -w "$HOME/$CONFIG_FILE" &&
    cp -aL "$HOME/$CONFIG_FILE" "${BACKUP_FILE}" &&
    echo -e "\033[0;32mYour original $CONFIG_FILE has been backed up to ${BACKUP_FILE}\033[0m"

    (sed "s|{{MY_BASH_IT}}|$MY_BASH_IT|" "$MY_BASH_IT/template/bash_profile.template.bash" | tail -n +2) >> "$HOME/$CONFIG_FILE"
    echo -e "\033[0;32mBash-it template has been added to your $CONFIG_FILE\033[0m"
    break
    ;;
  [nN]|"")
    backup_new
    break
    ;;
  *)
    echo -e "\033[91mPlease choose y or n.\033[m"
    ;;
  esac
done

if [ $silent ]; then
  # backup/new by default
  backup_new
fi

if [[ $interactive ]] && ! [[ $silent ]] ;
then
  for type in "aliases" "plugins" "completion"
  do
    echo -e "\033[0;32mEnabling $type\033[0m"
    load_some $type
  done
else
  echo ""
fi

echo ""
echo -e "\033[0;32mInstallation finished successfully! Enjoy my-bash-it!\033[0m"
echo -e "\033[0;32mTo start using it, open a new tab or 'source "$HOME/$CONFIG_FILE"'.\033[0m"
echo ""
echo "To show the available aliases/completions/plugins, type one of the following:"
echo "  my-bash-it show aliases"
echo "  my-bash-it show completions"
echo "  my-bash-it show plugins"
echo ""
echo "To avoid issues and to keep your shell lean, please enable only features you really want to use."
echo "Enabling everything can lead to issues."
