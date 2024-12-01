{ pkgs, config, ... }: {
  imports = [
    <home-manager/nixos>
  ];
  # ============================================================================
  # \/ BOOT & KERNEL \/
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
  # /\ BOOT & KERNEL /\
  # ============================================================================
  # \/ NIX CONFIG \/
  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 30d";
    };
    settings = {
      auto-optimise-store = true;
      max-jobs = 1;
    };
    extraOptions = ''
      # add if disk space is an issue
      # keep-derivations = false

      # allows rebuilding offline
      keep-outputs = true
    '';
  };
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = import <nixos-unstable> {
        config = config.nixpkgs.config;
      };
    };
  };
  # /\ NIX CONFIG /\
  # ============================================================================
  # \/ TIME & REGION \/
  time.timeZone = "America/Detroit";
  i18n.defaultLocale = "en_US.UTF-8";
  # /\ TIME & REGION /\
  # ============================================================================
  # \/ USERS \/
  home-manager = {
    # Install in /etc/profiles instead of $HOME/.nix-profile
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "old";
  };
  # /\ USERS /\
  # ============================================================================
  # \/ SOUND \/
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  # /\ SOUND /\
  # ============================================================================
  # \/ WIRELESS & INTERNET \/
  networking = {
    hostName = "ananda";
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [
        8081 # expo go
      ];
      allowedUDPPorts = [
        8081 # expo go
      ];
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
