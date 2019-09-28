{ config, pkgs, ... }:

let
  secret = import ../../../../secrets.nix {};
  hostname = "${secret.nextcloud.hostname}.${secret.home.domain}";
in {
  services.nextcloud = {
    enable = true;
    https = true;
    hostName = hostname;
    nginx.enable = true;
    home = "/data/www/${hostname}/nextcloud";
    autoUpdateApps.enable = true;
    config = {
      dbtype = "pgsql";
      dbname = "nextcloud";
      dbuser = "nextcloud";
      dbpass = secret.nextcloud.dbpass;
      adminuser = "admin";
      adminpass = secret.nextcloud.adminpass;
    };
  };

  services.nginx.virtualHosts."${hostname}" = {
    # enable Let's Encrypt
    enableACME = true;
    forceSSL = true;
    # security
    # ref: https://docs.nextcloud.com/server/15/admin_manual/installation/harden_server.html
    extraConfig = ''
    add_header Strict-Transport-Security "max-age=31536000" always;
    '';
  };

  services.postgresql = {
    enable = true;
    dataDir = "/data/www/${hostname}/postgres";
    initialScript = pkgs.writeText "psql-init" ''
      CREATE ROLE ${config.services.nextcloud.config.dbuser} WITH PASSWORD '${config.services.nextcloud.config.dbpass}' LOGIN;
      CREATE DATABASE ${config.services.nextcloud.config.dbname} WITH OWNER ${config.services.nextcloud.config.dbuser};
    '';
  };

  # ensure that postgres is running *before* running the setup
  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];
  };
}
