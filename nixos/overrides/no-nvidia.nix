{ ... }:

{
  boot.blacklistedKernelModules = [
    # disable dGPU. Does not work with NVIDIA MX150 anyway. ¯\_(ツ)_/¯
    "nouveau"
  ];
}
