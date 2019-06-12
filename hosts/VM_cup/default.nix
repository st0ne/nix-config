{ ... }:

let
  secret = import ../../secrets.nix {};
in

{
  imports =
    [ <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
    # profile
    ../../profiles/base/default.nix
    ../../profiles/headless.nix
    # overlays
    ../../overlays/bios-grub.nix
    # users
    ../../users/sylv.nix
    ];

  ### INIT #####################################################################
  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk" ];

  ### GENERAL ##################################################################
  host.name = "cup";
  boot.loader.grub.device = "/dev/vda";
  host.boot.encryptData = false;

  system.stateVersion = "18.09";
  nix.maxJobs = 2;
  deployment.targetHost = secret.cup.domain;
}
