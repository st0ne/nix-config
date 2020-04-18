{ config, lib, pkgs, ... }:


{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    # profiles
    ../../../nixos/profiles
  ];

  boot.kernelModules = [ "kvm-intel" "wl" ];
  boot.extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "firewire_ohci" "usb_storage" "sd_mod" "sdhci_pci" ];
  nixpkgs.config.allowUnfree = true;

  hostname = "mini";
  bootloader = {
    enable = true;
    efi = true;
    device = "/dev/sda2";
  };

  profiles = {
    headless = {
      enable = true;
      ssh = {
        enable = true;
        avahi = true;
      };
    };
    fstab.zfs.enable = true;
  };

  system.stateVersion = "20.03";
  nix.maxJobs = 8;
}
