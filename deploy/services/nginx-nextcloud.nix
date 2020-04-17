{ config, lib, pkgs, ... }:
let
  setup = (import ../home_crypt.nix).apu.services.nextcloud;
  domain = setup.domain;
  dnsProvider = setup.dnsProvider;
  app = {
    adminpassFile = "";
  };
  db = {
    name = setup.postgres.name;
    user = setup.postgres.user;
    pass = setup.postgres.pass;
  };
in
{
  security.acme = {
    acceptTerms = true;
    certs."${domain}" = rec {
      inherit dnsProvider;
      email = "sylv@sylv.io";
      webroot = lib.mkForce null;
      credentialsFile  = /data/host/acme + "/${domain}-${dnsProvider}-api-token";
    };
  };

  services.nextcloud = {
    enable = true;
    home = "/data/www/${domain}/nextcloud/app";
    https = true;
    hostName = domain;
    nginx.enable = true;
    autoUpdateApps.enable = true;
    config = {
      adminpassFile = app.adminpassFile;
      dbtype = "pgsql";
      dbname = db.name;
      dbuser = db.user;
      dbpass = db.pass;
    };
  };

  services.postgresql = {
    enable = true;
    dataDir = "/data/www/${domain}/nextcloud/db";
    package = pkgs.postgresql_9_6;
    initialScript = pkgs.writeText "psql-init" ''
      CREATE ROLE ${config.services.nextcloud.config.dbuser} WITH PASSWORD '${config.services.nextcloud.config.dbpass}' LOGIN;
      CREATE DATABASE ${config.services.nextcloud.config.dbname} WITH OWNER ${config.services.nextcloud.config.dbuser};
    '';
  };

  services.nginx = {
    enable = true;
    # only recommendedProxySettings and recommendedGzipSettings are strictly required,
    # but the rest make sense as well
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;

    appendHttpConfig = ''
      ### redirect www subdomain
      server {
        server_name www.${domain};
        # listen on ipv4
        listen 443 ssl http2;
        # listen on ipv6
        listen [::]:443 ssl http2;
        return 301 https://${domain};
      }
    '';
    virtualHosts."${domain}" = {
      # enable Let's Encrypt
      enableACME = true;
      forceSSL = true;
      # security
      # ref: https://docs.nextcloud.com/server/15/admin_manual/installation/harden_server.html
      extraConfig = ''
      add_header Strict-Transport-Security "max-age=31536000" always;
      '';
    };
  };

  # ensure that postgres is running *before* running the setup
  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];
  };
}
