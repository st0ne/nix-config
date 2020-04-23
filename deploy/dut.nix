let
  secrets = import ./dut_crypt.nix;
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

  fuzzer = { ... }:
  {
    imports = [
      ../hosts/server/apu/configuration.nix
    ];
    networking = secrets.hosts.fuzzer.networking;
  } // {hostname = "syssec-fuzzer";} // configKeys;
}
