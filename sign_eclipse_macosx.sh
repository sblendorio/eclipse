#
# Mysterious fix to random corrupt executable error...
#

sudo codesign --force --deep --sign - /Applications/Eclipse.app
