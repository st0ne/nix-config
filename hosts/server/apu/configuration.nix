{ config, lib, pkgs, ... }:

let

  creds = import ../../../users/sylv/secrets/creds.nix {};

in


{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    # profiles
    ../../../nixos/profiles
    # configs
    ../../../nixos/configs/hardware/cpu/amd
  ];
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "ehci_pci" "usb_storage" "sd_mod" "sdhci_pci" ];

  ### GENERAL ##################################################################

  hostname = "apu";
  bootloader = {
    enable = true;
    efi = false;
    device = "/dev/sda";
  };

  profiles = {
    headless = {
      enable = true;
      ssh = {
        enable = true;
        avahi = true;
      };
      serial.enable = true;
    };
    fstab.zfs.enable = true;
  };

  system.stateVersion = "20.03";
  nix.maxJobs = 4;

  users.users.root.openssh.authorizedKeys.keys = creds.authorizedKeys;
}