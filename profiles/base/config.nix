{ config, ... }:

{
  system.activationScripts = {
  };
  system.userActivationScripts = {
    gnupgSetup = {
      text = '' mkdir -p /data/user/$USER/Auth/GnuPG/${config.general.name}
                ln -sfn /data/user/$USER/Auth/GnuPG/${config.general.name} ~/.gnupg '';
      deps = [];
    };
    htopSetup = {
      text = '' mkdir -p /data/user/$USER/Config/htop/${config.general.name}
                ln -sfn /data/user/$USER/Config/htop/${config.general.name} ~/.config/htop '';
      deps = [];
    };

    rangerSetup = {
      text = '' ln -sfn /data/user/$USER/Config/ranger ~/.config '';
      deps = [];
    };
  };
}