{ config, pkgs, ... }:

{
  # rotate main screen
  boot.kernelParams = [ "video=efifb" "fbcon=rotate:1" ];
  services.xserver.xrandrHeads = [
    {
      output = "DSI-1";
      monitorConfig = ''
      Option "Rotate" "right"
      '';
    }
    {
      output = "DSI1";
      monitorConfig = ''
      Option "Rotate" "right"
      '';
    }
  ];
  # enable button scrolling
  services.xserver.config = ''
    Section "InputClass"
      Identifier "AMR-4630-XXX-0- 0-1023 USB KEYBOARD Mouse"
      Option "AccelSpeed" "1"
      Option "ScrollMethod" "button"
      Option "MiddleEmulation" "on"
    EndSection
    '';
  # disable power management for touchpad and audio speakers
  services.tlp.extraConfig = ''
    USB_BLACKLIST="6080:8061"
    SOUND_POWER_SAVE_ON_AC=0
    SOUND_POWER_SAVE_ON_BAT=0
    SOUND_POWER_SAVE_CONTROLLER=N
  '';
  powerManagement.powertop.enable = false;
}
