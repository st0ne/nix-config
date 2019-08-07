{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # fuck Matlab
    octaveFull
  ];
}