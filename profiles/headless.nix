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

  # enable sshd
  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    permitRootLogin = "prohibit-password";
    challengeResponseAuthentication = false;
  };
}