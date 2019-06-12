{ config, ... }:

{
  system.activationScripts = {
  };
  system.userActivationScripts = {
    htopSetup = {
      text = '' mkdir -p /data/user/$USER/Config/htop/${config.host.name}
                ln -sfn /data/user/$USER/Config/htop/${config.host.name} ~/.config/htop '';
      deps = [];
    };
    rangerSetup = {
      text = '' mkdir -p /data/user/$USER/Config/ranger
                ln -sfn /data/user/$USER/Config/ranger ~/.config '';
      deps = [];
    };
  };
}