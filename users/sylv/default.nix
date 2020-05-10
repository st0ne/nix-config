{ pkgs, ... }:

let
  creds = import ./secrets/creds.nix;
in
{
  imports = [ ../. ];
  environment.systemPackages = with pkgs;[ home-manager git-crypt ];
  users.users.sylv = import ./user.nix;
}
