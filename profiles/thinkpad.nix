{ config, pkgs, ... }:

# Profile for thinkpads.

{
  imports = [
    ./laptop.nix
  ];

  boot = {
    kernelModules = [ "acpi_call" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  };

  environment.systemPackages = with pkgs; [
    tpacpi-bat
  ];
}
