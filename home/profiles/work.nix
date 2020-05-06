{ pkgs, ... }:

let
  workConfigs = [
    ../configs/go.nix
  ];
  workPkgs = with pkgs; [
    chromium
    flashrom
    vscode-with-extensions
    zoom-us
  ];
  vscode-with-extensions = pkgs.vscode-with-extensions.override {
    vscodeExtensions = with pkgs.vscode-extensions; [
      ms-vscode.cpptools
      vscodevim.vim
    ];
  };
in
{
  imports = workConfigs;
  home.packages = workPkgs;
}
