{ config, ... }: {
  # nvidia graphics card support
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [
    "amdgpu"
    "nvidia"
  ];
  hardware.nvidia = {
    modesetting.enable = true; # enable nvidia modesetting for hyprland compositors
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Stable names for the two GPUs, because the cardN numbers can change between boots.
  services.udev.extraRules = ''
    SUBSYSTEM=="drm", KERNEL=="card*", ATTRS{vendor}=="0x1002", SYMLINK+="dri/amd-igpu"
    SUBSYSTEM=="drm", KERNEL=="card*", ATTRS{vendor}=="0x10de", SYMLINK+="dri/nvidia-dgpu"
  '';

  # AMD first (it drives the laptop screen), NVIDIA second (it drives HDMI).
  environment.sessionVariables.AQ_DRM_DEVICES = "/dev/dri/amd-igpu:/dev/dri/nvidia-dgpu";
}
