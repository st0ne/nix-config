{ config, pkgs, lib, ... }:

# Profile for portable Devices.

{
  imports = [
    ./desktop.nix
  ];

  # powermanagement
  powerManagement = {
    cpuFreqGovernor = lib.mkDefault "powersave";
    powertop.enable = lib.mkDefault true;
  };
  services.tlp.enable = lib.mkDefault true;

  # mutable timezone
  time.timeZone = null;

  # use geoclue
  location.provider = "geoclue2";
}
