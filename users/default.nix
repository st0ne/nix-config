{ config, lib, ... }:

with lib;
let
  # list of all normal user
  normalUsers = lib.attrsets.mapAttrsToList (n: v: v.name) (lib.attrsets.filterAttrs (n: v: v.isNormalUser) config.users.users);
in
{
  system.activationScripts = {
    # create user data path for each normal user
    dataPath = {
      text = ''
        for _USER in ${lib.strings.concatStringsSep " " normalUsers}; do
          _USERDATA=/data/user/$_USER
          if [ ! -d $_USERDATA ]; then
            _GROUP=$(id -gn $_USER)
            mkdir -p $_USERDATA
            chown -R $_USER:$_GROUP $_USERDATA
          fi
        done
      '';
      deps = [];
    };
  };
  system.userActivationScripts = {
    # add user data path for persistent storage
    dataSetup = {
      text = ''
        _DATA=$HOME/data

        if [ ! -L $_DATA ]
        then
          if [ -e $_DATA ]
          then
            mv $_DATA $HOME/old_data
          fi
          ln -sn /data/user/$USER $_DATA
        fi
      '';
      deps = [];
    };
    tmpSetup = {
      # add tmp folder for User
      text = ''
        TMP_PATH=/tmp/$USER
        TMP=$HOME/tmp

        if [ ! -L $TMP ]
        then
          if [ -e $TMP ]
          then
            mv $TMP $\{TMP}_bak
          fi
          ln -snf $TMP_PATH $TMP
        fi
      '';
      deps = [];
    };
  };
  environment.extraInit = ''
    if [ "$EUID" -ne 0 ]
    then
      mkdir -p /tmp/$USER
    fi
    '';
}
