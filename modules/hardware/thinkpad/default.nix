{ config, pkgs, ... }:

{
  boot = {
    kernelModules = [ "acpi_call" "thinkpad_acpi" ];
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  };

  environment.systemPackages = with pkgs; [
    tpacpi-bat
  ];
}
