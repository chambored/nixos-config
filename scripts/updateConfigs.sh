#!/run/current-system/sw/bin/bash

# Define an array of source and target files
declare -A files=(
  ["$HOME/.dwm/autostart.sh"]="$HOME/Data/.cfg/dots/.dwm/autostart.sh"
  ["$HOME/.xinitrc"]="$HOME/Data/.cfg/dots/.xinitrc"
  ["$HOME/.bashrc"]="$HOME/Data/.cfg/dots/.bashrc"
  ["$HOME/.vimrc"]="$HOME/Data/.cfg/dots/.vimrc"
  ["/etc/nixos/configuration.nix"]="$HOME/Data/.cfg/nixos/configuration.nix"
  ["/etc/nixos/hardware-configuration.nix"]="$HOME/Data/.cfg/nixos/hardware-configuration.nix"
  ["$HOME/updateConfigs.sh"]="$HOME/Data/.cfg/scripts/updateConfigs.sh"
)

# Loop over the array and copy each source file to its corresponding target
for i in "${!files[@]}"
do
  cp "$i" "${files[$i]}"
done

echo "Configuration files have been updated."
