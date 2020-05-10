{ ... }:

{
  # BUG: https://github.com/NixOS/nixops/issues/574
  systemd.additionalUpstreamSystemUnits = [
    "proc-sys-fs-binfmt_misc.automount"
    "proc-sys-fs-binfmt_misc.mount"
  ];
}
