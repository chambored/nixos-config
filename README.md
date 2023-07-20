# My Nix Configuration and Suckless Overlays

This repository contains my personal [NixOS](https://nixos.org/) configuration, along with custom build overlays for various [suckless](https://suckless.org/) utilities including `dwm`, `dmenu`, `st`, `slock`, and `slstatus`.

## Contents

- `nixos/`: Contains NixOS configuration files
  - `configuration.nix`: My NixOS system configuration.
  - `hardware-configuration.nix`: My NixOS hardware configuration.
- `overlays/`: Contains custom build overlays for suckless utilities.
  - `dwm/`: Overlay for the dynamic window manager [dwm](https://dwm.suckless.org/).
  - `dmenu/`: Overlay for the dynamic menu [dmenu](https://tools.suckless.org/dmenu/).
  - `st/`: Overlay for the simple terminal [st](https://st.suckless.org/).
  - `slock/`: Overlay for the simple screen locker [slock](https://tools.suckless.org/slock/).
  - `slstatus/`: Overlay for the status monitor [slstatus](https://tools.suckless.org/slstatus/).

## Usage

Clone this repository to your local machine, and symbolic link the `configuration.nix` file to your `/etc/nixos/` directory.

```bash
git clone https://github.com/chambored/nixos-config
sudo ln -s /path/to/reponame/configuration.nix /etc/nixos/configuration.nix
```

When using any of the overlays, make sure to include them in your 'configuration.nix' like so:
```
nixpkgs.overlays = [
  (import /path/to/overlay)
];
```

Remember to replace '/path/to/overlay' with the actual path to the desired overlay.
