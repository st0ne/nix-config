{ ... }:

let
  secret = import ../../secrets.nix {};
in

{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    # profile
    ../../profiles/headless.nix
    # modules
    ../../modules/hardware/cpu/amd/default.nix
    # overlays
    ../../overlays/bios-grub.nix
    # users
    ../../users/sylv.nix
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "ehci_pci" "sd_mod" "sdhci_pci" ];

  ### GENERAL ##################################################################
  general.name = "gate";
  boot.loader.grub.device = "/dev/sda";
  general.boot.encryptData = false;

  system.stateVersion = "18.09";
  nix.maxJobs = 4;
  deployment.targetHost = secret.gate.domain;

  ### NETWORK ##################################################################

  networking = {
    useDHCP = false;
    dhcpcd.extraConfig =
    ''
    # disable IPv6
    noipv6

    # prioritize lan_private interface
    interface wan
    metric 999
    interface lan_private
    metric 137
    '';
    interfaces = {
      eth0 = {
      };
      eth1 = {
      };
      eth2 = {
      };
      wan = {
        useDHCP = true;
      };
      lan_private = {
        useDHCP = true;
      };
    };
    vlans = {
      wan = {
        id = 2;
        interface = "eth1";
      };
      lan_private = {
        id = 3;
        interface = "eth2";
      };
    };
  };
}
