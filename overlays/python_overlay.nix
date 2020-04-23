self: super: {
  # python3 should be default (welcome to 2020)
  # rel: https://github.com/NixOS/nixpkgs/issues/18185
  python3 = super.python3.override {
    packageOverrides = python-self: python-super: {
      sphinxcontrib-ditaa = self.pythonPackages.callPackage ../pkgs/development/python-modules/sphinxcontrib-ditaa { };
      stem = python-super.watchdog.overrideAttrs (old: rec {
        meta.broken = false;
      });
      sphinx-autobuild = self.pythonPackages.callPackage ../pkgs/development/python-modules/sphinx-autobuild { };
      port-for = self.pythonPackages.callPackage ../pkgs/development/python-modules/port-for { };
      watchdog = python-super.watchdog.overrideAttrs (old: rec {
        pname = old.pname;
        version = "0.10.2";
        src = python-super.fetchPypi {
          inherit pname version;
          sha256 = "0ss58k33l5vah894lykid6ar6kw7z1f29cl4hzr5xvgs8fvfyq65";
        };
      });
    };
  };
  python3Packages = super.recurseIntoAttrs (self.python3.pkgs);
}
