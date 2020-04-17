with import <nixpkgs> {};

let
  gnatPkgs = import (fetchFromGitHub {
    owner = "sylv-io";
    repo = "nixpkgs";
    rev = "gnat";
    sha256 = "07gq52473xfpgks2mrz3f03vxgsqsxd7zi34ym865pamkv2hmy6k";
  }) {};

  gnatgcc9 = with gnatPkgs; wrapCC (gcc9.cc.override {
    langAda = true;
    gnatboot = gnat9;
  });
in

{
  corebootEnv = stdenvNoCC.mkDerivation {
    name = "coreboot";
    shellHook =
      ''
      # prompt
      #export PS1="\n\[\033[1;33m\][coreboot:\w]\$\[\033[0m\] "

      '';
    buildInputs = [

      ## core
      ccache coreboot-utils curl git python27

      ## compile toolchain
      gnatgcc9 zlib bison flex

      # make nconfig
      ncurses

      ## Payloads
      # LinuxBoot
      go bc libelf
      # Tianocore
      nasm
    ];
    propagatedBuildInputs = [
      # Tianocore
      libuuid
    ];
    hardeningDisable = [ "format" ];  # to build the cross-compiler
  };
}
