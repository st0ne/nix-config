let
  creds = import ./secrets/creds.nix;
in
{
  isNormalUser = true;
  home = "/home/syssec";
  description = "Chair for System Security";
  createHome = true;
  shell = "/run/current-system/sw/bin/bash";
  uid = 2439; #ID 2/439
  group = "users";
  hashedPassword = creds.hashedPassword;
  openssh.authorizedKeys.keys = creds.authorizedKeys;
}
