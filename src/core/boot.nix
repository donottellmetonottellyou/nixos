{ ... }:
{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 16;
        editor = false;
      };
      efi.canTouchEfiVariables = true;
    };
    # Drive is encrypted, so this is not a security issue and is beneficial.
    # This allows me to rescue the OS in case of boot failure without having to
    # use a USB boot device.
    kernelParams = [ "boot.shell_on_fail" ];
  };
}
