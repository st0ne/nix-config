{ config, lib, ... }:

{
  imports = [
    # fix
    ./fix/binfmt_misc-unit.nix
  ];

  # system was deployed (custom option)
  deployed = true;
  # add specific overlays
  # ref: https://github.com/NixOS/nixops/issues/893
  nixpkgs.overlays = [ (import ../overlays/python_overlay.nix) (import ../overlays/pkgs_overlay.nix) ];
  # allow unfree
  nixpkgs.config.allowUnfree = true;
  # override default with FQDN
  deployment.targetHost = lib.mkOverride 10 "${config.networking.hostName}.${config.networking.domain}";
}
