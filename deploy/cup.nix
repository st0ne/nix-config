let
  secret = import ../secrets.nix {};
in

{
  network.description = "${secret.cup.domain} netcup server";

  cup = import ../hosts/VM_cup/default.nix;
}
