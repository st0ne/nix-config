{ ... }:
# ref: https://nixos.wiki/wiki/Home_Manager
{imports = ["${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos"];}
