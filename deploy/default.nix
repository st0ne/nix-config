{ config, lib, ... }:

{
  imports = [
    # fix
    ./fix/binfmt_misc-unit.nix
  ];

  # system was deployed (custom option)
  deployed = true;
  # override default with FQDN
  deployment.targetHost = lib.mkOverride 10 "${config.networking.hostName}.${config.networking.domain}";
}
