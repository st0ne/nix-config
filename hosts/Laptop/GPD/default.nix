{ config, lib, pkgs, ... }:

{
  imports =
    [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    # profile
    ../../../profiles/laptop.nix
    ../../../profiles/modules/config.nix
    ../../../profiles/pkgs/personal.nix
    ../../../profiles/fstab/zfs.nix
    # modules
    ../../../modules/hardware/cpu/intel
    ../../../modules/hardware/gpu/intel
    ../../../modules/hardware/vendor/GPD
    ../../../modules/hardware/devices/yubikey.nix
    ../../../modules/hardware/devices/pcscd.nix
    ../../../modules/networking/wireguard.nix
    ../../../modules/wayland/sway.nix
    # overlays
    ../../../overlays/intel-vaapi.nix
    # users
    ../../../users/sylv/default.nix
  ];

  ### GENERAL ##################################################################
  host.name = "GPD";
  host.boot.default = true;
  host.boot.efi = true;
  host.boot.device = "/dev/sda1";
  networking.hostId = "dead1337";

  system.stateVersion = "19.09";
  nix.maxJobs = 4;

  ### INIT #####################################################################
  boot = {
    initrd.luks.devices."${config.host.name}" = {
      device = "/dev/sda2";
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

  boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "usb_storage" "usbhid" "sd_mod" "sdhci_pci" ];
  boot.kernelParams = [ "intel_iommu=on" ];

  ### USER #####################################################################
  users.users.sylv.extraGroups = [
    "wheel" # privileged user
    "networkmanager" # manage network
    "video" # hardware acceleration access
    "dialout" # allow serial console access
    "kvm" #libvirt user session
  ];

}
