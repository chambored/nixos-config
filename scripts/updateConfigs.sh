#!/run/current-system/sw/bin/bash

# Declare an associative array of source files to destination paths
declare -A tracked_files=(
  ["$HOME/.config/lite-xl/init.lua"]="$HOME/data/.cfg/dots/.config/lite-xl/init.lua"
  ["$HOME/.dwm/autostart.sh"]="$HOME/data/.cfg/dots/.dwm/autostart.sh"
  ["$HOME/.xinitrc"]="$HOME/data/.cfg/dots/.xinitrc"
  ["$HOME/.bashrc"]="$HOME/data/.cfg/dots/.bashrc"
  ["$HOME/.vimrc"]="$HOME/data/.cfg/dots/.vimrc"
  ["/etc/nixos/configuration.nix"]="$HOME/data/.cfg/nixos/configuration.nix"
  ["/etc/nixos/hardware-configuration.nix"]="$HOME/data/.cfg/nixos/hardware-configuration.nix"
)

declare -A tracked_dirs=(
  ["$HOME/.config/lite-xl/colors"]="$HOME/data/.cfg/dots/.config/lite-xl/colors"
  ["$HOME/.config/lite-xl/fonts"]="$HOME/data/.cfg/dots/.config/lite-xl/fonts"
  ["$HOME/.config/lite-xl/plugins"]="$HOME/data/.cfg/dots/.config/lite-xl/plugins"
  ["$HOME/.vim/"]="$HOME/data/.cfg/dots/.vim"
)

# List of updated items
declare -a updated_items=()

# Handling files
for src in "${!tracked_files[@]}"; do
  dst="${tracked_files[$src]}"
  operation=""

  if [ -f "$src" ] && ! cmp -s "$src" "$dst"; then
    cp "$src" "$dst"
    operation="Updated file:"
  elif [ -f "$src" ] && [ ! -f "$dst" ]; then
    cp "$src" "$dst"
    operation="Added file:"
  fi

  if [ ! -z "$operation" ]; then
    updated_items+=("$operation $src to $dst")
  fi
done

# Handling directories
for src in "${!tracked_dirs[@]}"; do
  dst="${tracked_dirs[$src]}"
  operation=""
  updated=false

  # Check if directory exists in destination
  if [ -d "$src" ] && [ ! -d "$dst" ]; then
    mkdir -p "$dst"
    updated_items+=("Added directory: $src to $dst")
    updated=true
  fi

  # Sync and capture details of updates
  if [ -d "$src" ]; then
    tmp_output=$(mktemp)
    rsync -av --delete "$src/" "$dst/" > "$tmp_output"

    # Check if files were updated, added or deleted
    while IFS= read -r line; do
      if [[ $line == deleting* ]]; then
        updated_items+=("Deleted: $line in $src synced to $dst")
        updated=true
      elif [[ $line =~ ^[a-zA-Z0-9\/._-]+ && ! $line =~ /$ && ! $line =~ "sending incremental file list" && ! $line =~ "sent" && ! $line =~ "speedup" ]]; then
        updated_items+=("Updated or Added: $line in $src synced to $dst")
        updated=true
      fi
    done < "$tmp_output"

    rm "$tmp_output"
  fi
done

# Display the updated items
if [ ${#updated_items[@]} -eq 0 ]; then
  echo "No items were updated."
else
  for item in "${updated_items[@]}"; do
    echo " - $item"
  done
fi
