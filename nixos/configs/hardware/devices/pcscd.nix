{ lib, pkgs, ... }:

{
  services.pcscd = {
    enable = lib.mkDefault true;
  };
  
  environment.systemPackages = with pkgs; [
    pcsctools
    opensc
  ];
}
