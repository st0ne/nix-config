self: super: {
  neovim-unwrapped-nightly = super.neovim-unwrapped.overrideAttrs (
    old: rec {
      pname = "neovim-unwrapped-nightly";
      version = "nightly";
      src = super.fetchFromGitHub {
        owner = "neovim";
        repo = "neovim";
        rev = "2f818eb9ee6a17ec5897f28e167248efb02f1c0e";
        sha256 = "0p8mf25ijdzg0s0xav0qipb2g83pvvna4f8i9alm39iz4fnwskf9";
      };
    }
  );
  # WIP
  nvim-lsp-nightly = super.vimUtils.buildVimPluginFrom2Nix {
    pname = "nvim-lsp";
    version = "2020-05-10";
    src = super.fetchFromGitHub {
      owner = "neovim";
      repo = "nvim-lsp";
      rev = "b77a24f6b6bdf32d621f37c733f399f33a7eab0d";
      sha256 = "09yvhcadjkyyykvjna2wlmg25m53my8fhzi9is2ac35ii6yby0pi";
    };
  };
}
