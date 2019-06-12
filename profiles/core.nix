{ config, lib, pkgs, ... }:

# core definition of any host
{
  imports = 
  [
    ../config # import custom options
  ];
    
  boot = {
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    cleanTmpDir = lib.mkDefault true;
    tmpOnTmpfs = lib.mkDefault true;
    kernelParams = [
      # old ifnames (e.g. eth0, wlan0)
      "net.ifnames=0"
    ];
  };

  # console
  i18n = {
    consoleFont = lib.mkDefault "Lat2-Terminus16";
    consoleKeyMap = lib.mkDefault "us";
    defaultLocale = lib.mkDefault "en_US.UTF-8";
  };

  # timezone
  time.timeZone = lib.mkDefault "Europe/Berlin";

  # hostname
  networking.hostName = config.host.name;

  # vim as default editor
  programs.vim.defaultEditor = true;

  environment.systemPackages = with pkgs; [
    ## core
    curl rsync screen tree dhcpcd
  ];
}