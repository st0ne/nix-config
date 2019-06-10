{ config, lib, ... }:

# Profile for portable Devices.

{
  imports = [
    ./base.nix
  ];

  # enable serial console
  boot.kernelParams = [
    "console=ttyS0,115200n8"
  ];
  boot.loader.grub.extraConfig = "
    serial --speed=115200 --unit=0 --word=8 --parity=no --stop=1
    terminal_input serial
    terminal_output serial
  ";

  # enable sshd
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "prohibit-password";
    challengeResponseAuthentication = false;
  };
}