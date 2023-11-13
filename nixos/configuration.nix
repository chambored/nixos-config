# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

# allows for unstable packages to be declared
let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.consoleMode = "max";

  networking.hostName = "marcel"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";
  services.ntp.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    packages=[ pkgs.terminus_font ];
    font="${pkgs.terminus_font}/share/consolefonts/ter-i22b.psf.gz";
    useXkbConfig = true; # use xkbOptions in tty.
  }; 

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = false;
  services.xserver.displayManager.startx.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound and bluetooth services.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # allows for unstable packages to be declared prefixed with 'unstable.'
  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };

  nixpkgs.config.allowUnfree = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gnat = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      _1password-gui # Multi-platform password manager
      appimage-run
      aspell # Spell checker for many languages
      aspellDicts.en # Aspell dictionary for English
      brightnessctl # This program allows you read and control device brightness
      calcurse # A calendar and scheduling application for the command line
      csview # A high performance csv viewer with cjk/emoji support
      dmenu # A generic, highly customizable, and efficient menu for the X Window System
      dwm # An extremely fast, small, and dynamic window manager for X
      feh # A light-weight image viewer
      firefox # A web browser built from Firefox source tree
      flameshot # Powerful yet simple to use screenshot software
      foliate # A simple and modern GTK eBook reader
      freecad # General purpose Open Source 3D CAD/MCAD/CAx/CAE/PLM modeler
      gimp-with-plugins # The GNU Image Manipulation Program
      gcc # GNU Compiler Collection, version 12.2.0 (wrapper script)
      glow # Render markdown on the CLI, with pizzazz!
      gnumake # A tool to control the generation of non-source files from sources
      gnupg # Modern release of the GNU Privacy Guard, a GPL OpenPGP implementation
      go-sct # Color temperature setting library and CLI that operates in a similar way to f.lux and Redshift
      hollywood # Fill your console with Hollywood melodrama technobabble
      inkscape # Vector graphics editor
      jetbrains-toolbox # Jetbrains Toolbox
      lapce # Lightning-fast and Powerful Code Editor written in Rust
      librewolf # A fork of Firefox, focused on privacy, security and freedom
      lite-xl # A lightweight text editor written in Lua
      lua # Powerful, fast, lightweight, embeddable scripting language
      marktext # A simple and elegant markdown editor, available for Linux, macOS and Windows
      minicom # Modem control and terminal emulation program
      mods # AI on the command line
      mongosh
      # Obsidian causing EOL error from Electron-24.8.6
      # obsidian # A powerful knowledge base that works on top of a local folder of plain text Markdown files
      openra # Open-source re-implementation of Westwood Studios' 2D Command and Conquer games
      openssl # A cryptographic library that implements the SSL and TLS protocols
      openssl.dev
      pavucontrol # PulseAudio Volume Control
      pciutils # A collection of programs for inspecting and manipulating configuration of PCI devices
      perl # The standard implementation of the Perl 5 programming language
      pkg-config # A tool that allows packages to find out information about other packages (wrapper script)
      pinentry # GnuPG’s interface to passphrase input
      proselint # A linter for prose
      python3 # A high-level dynamically-typed programming language
      rustup # The Rust toolchain installer
      simplescreenrecorder # A screen recorder for Linux
      scribus # Desktop Publishing (DTP) and Layout program for Linux
      session-desktop # Onion routing based messenger
      slack # Desktop client for Slack
      # slstatus # status monitor for window managers that use WM_NAME like dwm
      ssh-audit # Tool for ssh server auditing
      spotify # Play music from the Spotify music service
      st # Simple Terminal for X from Suckless.org Community
      syncthing # Open Source Continuous File Synchronization
      tree # Command to produce a depth indented directory listing
      unzip # An extraction utility for archives compressed in .zip format
      vlc # Cross-platform media player and streaming server
      watson 
      wireshark # Powerful network protocol analyzer
      xclip # Tool to access the X clipboard from a console application
      zathura # Tool to access the X clipboard from a console application
      zoom-us # zoom.us video conferencing application
      zip # Compressor/archiver for creating and modifying zipfiles

      #yazi needs:
      unstable.yazi # Blazing fast terminal file manager written in Rust, based on async I/O
      ffmpegthumbnailer # A lightweight video thumbnailer
      poppler # A PDF rendering library
     ];
  };

  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: { src = /home/gnat/data/.cfg/overlays/dwm; });
      dmenu = prev.dmenu.overrideAttrs (old: { src = /home/gnat/data/.cfg/overlays/dmenu; });
      # slstatus = prev.slstatus.overrideAttrs (old: { src = /home/gnat/data/.cfg/overlays/slstatus; });
      st = prev.st.overrideAttrs (old: { src = /home/gnat/data/.cfg/overlays/st; });
    })
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    btrfs-progs # Utilities for the btrfs filesystem
    vim # The most popular clone of the VI editor
    wget # Tool for retrieving files using HTTP, HTTPS, and FTP
    git # Distributed version control system
    neofetch # A fast, highly customizable system info script
    mariadb # An enhanced, drop-in replacement for MySQL
    tldr # Simplified and community-driven man pages
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ 1234 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

