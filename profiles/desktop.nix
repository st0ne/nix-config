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
 
  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
      luks.devices = lib.mkIf config.general.boot.encryptData [
      {
        # cryptdevice with all my persistent data
        name = "data";
        device = "/dev/${config.general.name}/data";
        preLVM = false;
      }
      ];
    };
  };
  fileSystems = lib.mkIf config.general.boot.default {
    "/" = {
      device = "/dev/${config.general.name}/nixos";
      fsType = "ext4";
      options = [ "noatime" "discard" ];
   };
     "/boot/efi" = {
      device = config.general.boot.efi;
      fsType = "vfat";
    };
    # partition with persistent data (user & host)

    "/data" = {
      device = if config.general.boot.encryptData then "/dev/mapper/data" else "/dev/${config.general.name}/data";
      fsType = "ext4";
      options = [ "noatime" "discard" ];
    };
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
    # dunst
    "per-user/dunst/dunstrc".text = import ../configs/dunst/default.nix {};
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
    dunstSetup = {
      text = '' ln -sfn /etc/per-user/dunst ~/.config/ '';
      deps = [];
    };
  };

  ### PKGS #####################################################################
  # allow unfree pkgs (stable)
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # general
    lxappearance-gtk3
    zathura

    # terminal
    unstable.alacritty
    #alacritty

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
      useGlamor = lib.mkDefault true;
      displayManager = {
        lightdm = {
          enable = lib.mkDefault true;
          greeters = {
            gtk = {
              enable = lib.mkDefault true;
              cursorTheme = {
                size = 48;
              };
            };
          };
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
