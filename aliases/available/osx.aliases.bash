cite about-alias
about-alias 'OSX  aliases'


# Flush dns
case $OSTYPE in
  darwin*)
    alias dnsflush="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"  
    alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
    alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'
    ;;
esac
