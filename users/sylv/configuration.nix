{ pkgs, ... }:

let
  creds = import ./secrets/creds.nix {};
in
{
  imports =[ ../. ];
  environment.systemPackages = with pkgs;[ home-manager git-crypt ];
  users.users.sylv = {
    isNormalUser = true;
    home = "/home/sylv";
    description = "Marcello Sylvester Bauer";
    createHome = true;
    shell = "/run/current-system/sw/bin/bash";
    uid = 1337;
    group = "users";
    initialHashedPassword = creds.initialHashedPassword;
    openssh.authorizedKeys.keys = creds.authorizedKeys;
  };
}
