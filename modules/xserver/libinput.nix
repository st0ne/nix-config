{ lib, ... }:

{
  services.xserver.libinput = {
    enable = lib.mkDefault true;
    accelSpeed = lib.mkDefault "1";
    tapping = lib.mkDefault false;
  };
}
