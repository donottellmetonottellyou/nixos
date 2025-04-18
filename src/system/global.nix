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
    # Drive is encrypted, so this is not a security issue and is beneficial.
    # This allows me to rescue the OS in case of boot failure without having to
    # use a USB boot device.
    kernelParams = [ "boot.shell_on_fail" ];
  };
  console.font = pkgs.fira-code-nerdfont;
  # /\ BOOT & KERNEL /\
  # ============================================================================
  # \/ NIX CONFIG \/
  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 30d";
    };
    optimise = {
      automatic = true;
      dates = [ "daily" ];
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # Only one build at a time, internet is slow (as of writing) so the build
      # is usually not a bottleneck. I also don't want to freeze the system when
      # building.
      max-jobs = 1;
    };
    extraOptions = ''
      # Allows rebuilding offline
      keep-outputs = true

      # Only one download at a time
      max-substitution-jobs = 1
    '';
  };
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      # Allow unstable packages for niche usecases (such as api-sensitive apps)
      unstable = import <nixos-unstable> {
        config = config.nixpkgs.config;
      };
    };
  };
  # /\ NIX CONFIG /\
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
  # \/ USERS \/
  home-manager = {
    # Install in /etc/profiles instead of $HOME/.nix-profile
    useUserPackages = true;
    # I don't have to reconfigure all the same stuff twice
    useGlobalPkgs = true;
    # Please make this show more of the error, NixOS devs!
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
      allowedTCPPorts = [];
      allowedUDPPorts = [];
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
