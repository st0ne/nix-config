{ config, ... }:

let
  secret = import ../../../secrets.nix {};
in

{
  imports =
    [ <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
    #./webservices.nix
    # profile
    ../../../profiles/minimal.nix
    ../../../profiles/headless.nix
    # users
    ../../../users/sylv.nix
    # services
    ./web-services/nginx.nix
    ./web-services/nextcloud.nix
    ];

  ### INIT #####################################################################
  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "virtio_pci" "sr_mod" "virtio_blk" ];

  ### GENERAL ##################################################################
  host.name = "cup";
  host.domain = secret.sylv.domain;
  host.boot.device = "/dev/vda";

  system.stateVersion = "18.09";
  nix.maxJobs = 2;
  deployment.targetHost = "${config.host.name}.${config.host.domain}";
  networking = secret.cup.networking;

  ### Headless #################################################################
  host.serial = {
    enable = true;
    device = "ttyS0";
    baud = 115200;
  };
  host.ssh = true;

}
