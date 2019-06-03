{ ... }:

{
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
      text = '' ln -sfn /data/user/$USER/Config/alacritty ~/.config/ '';
      deps = [];
    };
    dunstSetup = {
      text = '' ln -sfn /data/user/$USER/Config/dunst ~/.config/ '';
      deps = [];
    };
    mimeappsSetup = {
      text = '' ln -sfn /data/user/$USER/Config/mimeapps.list ~/.config/mimeapps.list '';
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
      text = '' ln -sfn /data/user/$USER/Config/X11/Xmodmap ~/.Xmodmap '';
      deps = [];
    };
  };
}
