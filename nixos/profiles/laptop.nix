{ config, pkgs, lib, ... }:

with lib;

let

  cfg = config.profiles.laptop;

  # cloudflare DNS
  fallbackDns = [
    "1.1.1.1"
    "1.0.0.1"
    "2606:4700:4700::1111"
    "2606:4700:4700::1001"
  ];

in

{
  options = {
    profiles.laptop = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };
    };
  };

  config = mkIf cfg.enable {

    # enable parent profile
    profiles.desktop.enable = true;

    ### NETWORKING #############################################################
    # systemd-resolved
    services.resolved = {
      enable = mkDefault true;
      llmnr = "false";
      inherit fallbackDns;
    };

    ### POWERMANAGEMENT ########################################################
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
    networking.networkmanager.wifi.powersave = mkDefault true;

    ### TIMEZONE ###############################################################
    # mutable timezone
    time.timeZone = null;
    # use geoclue
    location.provider = "geoclue2";
  };
}
