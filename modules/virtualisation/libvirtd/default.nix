{ pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
  };

  environment = {
    systemPackages = with pkgs; [ virtmanager ];
    # Set the default connection string for `virsh` etc to be the system qemu instance.
    variables.LIBVIRT_DEFAULT_URI = "qemu:///system";
  };
}