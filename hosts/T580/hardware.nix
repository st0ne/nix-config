{ lib, ... }:

# hardware specific configuration

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  nix.maxJobs = lib.mkDefault 8;

  ### BOOT #####################################################################
  boot = {
    initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
    kernelModules = [ "kvm-intel" ];
    kernelParams = [
      # some intel video driver tweeks
      "i915.fastboot=1" "i915.enable_guc=2" "i915.enable_fbc=1" "i915.enable_psr=2"
      "i915.enable_rc6=0" "i915.enable_dc=0" "i915.enable_guc_loading=1"
      "i915.enable_guc_submission=1" "i915.enable_huc=1"
    ];
    blacklistedKernelModules = [
      # disable dGPU. Does not work with NVIDIA MX150 anyway. ¯\_(ツ)_/¯
      "nouveau"
    ];
  };
  hardware.cpu.intel.updateMicrocode = true;

  ### FSTAB ####################################################################
  # nvme SSD
  # TODO: - encrypted /data partition, with contains my sensitive data.
  #       - generic filesystem configuration, with uses the device hostname as
  #         lvm volume group.
  fileSystems = {
    "/" = {
      device = "/dev/T580/nixos";
      fsType = "ext4";
      options = [ "noatime" "discard" ];
    };

    "/boot/efi" = {
      device = "/dev/nvme0n1p2";
      fsType = "vfat";
    };

    "/data" = {
      device = "/dev/T580/data";
      fsType = "ext4";
      options = [ "noatime" "discard" ];
    };
  };
}
