{ pkgs, ... }:

let
  secret = import ../../secrets.nix {};
in
{
  environment.systemPackages = with pkgs; [ home-manager ];
  users.users.sylv = {
    isNormalUser = true;
    home = "/home/sylv";
    description = "Marcello Sylvester Bauer";
    createHome = true;
    shell = "/run/current-system/sw/bin/bash";
    uid = 1337;
    group = "users";
    initialHashedPassword = secret.sylv.initialHashedPassword;
    openssh.authorizedKeys.keys = secret.sylv.authorizedKeys.keys;
  };
}
