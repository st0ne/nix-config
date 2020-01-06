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
  # info: cpuFreqGovernor is null, if tlp is enabled
  services.tlp = {
    enable = lib.mkDefault true;
    extraConfig = ''
      CPU_SCALING_GOVERNOR_ON_AC=performance
      CPU_SCALING_GOVERNOR_ON_BAT=powersave
      '';
    };
  networking.networkmanager.wifi.powersave = true;

  # mutable timezone
  time.timeZone = null;

  # use geoclue
  location.provider = "geoclue2";
}
