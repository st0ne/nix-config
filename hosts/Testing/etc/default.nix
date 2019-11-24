{ ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-base.nix>
  ];

  #nix.nixPath = [ "nixpkgs=/data/nixpkgs/nixos" ];
  networking = {
    hostName = "foo.nice.dev";
    domain = "";
    hosts = {
      "192.168.0.2" = [ "bar.example.com" "bar" ];
      "192.168.0.3" = [ "dead.example.com" "dead" ];
      "192.168.0.4" = [ "beef.example.com" "dead" ];
    };
  };
}

