# NixOS Configuration

These instructions will allow a replication of my NixOS setup. It is not exhaustive, but it should get you pretty close!

## Contents

- `dots/`: Contains current dotfiles
- `nixos/`: Contains NixOS configuration files
  - `configuration.nix`: My NixOS system configuration.
  - `hardware-configuration.nix`: My NixOS hardware configuration.
- `overlays/`: Contains custom build overlays for suckless utilities.
  - `dwm/`: Overlay for the dynamic window manager [dwm](https://dwm.suckless.org/).
  - `dmenu/`: Overlay for the dynamic menu [dmenu](https://tools.suckless.org/dmenu/).
  - `st/`: Overlay for the simple terminal [st](https://st.suckless.org/).
  - `slock/`: Overlay for the simple screen locker [slock](https://tools.suckless.org/slock/).
  - `slstatus/`: Overlay for the status monitor [slstatus](https://tools.suckless.org/slstatus/).
- `scripts/`: Contains some utility scripts
- `wallpapers/`: Contains wallpapers, modified to match the components of my OS

## Replication

### 1. Clone the Repository
Start by cloning this repository to your local machine using the `git clone` command.
```
git clone https://github.com/chambored/nixos-config.git
```

### 2. Copy the NixOS Configuration Files
Copy both `configuration.nix` and `hardware-configuration.nix` to `/etc/nixos/`:
```
sudo cp path/to/configuration.nix /etc/nixos/
sudo cp path/to/hardware-configuration.nix /etc/nixos/
```

### 3. Update the Paths in NixOS Configuration
Update the paths in the `configuration.nix` file to reflect the location of the cloned overlays.

### 4. Prepare the Custom dmenu
The custom dmenu requires the `dmenu_custom.sh` script. Make sure to set this script as executable:
```
chmod +x path/to/dmenu_custom.sh
```
### 5. Update the Programs List
When you want a program to appear in the custom dmenu list, update the `programs.txt` with the name of the package.

### 6. Copy the Dot Files
Copy the content of the `dots` directory into your home directory:
```
cp -r dots/* ~/
```

## Notes:
A lot of file paths in scripts, shebangs, and config files reflect my organization. Using these files would require changing those file paths to reflect your own.
