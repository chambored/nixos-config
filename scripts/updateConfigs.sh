#!/run/current-system/sw/bin/bash

# Define an associative array of source and target files/directories
# Each key-value pair in the array represents a source-target relationship
# If a key is a directory, its value should be a directory as well
declare -A files=(
  ["$HOME/.config/lite-xl/"]="$HOME/Data/.cfg/dots/.config/"
  ["$HOME/.dwm/autostart.sh"]="$HOME/Data/.cfg/dots/.dwm/autostart.sh"
  ["$HOME/.xinitrc"]="$HOME/Data/.cfg/dots/.xinitrc"
  ["$HOME/.bashrc"]="$HOME/Data/.cfg/dots/.bashrc"
  ["$HOME/.vimrc"]="$HOME/Data/.cfg/dots/.vimrc"
  ["/etc/nixos/configuration.nix"]="$HOME/Data/.cfg/nixos/configuration.nix"
  ["/etc/nixos/hardware-configuration.nix"]="$HOME/Data/.cfg/nixos/hardware-configuration.nix"
  ["$HOME/updateConfigs.sh"]="$HOME/Data/.cfg/scripts/updateConfigs.sh"
)

# Initialize a flag to keep track of if all the copy operations are successful
# By default, this flag is true (as we assume all operations will be successful)
all_successful=true

# Loop over the array (keys) and for each key in the array, do the following:
for i in "${!files[@]}"
do
  # Check if the key represents a directory. If it is a directory, copy it recursively
  if [ -d "$i" ]; then
    cp -r "$i" "${files[$i]}"
  else
    # If the key is not a directory, it is assumed to be a file. Copy the file
    cp "$i" "${files[$i]}"
  fi
  
  # After each copy operation, check the exit status of the cp command
  # If the cp command fails, the exit status ($?) will be a non-zero value
  # In such a case, set the all_successful flag to false
  if [ $? -ne 0 ]; then
    all_successful=false
  fi
done

# After all the copy operations, check the all_successful flag
# If it is still true, it means all copy operations were successful. Print a success message.
# If it is false, it means at least one copy operation failed. Print an error message.
if $all_successful; then
  echo "Configuration files have been updated."
else
  echo "An error occurred while updating configuration files."
fi

