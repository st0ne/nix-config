{ ... }:

{
    # enable KVM
    boot.kernelModules = [ "kvm-amd" ];
    # microcode updates
    hardware.cpu.amd.updateMicrocode = true;
}