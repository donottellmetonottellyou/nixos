{ pkgs, ... }:
{
  # ============================================================================
  # \/ TIME & REGION \/
  time.timeZone = "America/Detroit";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    # 24H ISO-ish time
    extraLocaleSettings.LC_TIME = "C.UTF-8";
  };
  # /\ TIME & REGION /\
  # ============================================================================
  # \/ SOUND \/
  security.rtkit.enable = true;
  services = {
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
  # /\ SOUND /\
  # ============================================================================
  # \/ WIRELESS & INTERNET \/
  networking = {
    hostName = "ananda";
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };
  # Disable wifi shutoff when screen is locked etc
  environment.etc."NetworkManager/conf.d/custom.conf".text = ''
    [connection]
    wifi.powersave = 2
  '';
  hardware.bluetooth.enable = true;
  # /\ WIRELESS & INTERNET /\
  # ============================================================================
  # \/ PRINTING \/
  services = {
    printing = {
      enable = true;
      webInterface = false;
      drivers = with pkgs; [
        epson-escpr2
      ];
      openFirewall = true;
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
  # /\ PRINTING /\
  # ============================================================================
}
