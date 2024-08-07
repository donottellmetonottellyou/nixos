{ ... }: {
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
  };

  networking.hostName = "ananda"; # Define your hostname.
}
