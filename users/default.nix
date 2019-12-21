{ lib, ... }:

with lib;
{
  system.activationScripts = {
    # TODO: add user Data path to /data/users
    dataPath = {
      text = ''
      '';
      deps = [];
    };
  };
  system.userActivationScripts = {
    # add user Data path for persistent storage
    dataSetup = {
      text = ''
        DATA=$HOME/Data

        if [ ! -L $DATA ]
        then
          if [ -e $DATA ]
          then
            mv $DATA $\{DATA}_bak
          fi
          ln -snf /Data/users/$USER $DATA
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
