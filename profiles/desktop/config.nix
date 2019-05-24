{ ... }:

{
  # generate a static config path
  environment.etc = {
    # alacritty
    "per-user/alacritty/alacritty.yml".text = import ../../configs/alacritty/default.nix {};
    # dunst
    "per-user/dunst/dunstrc".text = import ../../configs/dunst/default.nix {};
    # mimeapps
    "per-user/mimeapps.list".text = import ../../configs/mimeapps/list.nix {};
    # X11
    "per-user/X11/Xmodmap".text = import ../../configs/x11/xmodmap.nix {};

  };
  system.activationScripts = {
    networkmanagerSetup = {
      text = ''
        mkdir -p /data/host/networkmanager/system-connections/
        ln -sfn /data/host/networkmanager/system-connections/ /etc/NetworkManager/system-connections
      '';
      deps = [];
    };
  };
  system.userActivationScripts = {
    alacrittySetup = {
      text = '' ln -sfn /etc/per-user/alacritty ~/.config/ '';
      deps = [];
    };
    dunstSetup = {
      text = '' ln -sfn /etc/per-user/dunst ~/.config/ '';
      deps = [];
    };
    mimeappsSetup = {
      text = '' ln -sfn /etc/per-user/mimeapps.list ~/.config/ '';
      deps = [];
    };
    mozillaSetup = {
      text = '' ln -sfn /data/user/$USER/Config/mozilla ~/.mozilla '';
      deps = [];
    };
    thunderbirdSetup = {
      text = '' ln -sfn /data/user/$USER/Config/thunderbird ~/.thunderbird '';
      deps = [];
    };
    qutebrowserSetup = {
      text = '' ln -sfn /data/user/$USER/Config/qutebrowser ~/.config/ '';
      deps = [];
    };
    vscodeSetup = {
      text = '' ln -sfn /data/user/$USER/Config/vscode ~/.vscode/ '';
      deps = [];
    };
    x11Setup = {
      text = '' ln -sfn /etc/per-user/X11/Xmodmap ~/.Xmodmap '';
      deps = [];
    };
  };
}
