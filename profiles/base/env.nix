{ config, lib, ... }:

{
  # console
  i18n = {
    consoleFont = lib.mkDefault "Lat2-Terminus16";
    consoleKeyMap = lib.mkDefault "us";
    defaultLocale = lib.mkDefault "en_US.UTF-8";
  };

  # timezone
  time.timeZone = lib.mkDefault "Europe/Berlin";

  # hostname
  networking.hostName = config.general.name;

  # vim as default editor
  programs.vim.defaultEditor = true;
}