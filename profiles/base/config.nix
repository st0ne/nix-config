{ config, ... }:

{
  # generate a static config path
  environment.etc = {
    # htop
    "per-user/htop/htoprc".text = import ../../configs/htop/default.nix {};

  };
  system.activationScripts = {
    };
  system.userActivationScripts = {
    htopSetup = {
      text = '' ln -sfn /etc/per-user/htop ~/.config/ '';
      deps = [];
    };
  };
}