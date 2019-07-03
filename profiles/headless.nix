{ config, lib, ... }:

# Profile for headless server.

{
  imports = [];

  # enable serial console
  boot = lib.mkIf config.host.serial.enable {
    kernelParams = [
      "console=${config.host.serial.device},${toString config.host.serial.baud}n8"
    ];
    loader.grub.extraConfig = "
      serial --speed=${toString config.host.serial.baud} --unit=0 --word=8 --parity=no --stop=1
      terminal_input serial
      terminal_output serial
    ";
  };

  # enable sshd
  services.openssh = lib.mkIf config.host.ssh {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "prohibit-password";
    challengeResponseAuthentication = false;
  };
}