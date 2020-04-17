{ config, pkgs, ... }:


{
  imports = [
  <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
  # profile
  ../../../nixos/profiles
  ];

  ### INIT #####################################################################
  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk" ];

  ### GENERAL ##################################################################

  hostname = "cup";
  bootloader = {
    enable = true;
    efi = false;
    device = "/dev/vda";
  };
  profiles = {
    headless = {
      enable = true;
      ssh = {
        enable = true;
      };
      serial.enable = true;
    };
    fstab.zfs.enable = true;
  };
  system.stateVersion = "20.03";
  nix.maxJobs = 2;

}
