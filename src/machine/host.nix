{ pkgs, ... }: {
  # Bootloader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 16;
        editor = false;
      };
      efi.canTouchEfiVariables = true;
    };
    # Temporary fix for kernel audio issues
    kernel = pkgs.linuxKernel.packages.linux_6_1;
  };

  networking.hostName = "ananda"; # Define your hostname.
}
