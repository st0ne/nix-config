let
  secrets = import ./home_crypt.nix;
  ncDomain = secrets.apu.services.nextcloud.domain;
in
{
  defaults = {
    imports = [ ./. ];
  };

  network = {
    description = "home server setup";
    enableRollback = false;
  };

  apu = { lib, ... }:
  {
    # base config
    imports = [
      # configuration
      ../hosts/server/apu/configuration.nix
      # nextcloud
      ./services/nginx-nextcloud.nix
    ];
    networking = secrets.apu.networking;
    #containers.nextcloud = import ../nixos/containers/nixos/nginx-nextcloud.nix  {setup = secrets.apu.services.nextcloud; } //
    #{
    #  autoStart = true;
    #  # BUG:
    #  config.security.acme.email = lib.mkForce "sylv@sylv.io";
    #  config.security.acme.acceptTerms = lib.mkForce true;
    #  config.security.acme.certs."${ncDomain}".webroot = lib.mkForce null;
    #};

    docker-containers = {
      #nextcloud-app = import ../nixos/containers/docker/nextcloud/app.nix { setup = secrets.apu.services.nextcloud; };
      #nextcloud-db = import ../nixos/containers/docker/nextcloud/db.nix { setup = secrets.apu.services.nextcloud; };
    };
  };
}
