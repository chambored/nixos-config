#!/run/current-system/sw/bin/bash

choice=$(cat ~/Data/.cfg/overlays/dmenu/programs.txt | dmenu -i)

if [ "$choice" != "" ]; then
  $choice &
fi
