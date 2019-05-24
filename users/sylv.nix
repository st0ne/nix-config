{ ... }:

let
  secret = import ./sylv_secret.nix {};
in
{
  users.users.sylv = {
    isNormalUser = true;
    home = "/home/sylv/";
    description = "Marcello Sylvester Bauer";
    createHome = true;
    shell = "/run/current-system/sw/bin/zsh";
    uid = secret.uid;
    group = "users";
    initialHashedPassword = secret.initialHashedPassword;
    openssh.authorizedKeys.keys = secret.authorizedKeys.keys;
  };
}
