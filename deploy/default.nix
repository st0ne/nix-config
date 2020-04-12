{ config, lib, ... }:

{
  imports = [
    # fix
    ./fix/binfmt_misc-unit.nix
  ];

  # override default with FQDN
  deployment.targetHost = lib.mkOverride 10 "${config.networking.hostName}.${config.networking.domain}";
}
