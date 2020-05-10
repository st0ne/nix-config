{ ... }:

let
  creds = import ./secrets/creds.nix;
in
{
  imports = [ ../. ];
  users.users.syssec = import ./user.nix;
}
