{ ... }:
{
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball
    {
	  url = "https://github.com/nix-community/NUR/archive/f56de9743226384e77d44cefc07929ca3f673733.tar.gz";
	  # Get the hash by running `nix-prefetch-url --unpack <url>` on the above url
	  sha256 = "0pm95wlz3san7yixwy3iz6kgnx2hb01zxhsvv6nfimxc37x1jl8p";
    }) {
      inherit pkgs;
    };
  };
}
