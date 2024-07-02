{
  config,
  lib,
  pkgs,
  ...
}: {
  # nvidia
  hardware.graphics = {
    enable = true;
    # driSupport = true;
    # driSupport32Bit = true;
    extraPackages = with pkgs; [
      libva-utils
      libva
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  services.xserver.videoDrivers = ["nvidia"];

  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" "nvidia_drm.fbdev=1" ];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement = {
      enable = true;
      finegrained = false;
    };

    open = false;
    nvidiaSettings = false; # gui app
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
