{ config, lib, pkgs, ... }:

# Profile for any personal device with direct user interaction
# (e.g. Workstations, laptops, media devices).

let
  # allow unstable unfree pkgs
  unstable = import <nixos-unstable>
    {
      config.allowUnfree = true;
    };
in
  {
  imports = [
    ./base.nix
    # modules
    ../modules/services/xserver/hardware/libinput.nix
  ];

  ### BOOT #####################################################################
  # splash screen
  boot = {
    kernelParams = [ "quiet" ];
    plymouth.enable = true;
  };

  ### HARDWARE #################################################################
  # enable sound
  sound.enable = lib.mkDefault true;
  hardware = {
    pulseaudio = {
      enable = lib.mkDefault true;
      # add the extended pkg to support bluetooth audio
      package = pkgs.pulseaudioFull;
    };
  };
  # enable bluetooth
  hardware.bluetooth.enable = lib.mkDefault true;
  # enable accelerated OpenGL rendering
  hardware.opengl.enable = lib.mkDefault true;

  ### NETWORK ##################################################################
  # use NetworkManager
  networking.networkmanager.enable = lib.mkDefault true;

  ### CONFIGS ##################################################################
  # generate a static config path
  environment.etc = {
    # alacritty
    "per-user/alacritty/alacritty.yml".text = import ../configs/alacritty/default.nix {};
  };
  system.activationScripts = {
    networkmanagerSetup = {
      text = ''
        mkdir -p /data/host/networkmanager/system-connections/
        ln -sfn /data/host/networkmanager/system-connections/ /etc/NetworkManager/system-connections
      '';
      deps = [];
    };
  };
  system.userActivationScripts = {
    alacrittySetup = {
      text = '' ln -sfn /etc/per-user/alacritty ~/.config/ '';
      deps = [];
    };
  };

  ### PKGS #####################################################################
  # allow unfree pkgs (stable)
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # general
    lxappearance-gtk3

    # terminal
    unstable.alacritty

    # gnupg
    gpa
    pinentry

    # xorg tools
    xclip
    xorg.xev
    xorg.xmodmap

    # themes
    matcha
    arc-theme

    # browser
    chromium
    firefox
    qutebrowser

    # communication
    signal-desktop
    slack
    unstable.riot-desktop
    thunderbird

    # libnotify
    libnotify
    dunst

    #video
    gstreamer
    gst-python

    # coding
    unstable.vscode

    #misc
    gparted
    pavucontrol
    keepassxc
    networkmanager-openvpn
    ];

  ### X11 ######################################################################
  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
    dejavu_fonts
    fira-code
    font-awesome-ttf
    ];
    fontconfig = {
      enable = lib.mkDefault true;
      defaultFonts.monospace = [ "DejaVu Sans Mono" ];
    };
  };
  services = {
    xserver = {
      # enable xserver by default
      enable = lib.mkDefault true;
      useGlamor = true;
      displayManager = {
        lightdm = {
          enable = lib.mkDefault true;
        };
      };
      desktopManager = {
        xterm.enable = false;
        # enable gnome as fallback Desktop environment
        gnome3.enable = true;
        default = "none";
      };
    };

  ### SERVICES #################################################################
    # minimize log size
    journald.extraConfig = "SystemMaxUse=500M";
    # enable avahi protocol to mdns addresses
    avahi = {
      enable = lib.mkDefault true;
      nssmdns = true;
    };
    # adjusts the color temperature of your screen at night
    redshift = {
      enable = lib.mkDefault true;
      #provider = "geoclue2";
      # hard code geolocation
      # welcome to Bochum :)
      latitude = "51.48";
      longitude = "7.22";
    };
    # standalone compositor
    # a must have if your use the modesettig driver for xorg
    compton  = {
      enable = lib.mkDefault true;
      backend = lib.mkDefault "glx";
    };
    # secure firmware updates
    fwupd.enable = lib.mkDefault true;
    # ACPI event handler
    acpid.enable = true;
  };
  programs = {
    # enable gnupg ssh-agent
    gnupg.agent = {
      enable = lib.mkDefault true;
      enableSSHSupport =true;
    };
  };
}
