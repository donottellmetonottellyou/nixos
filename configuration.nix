# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
let
  # Central source of truth for system version
  channel = "23.11";
  # Declaratively set home-manager
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-${channel}.tar.gz";
  };
in
{
  imports = [
    ./hardware-configuration.nix
    (import "${home-manager}/nixos")
  ];

  # Declaratively set nixpkgs
  nix.nixPath = [
    "nixpkgs=https://nixos.org/channels/nixos-${channel}/nixexprs.tar.xz"
    "nixos-config=/etc/nixos/configuration.nix"
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-63396ee7-4502-48b9-a523-66cce561e35f".device = "/dev/disk/by-uuid/63396ee7-4502-48b9-a523-66cce561e35f";
  networking.hostName = "ananda"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  environment.etc."NetworkManager/conf.d/custom.conf".text = ''
    [connection]
    wifi.powersave = 2
  '';

  # Set your time zone.
  time.timeZone = "America/Detroit";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Disable unneeded GNOME packages
  environment.gnome.excludePackages = with pkgs.gnome; [
    # baobab      # disk usage analyzer
    cheese # photo booth
    # eog         # image viewer
    epiphany # web browser
    gedit # text editor
    simple-scan # document scanner
    # totem       # video player
    yelp # help viewer
    evince # document viewer (use libreoffice)
    # file-roller # archive manager
    geary # email client (use chrome)
    # seahorse    # password manager

    # these should be self explanatory
    # gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-contacts
    # gnome-font-viewer  gnome-music gnome-photos gnome-screenshot pkgs.gnome-connections
    # gnome-system-monitor gnome-weather gnome-disk-utility 
    gnome-logs
    gnome-maps
    pkgs.gnome-text-editor
    pkgs.gnome-tour
  ];

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
    # Remove xterm
    excludePackages = with pkgs; [
      xterm
    ];
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # =======
  #  USERS
  # =======

  # Install in /etc/profiles instead of $HOME/.nix-profile
  home-manager.useUserPackages = true;

  # Use global pkgs
  home-manager.useGlobalPkgs = true;

  # Steam configuration
  programs.steam = {
    enable = true;
    # localNetworkGameTransfers.openFirewall = true; # future config
  };

  # Default git configuration
  programs.git = {
    enable = true;
    config.init.defaultBranch = "main";
  };

  # Improve bash command history search
  programs.bash = {
    enable = true;
    interactiveShellInit = ''
      # Bind up and down arrow keys for history search
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'
    '';
  };

  # Main user
  users.users.jadelynnmasker = {
    isNormalUser = true;
    description = "Jade Lynn Masker";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.users.jadelynnmasker = { pkgs, ... }: {

    # Dark mode for GTK4 applications
    dconf = {
      enable = true;
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };

    programs.git = {
      enable = true;
      userName = "Jade Lynn Masker";
      userEmail = "donottellmetonottellyou@gmail.com";
      extraConfig = {
        # Editor/pager
        core = {
          editor = "code --wait";
          pager = "less -F -X";
        };

        # Diff/merge tools
        diff.tool = "vscode";
        difftool.vscode.cmd = "code --wait --diff $LOCAL $REMOTE";
        merge.tool = "vscode";
        mergetool = {
          prompt = false;
          vscode.cmd = "code --wait $MERGED";
        };


        # Signing
        user.signingKey = "BDA496D2B8AFE0B087AC49B60EFCE08AB6147F98";
        commit.gpgSign = true;
        push.gpgSign = "if-asked";
        tag.gpgSign = true;
      };
    };

    home.packages = with pkgs; [
      # Personal web browser
      google-chrome
      # Personal text editor (with extensions)
      (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
          jnoortheen.nix-ide
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          # C/C++
          {
            name = "cpptools";
            publisher = "ms-vscode";
            version = "1.19.4";
            sha256 = "ormgfJZzYuU7qYbgylr/2C/ocqxHDyDgT7Fx/CySLTA=";
          }
          {
            name = "c-cpp-flylint";
            publisher = "jbenden";
            version = "1.14.0";
            sha256 = "HOcFx8jjLPGW7LHq8t0mNmnuhFS+JtkD3+gCtV6eBCo=";
          }
          # CSharp
          {
            name = "csdevkit";
            publisher = "ms-dotnettools";
            version = "1.4.6";
            sha256 = "dCUXShS2LTr3OMIkXQX636S1W8DWw5j8ztzyKo7QBZM=";
            sourceRoot = "./extension";
          }
          {
            name = "csharp";
            publisher = "ms-dotnettools";
            version = "2.19.13";
            sha256 = "0SkAo93ahCMbWSo6CrnRN6fzKrqMkFURmuBjIqnxh9s=";
          }
          {
            name = "vscode-dotnet-runtime";
            publisher = "ms-dotnettools";
            version = "2.0.2";
            sha256 = "7Nx8OiXA5nWRcpFSAqBWmwSwwNLSYvw5DEC5Q3qdDgU=";
          }
          {
            name = "vscodeintellicode-csharp";
            publisher = "ms-dotnettools";
            version = "0.1.26";
            sha256 = "lS9LhYZRvdatNVis9kjstBn3iY5AQy0KUscoPvBIdXs=";
            sourceRoot = "./extension";
          }
          # Rust
          {
            name = "rust-analyzer";
            publisher = "rust-lang";
            version = "0.4.1861";
            sha256 = "BYlhfl2mMC8hqwTe3dMcRfYLJEZAW7fGwT3tzgbDJBU=";
          }
          {
            name = "crates";
            publisher = "serayuzgur";
            version = "0.6.6";
            sha256 = "HXoH1IgMLniq0kxHs2snym4rerScu9qCqUaqwEC+O/E=";
          }
          {
            name = "even-better-toml";
            publisher = "tamasfe";
            version = "0.19.2";
            sha256 = "JKj6noi2dTe02PxX/kS117ZhW8u7Bhj4QowZQiJKP2E=";
          }
        ];
      })
      # C/C++
      clang # needed for rust linker as well
      cppcheck
      # CSharp
      dotnet-sdk_8
      # Nix
      nixd
      nixpkgs-fmt
      # Rust
      rustup
      # Chat
      discord
      slack
      zoom-us
    ];

    home.stateVersion = "23.11";
  };

  # =================
  #  GLOBAL PACKAGES
  # =================

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # GNOME extensions
    gnomeExtensions.tiling-assistant
    gnomeExtensions.tray-icons-reloaded
    # Default Browser
    firefox
    # Office suite
    libreoffice
    # General programming tools
    fastfetch
    micro
    neovim
    fira-code
    git
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # ====================
  #  SYSTEM MAINTENANCE
  # ====================

  # Garbage collection and optimization
  nix = {
    gc = {
      automatic = true;
      dates = "15:00";
      options = "--delete-older-than 30d";
      randomizedDelaySec = "1h";
    };
    settings = {
      auto-optimise-store = true;
      max-jobs = 2;
    };
  };

  # Auto update
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    channel = "https://nixos.org/channels/nixos-${channel}";
    dates = "3:00";
    randomizedDelaySec = "1h";
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
