{ config, pkgs, ... }:

# enable hardware video acceleration for intel graphics
# ref: https://wiki.archlinux.org/index.php/Hardware_video_acceleration

{
  environment.variables = {
    LIBVA_DRIVER_NAME = "iHD";
    VDPAU_DRIVER = "va_gl";
    };

  # tools
  environment.systemPackages = with pkgs; [
    libva-utils
    vdpauinfo
  ];

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      vaapi-intel-hybrid
      vaapiVdpau
      libva-full
      libvdpau-va-gl
      intel-media-driver
    ];
  };
}
