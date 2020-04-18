let
  secrets = import ./home_crypt.nix;
  ncDomain = secrets.apu.services.nextcloud.domain;
  configKeys = let
    keys = (import ../users/sylv/secrets/creds.nix {}).authorizedKeys;
  in
  { users.users.root.openssh.authorizedKeys.keys = keys; };
in
{
  defaults = {
    imports = [ ./. ];
  };

  network = {
    description = "home server setup";
    enableRollback = false;
  };

  apu = { ... }:
  {
    imports = [
      ../hosts/server/apu/configuration.nix
      ./services/nginx-nextcloud.nix
    ];
    networking = secrets.apu.networking;
  } // configKeys;

  mini = { ... }:
  {
    imports = [
      ../hosts/desktop/mini/configuration.nix
    ];
    networking = secrets.mini.networking;
  } // configKeys;
}
