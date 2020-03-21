{ config, lib, ... }:

{
  # choose a bigger font for the system console
  i18n.consoleFont = "latarcyrheb-sun32";
  boot.loader.grub.gfxmodeEfi = "1024x768";
}
