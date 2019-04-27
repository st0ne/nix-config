{ lib, ... }:

{
  services.xserver = {
    libinput = {
      enable = lib.mkDefault true;
      accelSpeed = "1";
      tapping = false;
    };
    config = lib.mkAfter
''
# BUG: libinput does not catch trackpoint
Section "InputClass"
        Identifier "libinput pointer catchall"
        MatchIsPointer "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
        Option "AccelSpeed" "1"
EndSection
'';
  };
}
