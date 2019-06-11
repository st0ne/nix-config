{ ... }:

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
  system.userActivationScripts = {
    DataSetup = {
      text = '' ln -sfn /data/user/$USER/ ~/Data '';
      deps = [];
    };
    alacrittySetup = {
      text = '' ln -sfn /data/user/$USER/Config/alacritty ~/.config/ '';
      deps = [];
    };
    dunstSetup = {
      text = '' ln -sfn /data/user/$USER/Config/dunst ~/.config/ '';
      deps = [];
    };
    mimeappsSetup = {
      text = '' ln -sfn /data/user/$USER/Config/mimeapps.list ~/.config/ '';
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
      text = '' ln -sfn /data/user/$USER/Config/vscode ~/.vscode '';
      deps = [];
    };
    x11Setup = {
      text = '' ln -sfn /data/user/$USER/Config/X11/Xmodmap ~/.Xmodmap '';
      deps = [];
    };
  };
}
