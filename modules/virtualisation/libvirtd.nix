{ pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
  };

  system.activationScripts = {
    libvirtd = {
      text = ''
      mkdir -p /data/host/libvirtd/qemu
      ln -sfn  /data/host/libvirtd/qemu /var/lib/libvirt/
      mkdir -p /data/host/libvirtd/storage/autostart
      ln -sfn  /data/host/libvirtd/storage /var/lib/libvirt/
      mkdir -p /data/host/libvirtd/secrets
      ln -sfn  /data/host/libvirtd/secrets /var/lib/libvirt/
      mkdir -p /data/host/libvirtd/images
      ln -sfn  /data/host/libvirtd/images /var/lib/libvirt/
      mkdir -p /data/host/libvirtd/kernel
      ln -sfn  /data/host/libvirtd/kernel /var/lib/libvirt/
      '';
      deps = [];
    };
  };
  environment = {
    systemPackages = with pkgs; [ virtmanager ];
    # Set the default connection string for `virsh` etc to be the system qemu instance.
    variables.LIBVIRT_DEFAULT_URI = "qemu:///system";
  };
}