{ ... }:

# use legacy BIOS bootloader instead of UEFI

{
  boot.loader.grub.efiSupport = false;
}