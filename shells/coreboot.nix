with import <nixpkgs> { overlays = [ (import ../overlays/python_overlay.nix) ]; };

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

  pyPkgs = pythonPackages;
in

{
  corebootEnv = stdenvNoCC.mkDerivation {
    name = "coreboot";
    shellHook =
      ''
      # prompt
      export PS1="\n\[\033[1;33m\][coreboot:\w]\$\[\033[0m\] "

      '';
    buildInputs = [

      ## core
      ccache coreboot-utils curl git python

      ## compile toolchain
      gnatgcc9 zlib bison flex

      # make nconfig
      ncurses

      ## Payloads
      # Grub2
      autoconf automake gettext pkg-config unifont
      # LinuxBoot
      go bc libelf
      # Tianocore
      nasm

      ## Documentation
      tetex inkscape imagemagick pyPkgs.sphinx pyPkgs.sphinx_rtd_theme pyPkgs.recommonmark pyPkgs.sphinx-autobuild
      # Extention broken! Remove this module from the extention list in Documentation/conf.py
      #pyPkgs.sphinxcontrib-ditaa
    ];
    propagatedBuildInputs = [
      # Tianocore
      libuuid
    ];
    hardeningDisable = [ "format" ];  # to build the cross-compiler
  };
}
