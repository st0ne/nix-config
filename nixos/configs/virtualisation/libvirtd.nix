{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.virtualisation.libvirtd;
  dirName = "libvirt";
in
{
  virtualisation.libvirtd = {
    enable = true;
    qemuRunAsRoot = false;
  };
  environment = {
    systemPackages = with pkgs; [ virtmanager spice spice-protocol win-spice spice-gtk ];
    # Set the default connection string for `virsh` etc to be the system qemu instance.
    variables.LIBVIRT_DEFAULT_URI = "qemu:///system";
    # setup libvirt as default provider for vagrant
    variables.VAGRANT_DEFAULT_PROVIDER = "libvirt";
  };
  # FIX:
  security.wrappers.spice-client-glib-usb-acl-helper.source = "${pkgs.spice-gtk}/bin/spice-client-glib-usb-acl-helper";
  systemd.services.libvirtd-config.serviceConfig.StateDirectory = lib.mkForce null;
}
