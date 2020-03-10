{ lib, ... }:

{
    # enable KVM
    boot.kernelModules = [ "kvm-intel" ];
    # microcode updates
    hardware.cpu.intel.updateMicrocode = lib.mkDefault true;
    
}