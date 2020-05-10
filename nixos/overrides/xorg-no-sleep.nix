{ lib, ... }:

# disable default xorg blank/sleep/suspend time

{
  services.xserver.serverFlagsSection = lib.mkAfter
    ''
      ### overlays/xorg-no-sleep.nix
      Option "BlankTime" "0"
      Option "StandbyTime" "0"
      Option "SuspendTime" "0"
      Option "OffTime" "0"
    '';
}
