cite about-alias
about-alias 'Java aliases'

case $OSTYPE in
  darwin*)
      # Java
      export JAVA_HOME="$(/System/Library/Frameworks/JavaVM.framework/Versions/Current/Commands/java_home)"
    ;;
esac

