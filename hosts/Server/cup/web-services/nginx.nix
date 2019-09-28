{ config, lib, pkgs, ... }:

let
  secret = import ../../../../secrets.nix {};
  ### redirect www subdomain
  configRedirectWWW = ''
    server {
    server_name www.${secret.sylv.domain};
      # listen on ipv4
    listen 443 ssl http2;
      # listen on ipv6
      listen [::]:443 ssl http2;
      return 301 https://${secret.sylv.domain};
    }
  '';
in {
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.nginx = {
    enable = true;
    # only recommendedProxySettings and recommendedGzipSettings are strictly required,
    # but the rest make sense as well
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;

    appendHttpConfig = ''
      ${configRedirectWWW}
    '';

    virtualHosts = {
      "${secret.sylv.domain}" = {
        enableACME = true;
        forceSSL = true;
        locations."/".extraConfig = ''
          return 200;
        '';
      };
    };
  };
}
