let
  secrets = import ./home_crypt.nix;
  configKeys = let
    keys = (import ../users/sylv/secrets/creds.nix).authorizedKeys;
  in
    { users.users.root.openssh.authorizedKeys.keys = keys; };

  guestDashboard = "dashboard.guest.${secrets.domains.local}";

in
{
  defaults = {
    imports = [ ./. ];
  };

  network = {
    description = "home network setup";
    enableRollback = false;
  };

  apu = { ... }:
    configKeys // {
      imports = [
        ../hosts/server/apu/configuration.nix
        ../users/sylv
      ];

      networking = secrets.hosts.apu.networking;

      users.users.sylv.extraGroups = [
        "dialout"
      ];
    };

  mini = { lib, pkgs, ... }:
    let
      toYAML = name: attrs: pkgs.runCommandNoCC name {
        preferLocalBuild = true;
        json = builtins.toFile "${name}.json" (builtins.toJSON attrs);
        nativeBuildInputs = [ pkgs.remarshal ];
      } ''
        mkdir $out
        json2yaml -i $json -o $out/${name}'';
    in
      configKeys // {
        imports = [
          ../hosts/desktop/mini/configuration.nix
          ./services/nginx-nextcloud.nix
        ];

        networking = secrets.hosts.mini.networking;

        services.nginx = {
          recommendedTlsSettings = true;
          recommendedOptimisation = true;
          recommendedGzipSettings = true;
          recommendedProxySettings = true;

          virtualHosts."${guestDashboard}" = {
            root = pkgs.homer;
            enableACME = true;
            forceSSL = true;
            locations = {
              "= /config.yml" = {
                root = with secrets.domains; toYAML "config.yml" (import ./dashboard/guest.nix { inherit local cloud; });
              };
            };
          };
        };
        security.acme = with secrets.acme; {
          inherit acceptTerms email;
          certs = let
            ncfg = secrets.services.nextcloud;
          in
            {
              # nextcloud
              "${ncfg.domain}" = rec {
                inherit dnsProvider;
                extraDomains = lib.attrsets.genAttrs ncfg.extraTrustedDomains (name: null);
                webroot = lib.mkForce null;
                credentialsFile = /data/host/acme + "/${dnsProvider}-api-token";
              };
              "${guestDashboard}" = rec {
                inherit dnsProvider;
                webroot = lib.mkForce null;
                credentialsFile = /data/host/acme + "/${dnsProvider}-api-token";
              };
            };
        };
      };
}
