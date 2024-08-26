{ pkgs, ... }: {
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

    kernelPatches = [
      {
        name = "fix-audio-1";
        patch = builtins.fetchurl {
          url = "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/patch/sound/soc/soc-topology.c?id=e0e7bc2cbee93778c4ad7d9a792d425ffb5af6f7";
          sha256 = "sha256:1y5nv1vgk73aa9hkjjd94wyd4akf07jv2znhw8jw29rj25dbab0q";
        };
      }
      {
        name = "fix-audio-2";
        patch = builtins.fetchurl {
          url = "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/patch/sound/soc/soc-topology.c?id=0298f51652be47b79780833e0b63194e1231fa34";
          sha256 = "sha256:14xb6nmsyxap899mg9ck65zlbkvhyi8xkq7h8bfrv4052vi414yb";
        };
      }
    ];
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
      max-jobs = 2;
    };
  };
  nixpkgs.config = {
    allowUnfree = true;
  };
  # /\ NIX CONFIG /\
  # ============================================================================
  # \/ TIME & REGION \/
  time.timeZone = "America/Detroit";
  i18n.defaultLocale = "en_US.UTF-8";
  # /\ TIME & REGION /\
  # ============================================================================
  # \/ USERS \/
  users.defaultUserShell = pkgs.zsh;
  home-manager = {
    # Install in /etc/profiles instead of $HOME/.nix-profile
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "old";
  };
  # /\ USERS /\
  # ============================================================================
  # \/ SOUND \/
  sound.enable = true;
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
