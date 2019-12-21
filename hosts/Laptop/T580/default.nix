{ config, lib, pkgs, ... }:

## main personal Laptop
# Lenovo Thinkpad T580
# CPU: i7-8550U
# iGPU: Intel UHD Graphics 620 (active)
# dGPU: NVIDIA GeForce MX150 (inactive)
# Display: 15.6" UHD (3840 x 2160)

let
  secret = import ../../../secrets.nix {};
in

{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    # profile
    ../../../profiles/laptop.nix
    ../../../profiles/modules/config.nix
    ../../../profiles/pkgs/personal.nix
    ../../../profiles/fstab/zfs.nix
    # modules
    ../../../modules/hardware/cpu/intel
    ../../../modules/hardware/gpu/intel
    ../../../modules/hardware/thinkpad
    ../../../modules/hardware/storage/nvme.nix
    ../../../modules/hardware/devices/pcscd.nix
    ../../../modules/hardware/devices/yubikey.nix
    ../../../modules/networking/wireguard.nix
    ../../../modules/virtualisation/libvirtd.nix
    ../../../modules/xserver/window-managers/i3.nix
    # extern
    ../../../extern/home-manager.nix
    # overlays
    ../../../overlays/HiDPI.nix
    ../../../overlays/no-nvidia.nix
    ../../../overlays/intel-vaapi.nix
    ../../../overlays/xorg-no-sleep.nix
    # users
    ../../../users/sylv/desktop.nix
    # shells
    ../../../shells
  ];

  ### GENERAL ##################################################################
  host.name = "T580";
  host.boot.default = true;
  host.boot.efi = true;
  host.boot.device = "/dev/nvme0n1p1";
  host.dpi = 192;
  networking.hostId= "13dead37";

  system.stateVersion = "19.09";
  nix.maxJobs = 8;

  ### INIT #####################################################################
  boot = {
    consoleLogLevel = 1;
    plymouth.enable = true;
    initrd.luks.devices."${config.host.name}" = {
      device = "/dev/nvme0n1p2";
      keyFile = "/keyfile.bin";
      allowDiscards = true;
    };
    loader = {
      grub = {
        extraInitrd = "/boot/initrd.keys.gz";
        enableCryptodisk = true;
        zfsSupport = true;
      };
    };
  };

  ### USER #####################################################################
  users.users.sylv.extraGroups = [
    "wheel" # privileged user
    "networkmanager" # manage network
    "video" # hardware acceleration access
    "dialout" # allow serial console access
    "libvirtd" # manage libvirt vms
    "docker" # allow direct docker api access (Warning: The docker group grants
    # privileges equivalent to the root user.
    # [https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface)
  ];

  ### GUI ######################################################################
  #services.xserver.videoDrivers = [ "intel" "modesetting" ];
  home-manager.users.sylv = {
    services.compton = {
      enable = true;
      vSync = "opengl-swc";
    };
    services.dunst = {
      enable = true;
    };
  };

  ### POWER MANAGEMENT #########################################################
  services.tlp.extraConfig = ''
    START_CHARGE_THRESH_BAT0=60
    STOP_CHARGE_THRESH_BAT0=90
    START_CHARGE_THRESH_BAT1=60
    STOP_CHARGE_THRESH_BAT1=90
  '';

  ### VIRTUALISATION ###########################################################
  #virtualisation.lxc.enable = true;

  ### TMP ######################################################################
  # TODO: fix firewall restriction on mullvad vpn (wireguard)
  #networking.firewall.enable = false;

}
