{ ... }:

## main personal Laptop
# Lenovo Thinkpad T580
# CPU: i7-8550U
# iGPU: Intel UHD Graphics 620 (active)
# dGPU: NVIDIA GeForce MX150 (inactive)
# Display: 15.6" UHD (3840 x 2160)

{
  imports = [
    ./hardware.nix
    # profile
    ../../profiles/laptop.nix
    # modules
    ../../modules/services/xserver/window-managers/i3.nix
    ../../modules/programs/zsh.nix
    # overlays
    ../../overlays/HiDPI.nix
    ../../overlays/intel-vaapi.nix
    ../../overlays/xorg-no-sleep.nix
    # users
    ../../users/sylv.nix
  ];

  ### GENERAL ##################################################################
  networking.hostName = "T580";
  system.stateVersion = "18.09";

  ### USER #####################################################################
  users.users.sylv.extraGroups = [
    "wheel" #privileged user
    "networkmanager" #manage network
    "video" # hardware acceleration access
    "docker" #allow direct docker api access (Warning: The docker group grants
    # privileges equivalent to the root user.
    # [https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface)
  ];

  ### SERVICES #################################################################
  services = {
    # custom configuration
    compton = {
      refreshRate = 60;
      extraOptions =
''
glx-no-stencil = true;
glx-no-rebind-pixmap = true;
glx-swap-method = "buffer-age";
'';
    };
  };

  ### VIRTUALISATION ###########################################################
  # enable docker
  virtualisation.docker.enable = true;
}
