let
  creds = import ./secrets/creds.nix;
in
{
  isNormalUser = true;
  home = "/home/sylv";
  description = "Marcello Sylvester Bauer";
  createHome = true;
  shell = "/run/current-system/sw/bin/bash";
  uid = 1337;
  group = "users";
  initialHashedPassword = creds.hashedPassword;
  openssh.authorizedKeys.keys = creds.authorizedKeys;
}
