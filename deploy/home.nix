let

  network = import ./home_network_crypt.nix;

in
{
  defaults = {
    imports = [ ./. ];
  };

  network = {
    description = "home server setup";
    enableRollback = false;
  };

  apu = {
    imports = [ ../hosts/server/apu/configuration.nix ];
    networking = network.apu;
  };
}
