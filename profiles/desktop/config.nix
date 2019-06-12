{ config, ... }:

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
      text = ''
                mkdir -p /data/user/$USER/Config/alacritty
                ln -sfn /data/user/$USER/Config/alacritty ~/.config/ '';
      deps = [];
    };
    gnupgSetup = {
      text = '' mkdir -p /data/user/$USER/Auth/GnuPG/${config.general.name}
                ln -sfn /data/user/$USER/Auth/GnuPG/${config.general.name} ~/.gnupg '';
      deps = [];
    };
    dunstSetup = {
      text = '' mkdir -p /data/user/$USER/Config/dunst
                ln -sfn /data/user/$USER/Config/dunst ~/.config/ '';
      deps = [];
    };
    evolutionSetup = {
      text = '' mkdir -p /data/user/$USER/Config/evolution
                ln -sfn /data/user/$USER/Config/evolution ~/.config/ '';
      deps = [];
    };
    mimeappsSetup = {
      text = '' mkdir -p /data/user/$USER/Config
                ln -sfn /data/user/$USER/Config/mimeapps.list ~/.config/ '';
      deps = [];
    };
    mozillaSetup = {
      text = '' mkdir -p /data/user/$USER/Config/mozilla
                ln -sfn /data/user/$USER/Config/mozilla ~/.mozilla '';
      deps = [];
    };
    passSetup = {
      text = '' mkdir -p /data/user/$USER/Auth/Pass/${config.general.name}
                ln -sfn /data/user/$USER/Auth/Pass/${config.general.name} ~/.password-store '';
      deps = [];
    };
    taskSetup = {
      text = '' mkdir -p /data/user/$USER/Config/task
                ln -sfn /data/user/$USER/Config/task/taskrc ~/.taskrc
                ln -sfn /data/user/$USER/Config/task/task ~/.task '';
      deps = [];
    };
    thunderbirdSetup = {
      text = '' mkdir -p /data/user/$USER/Config/thunderbird
                ln -sfn /data/user/$USER/Config/thunderbird ~/.thunderbird '';
      deps = [];
    };
    qutebrowserSetup = {
      text = '' mkdir -p /data/user/$USER/Config/qutebrowser
                ln -sfn /data/user/$USER/Config/qutebrowser ~/.config/ '';
      deps = [];
    };
    vscodeSetup = {
      text = '' mkdir -p /data/user/$USER/Config/vscode
                ln -sfn /data/user/$USER/Config/vscode ~/.vscode '';
      deps = [];
    };
    x11Setup = {
      text = '' mkdir -p /data/user/$USER/Config/X11
                ln -sfn /data/user/$USER/Config/X11/Xmodmap ~/.Xmodmap '';
      deps = [];
    };
  };
}
