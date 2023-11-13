#!/run/current-system/sw/bin/bash

choice=$(cat ~/data/.cfg/overlays/dmenu/programs.txt | dmenu -i)

if [ -n "$choice" ]; then
  if [[ $choice == TUI:* ]]; then
    cmd=${choice#TUI:}
    st -e "$cmd" &
  elif [[ $choice == CLI:* ]]; then
    cmd=${choice#CLI:}
    st -e sh -c "tldr $cmd || ($cmd --help | less)" 2>>~/dmenu_error.log &
  elif [[ $choice == APPIMG:* ]]; then
    appimg=${choice#APPIMG:}
    appimage-run "$appimg" &
  else
    $choice &
  fi
fi

