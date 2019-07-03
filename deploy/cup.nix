let
  secret = import ../secrets.nix {};
in

{
  network.description = "${secret.sylv.domain} netcup server";

  cup = import ../hosts/Server/cup;
}
