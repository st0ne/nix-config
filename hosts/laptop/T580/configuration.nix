{ config, lib, pkgs, ... }:

## main personal Laptop
# Lenovo Thinkpad T580
# CPU: i7-8550U
# iGPU: Intel UHD Graphics 620 (active)
# dGPU: NVIDIA GeForce MX150 (inactive)
# Display: 15.6" UHD (3840 x 2160)

{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    # profile
    ../../../nixos/profiles/laptop.nix
    ../../../nixos/profiles/fstab/zfs.nix
    # configs
    ../../../nixos/configs/hardware/cpu/intel
    ../../../nixos/configs/hardware/gpu/intel/vaapi.nix
    ../../../nixos/configs/hardware/vendor/thinkpad
    ../../../nixos/configs/hardware/storage/nvme.nix
    ../../../nixos/configs/hardware/devices/pcscd.nix
    ../../../nixos/configs/hardware/devices/yubikey.nix
    ../../../nixos/configs/networking/wireguard
    ../../../nixos/configs/virtualisation/libvirtd.nix
    ../../../nixos/configs/wayland/sway.nix
    # overrides
    ../../../nixos/overrides/no-nvidia.nix
    ../../../nixos/overrides/HiDPI.nix
    # users
    ../../../users/sylv/configuration.nix
  ];

  ### GENERAL ##################################################################
  custom.hostname = "T580";
  custom.boot.efi = true;
  custom.boot.device = "/dev/nvme0n1p1";
  networking.hostId= "13dead37";

  system.stateVersion = "19.09";
  nix.maxJobs = 8;

  ### INIT #####################################################################
  boot = {
    initrd.luks.devices."${config.custom.hostname}" = {
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
    "kvm" #libvirt user session
    #"docker" # allow direct docker api access (Warning: The docker group grants
    # privileges equivalent to the root user.
    # [https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface)
  ];

  ### POWER MANAGEMENT #########################################################
  services.tlp.extraConfig = ''
    START_CHARGE_THRESH_BAT0=60
    STOP_CHARGE_THRESH_BAT0=90
    START_CHARGE_THRESH_BAT1=60
    STOP_CHARGE_THRESH_BAT1=90
  '';

  ### VIRTUALISATION ###########################################################
  virtualisation.docker.enable = true;
}
