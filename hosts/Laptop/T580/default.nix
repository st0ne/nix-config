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
    ../../../profiles/fstab/lvm.nix
    ../../../profiles/pkgs/personal.nix
    # modules
    ../../../modules/hardware/cpu/intel
    ../../../modules/hardware/thinkpad
    ../../../modules/hardware/devices/pcscd.nix
    ../../../modules/hardware/devices/yubikey.nix
    ../../../modules/networking/wireguard.nix
    ../../../modules/virtualisation/libvirtd.nix
    ../../../modules/xserver/window-managers/i3.nix
    # overlays
    ../../../overlays/HiDPI.nix
    ../../../overlays/no-nvidia.nix
    ../../../overlays/intel-vaapi.nix
    ../../../overlays/xorg-no-sleep.nix
    # users
    ../../../users/sylv/full.nix
    # shells
    ../../../shells
  ];

  ### INIT #####################################################################
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  boot.kernelParams = [ "i915.enable_psr=0" "i915.enable_guc=2" ];

  ### GENERAL ##################################################################
  host.name = "T580";
  host.boot.efi = true;
  host.boot.device = "/dev/nvme0n1p1";
  host.boot.encryptData = true;
  host.boot.encryptHome = true;
  host.dpi = 192;

  system.stateVersion = "19.09";
  nix.maxJobs = 8;

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
  services = {
    # custom configuration
    xserver = {
      # fallback gnome
      desktopManager.gnome3.enable = true;
    };
    compton = {
      enable = true;
      vSync = true;
    };
  };
  # hide mouse
  services.unclutter = {
    enable = true;
  };

  ### POWER MANAGEMENT #########################################################
  services.tlp.extraConfig = ''
    START_CHARGE_THRESH_BAT0=60
    STOP_CHARGE_THRESH_BAT0=90
    START_CHARGE_THRESH_BAT1=60
    STOP_CHARGE_THRESH_BAT1=90
  '';

  ### VIRTUALISATION ###########################################################
  virtualisation.docker.enable = true;

  ### VPN ######################################################################

  ### TMP ######################################################################
  # TODO: fix firewall restriction on mullvad vpn  (wireguard)
  networking.firewall.enable = false;
}
