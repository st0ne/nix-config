self: super: {
  # similar to 'writeShellScriptBin' but with args parsing
  writeShellScriptBinArgs = name: text:
    super.writeTextFile {
      inherit name;
      executable = true;
      destination = "/bin/${name}";
      text = ''
        #!${super.runtimeShell}
        ${text} "$@"
      '';
      checkPhase = ''
        ${super.stdenv.shell} -n $out/bin/${name}
      '';
    };
  # nix-shell wrapper
  nix-config-shell = self.writeShellScriptBinArgs "nix-config-shell" ../bin/nix-config-shell;
}
