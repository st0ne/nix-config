{ pkgs, config, ... }:
# disable CPU vulnerability mitigations that have a negative performance impact on the system
let
  cmdline = builtins.readFile (
    builtins.fetchurl "https://make-linux-fast-again.com"
  );
in
{
  boot.kernelParams = pkgs.lib.splitString " " cmdline;
}
