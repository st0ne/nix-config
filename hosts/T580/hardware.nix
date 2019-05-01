{ lib, ... }:

# hardware specific configuration

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  nix.maxJobs = lib.mkDefault 8;

  ### BOOT #####################################################################
  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
      luks.devices = [
        {
          # cryptdevice with all my persistent data
          name = "data";
          device = "/dev/T580/data";
          preLVM = false;
        }
      ];
    };
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
    # partition with persistent data (user & host)
    "/data" = {
      device = "/dev/mapper/data";
      fsType = "ext4";
      options = [ "noatime" "discard" ];
    };
  };
}
