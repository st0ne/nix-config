{ config, pkgs, ... }:

{
  imports =
    [
      <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
      # profile
      ../../../profiles/desktop.nix
      ../../../profiles/fstab/lvm.nix
      ../../../profiles/pkgs/personal.nix
      # modules
      ../../../modules/hardware/cpu/amd
      # overlays
      ../../../overlays/HiDPI.nix
      ../../../overlays/xorg-no-sleep.nix
      # users
      ../../../users/sylv.nix
    ];

  ### INIT #####################################################################
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];

  ### GENERAL ##################################################################
  host.name = "ryz";
  host.boot.efi = true;
  host.boot.device = "/dev/nvme0n1p2";
  host.dpi = 192;

  system.stateVersion = "19.03";
  nix.maxJobs = 16;

  ### USER #####################################################################
  users.users.sylv.extraGroups = [
    "wheel"
    "networkmanager"
    "video"
    "docker"
  ];
}
