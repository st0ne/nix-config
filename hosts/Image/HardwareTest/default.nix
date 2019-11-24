{config, pkgs, ...}:

let
  secret = import ../../../secrets.nix {};
in
  {
    imports = [
      <nixpkgs/nixos/modules/installer/cd-dvd/iso-image.nix>
      <nixpkgs/nixos/modules/installer/cd-dvd/channel.nix>

      ../../../profiles/modules/headless.nix
    ];

    isoImage = {
      makeEfiBootable = true;
      makeUsbBootable = true;
    };

    host.serial = {
      enable = true;
      device = "ttyS0";
      baud = 115200;
    };
    host.ssh = true;
    services.openssh.permitRootLogin = "yes";
    users.users.root = {
      initialPassword = "oscar";
      openssh.authorizedKeys.keys = secret.sylv.authorizedKeys.keys;
    };

    environment.systemPackages = with pkgs; [
      # interaction
      vim
      # Hardware utils
      pciutils usbutils coreboot-utils dmidecode ipmitool lm_sensors
      # TPM
      tpm-tools tpm2-tools
      # Testing
      fwts
    ];
  }
