{ config, lib, ... }:

{
  # choose a bigger font for the system console
  console.font = "latarcyrheb-sun32";
  boot.loader.grub.gfxmodeEfi = "1024x768";
}
