{ ... }:

{
  boot.initrd.availableKernelModules = [ "i915" ];
  boot.kernelParams = [ "i915.fastboot=1" "i915.enable_guc=2" "i915.enable_fbc=1" "i915.enable_dc=7" ];
}
