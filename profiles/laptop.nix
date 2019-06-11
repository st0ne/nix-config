{ config, lib, ... }:

# Profile for portable Devices.

{
  imports = [
    ./desktop/default.nix
  ];

  # powermanagement
  powerManagement = {
    cpuFreqGovernor = lib.mkDefault "powersave";
    powertop.enable = lib.mkDefault true;
  };
  services.tlp.enable = lib.mkDefault true;
}
