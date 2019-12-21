{ config, pkgs, ... }:

{
  imports = [
    ../../../extern/NUR.nix
  ];
  home-manager.users.sylv.programs.firefox = {
    enable = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      https-everywhere
      multi-account-containers
      ublock-origin
      umatrix
    ];
  };
}

