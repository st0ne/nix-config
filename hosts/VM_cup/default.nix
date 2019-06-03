{ ... }:

let
  secret = import ../../secrets.nix {};
in

{
  imports =
    [ <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
    # profile
    ../../profiles/headless.nix
    # overlays
    ../../overlays/bios-grub.nix
    # users
    ../../users/sylv.nix
    ];

  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk" ];

  ### GENERAL ##################################################################
  general.name = "cup";
  boot.loader.grub.device = "/dev/vda";
  general.boot.encryptData = false;

  system.stateVersion = "18.09";
  nix.maxJobs = 2;
  deployment.targetHost = secret.cup.domain;
}