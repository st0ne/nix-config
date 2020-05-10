{ config, lib, pkgs, ... }:

{
  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
      # profile
      ../../../nixos/profiles/laptop.nix
      ../../../nixos/profiles/fstab/zfs.nix
      # modules
      ../../../nixos/configs/hardware/cpu/intel
      ../../../nixos/configs/hardware/gpu/intel/vaapi.nix
      ../../../nixos/configs/hardware/vendor/GPD
      ../../../nixos/configs/hardware/devices/yubikey.nix
      ../../../nixos/configs/hardware/devices/pcscd.nix
      ../../../nixos/configs/networking/wireguard/mullvad.nix
      ../../../nixos/configs/wayland/sway.nix
      ../../../nixos/configs/virtualisation/libvirtd.nix
      # users
      ../../../users/sylv/configuration.nix
    ];

  ### GENERAL ##################################################################
  custom.hostname = "GPD";
  custom.boot.efi = true;
  custom.boot.device = "/dev/sda1";
  networking.hostId = "dead1337";

  system.stateVersion = "19.09";
  nix.maxJobs = 4;

  ### INIT #####################################################################
  boot = {
    initrd.luks.devices."${config.hostname}" = {
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
    "libvirtd" # manage libvirt vms
  ];

}
