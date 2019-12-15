{ config, lib, ... }:

# persistent configuration
with lib;

{
  system.activationScripts = {
    init = {
      text = ''
        mkdir -p /root/.gnupg/
      '';
      deps = [];
    };
    networkmanagerSetup = {
      text = ''
        mkdir -p /data/host/networkmanager/system-connections/
        mkdir -p /data/host/networkmanager/cert/
        ln -sfn /data/host/networkmanager/system-connections/ /etc/NetworkManager/system-connections
        ln -sfn /data/host/networkmanager/cert/ /etc/NetworkManager/cert
      '';
      deps = [];
    };
  };
#  system.userActivationScripts = {
#    DataSetup = {
#      text = '' ln -sfn /data/user/$USER/ ~/Data '';
#      deps = [];
#    };
#    evolutionSetup = {
#      text = '' mkdir -p /data/user/$USER/Config/evolution
#                ln -sfn /data/user/$USER/Config/evolution ~/.config/ '';
#      deps = [];
#    };
#    mozillaSetup = {
#      text = '' mkdir -p /data/user/$USER/Config/mozilla
#                ln -sfn /data/user/$USER/Config/mozilla ~/.mozilla '';
#      deps = [];
#    };
#  };
}
