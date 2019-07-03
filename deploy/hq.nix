let
  secret = import ../secrets.nix {};
in

{
  network.description = "${secret.hq.domain} network";

  gate = import ../hosts/VM_cup/default.nix;
}
