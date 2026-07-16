{ pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 16;
        editor = false;
        memtest86.enable = true;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [
      # Drive is encrypted, so this is not a significant security issue (not a
      # government target hopefully) and is otherwise beneficial.
      # This allows me to rescue the OS in case of boot failure without having
      # to use a USB boot device.
      "boot.shell_on_fail"
      # Possibly fix hotplug issues with my HDMI
      "i915.enable_dc=0"
      # I don't need this, and it may also cause display problems
      "i915.enable_psr=0"
    ];
  };

  # Update support for firmware
  services.fwupd.enable = true;
}
