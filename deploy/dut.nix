let
  secrets = import ./dut_crypt.nix;
  keys = (import ../users/sylv/secrets/creds.nix).authorizedKeys;
in
{
  defaults = {
    imports = [ ./. ];
  };

  network = {
    description = "Device Under Test network setup";
    enableRollback = false;
  };

  fuzzer = { pkgs, ... }:
  {
    imports = [
      ../hosts/server/apu/configuration.nix
      ../users/sylv
      ../users/syssec
    ];

    networking = secrets.hosts.fuzzer.networking;

    hostname = "syssec-fuzzer";
    users.users.syssec.extraGroups = [
      "dialout"
      "jlink"
    ];
    users.users.root.openssh.authorizedKeys.keys = keys;
    environment.interactiveShellInit  = ''
      export PATH=$HOME/bin:$PATH
      '';
    users.motd = secrets.fuzzerMotd;
    users.groups."jlink" = {};
    services.udev.extraRules = ''
      # SEGGER J-Link PLUS
      SUBSYSTEM=="usb", ATTR{idVendor}=="1366", ATTR{idProduct}=="0101", MODE="0660", GROUP="jlink"
    '';
    services.avahi = {
      enable = true;
      nssmdns = true;
      ipv6 = true;
    };
    environment.systemPackages = with pkgs; [
      (python3.withPackages (ps: with ps; [ python3Packages.gpiozero python3Packages.pigpio]))
      jlink
    ];
  };
}
