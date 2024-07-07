{
  pkgs,
  config,
  ...
}: {
  hardware.opengl = {
    enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
  boot.initrd.kernelModules = ["nvidia"];
  environment = {
    systemPackages = with pkgs; [
      dive
      podman-tui
      docker-compose
      #podman-compose
      inkscape
      krita
      gimp
      steam-tui
      bitwarden
      protontricks
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };
  services.openssh = {
    enable = true;
    ports = [2222];
    settings = {
      KbdInteractiveAuthentication = false;
      PasswordAuthentication = false;
    };
  };

  programs.appimage.binfmt = true;

  hardware.nvidia-container-toolkit.enable = true;
  swapDevices = [
    {
      device = "/home/swap";
      size = 32 * 1024;
    }
  ];
}
