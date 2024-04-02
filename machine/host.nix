{ config, pkgs, ... }: {
  # Bootloader.
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 16;
      editor = false;
    };
    efi.canTouchEfiVariables = true;
  };

  boot.initrd.luks.devices."luks-63396ee7-4502-48b9-a523-66cce561e35f"
  .device = "/dev/disk/by-uuid/63396ee7-4502-48b9-a523-66cce561e35f";

  networking.hostName = "ananda"; # Define your hostname.
}
