{ config, ... }:

let
  secret = import ../../../secrets.nix {};
in

{
  imports =
    [ <nixpkgs/nixos/modules/profiles/qemu-guest.nix>
    #./webservices.nix
    # profile
    ../../../profiles/default.nix
    ../../../profiles/pkgs/minimal.nix
    ../../../profiles/modules/headless.nix
    # users
    ../../../users/sylv
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

  system.stateVersion = "19.09";
  nix.maxJobs = 2;
  deployment.targetHost = "${config.host.name}.${config.host.domain}";
  networking = secret.cup.networking;

  ### AUTOMATION ###############################################################
  # auto update
  system.autoUpgrade = {
    enable = false;
    channel = "https://nixos.org/channels/nixos-unstable";
    dates = "Sun *-*-* 04:20:00";
  };
  #auto garbage collect
  nix.gc = {
    automatic = false;
    dates = "Sun *-*-* 05:00:00";
    options = "--delete-older-than 1m";
  };

  ### Headless #################################################################
  host.serial = {
    enable = true;
    device = "ttyS0";
    baud = 115200;
  };
  host.ssh = true;

  programs.mosh.enable= true;

  ### IRC ######################################################################
  users.users.sylv.extraGroups = [ "weechat" ];
  services.weechat.enable = true;
  programs.screen.screenrc = ''
    multiuser on
    acladd sylv
  '';
}
