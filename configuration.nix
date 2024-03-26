# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
let
  # Central source of truth for system version
  channel = "23.11";

  # Declaratively set home-manager and nixpkgs versions
  nixos-stable = builtins.fetchGit {
    name = "nixos-stable-20240326"; # Add date later with script
    url = "https://github.com/nixos/nixpkgs/";
    ref = "refs/heads/nixos-${channel}";
    # `git ls-remote https://github.com/nixos/nixpkgs channel`
    rev = "7c6e3666e2040fb64d43b209b84f65898ea3095d";
  };
  home-manager = builtins.fetchGit {
    name = "home-manager-20240326"; # Add date later with script
    url = "https://github.com/nix-community/home-manager/";
    ref = "refs/heads/release-${channel}";
    # `git ls-remote https://github.com/nix-community/home-manager release-channel`
    rev = "f33900124c23c4eca5831b9b5eb32ea5894375ce";
  };
in
{
  imports = [
    ./hardware-configuration.nix
    (import "${home-manager}/nixos")
  ];

  # Declaratively set nixpkgs
  nix.nixPath = [
    "nixpkgs=${nixos-stable}"
    "nixos-config=/etc/nixos/configuration.nix"
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "nix-2.16.2"
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

  # Enable the X11 windowing system with XFCE
  services.xserver = {
    enable = true;
    desktopManager = {
      xfce.enable = true;
      xterm.enable = false;
    };
    displayManager.defaultSession = "xfce";
  };

  # Disable suspend on laptop lid close
  services.logind.lidSwitchExternalPower = "ignore";

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

  # ====================
  #  SYSTEM MAINTENANCE
  # ====================

  # Garbage collection and optimization
  nix = {
    gc = {
      automatic = true;
      dates = "3:00";
      options = "--delete-older-than 30d";
      randomizedDelaySec = "1h";
    };
    settings = {
      auto-optimise-store = true;
      max-jobs = 2;
    };
  };

  # =================
  #  GLOBAL PACKAGES
  # =================

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Mumble chat server
  services.murmur = {
    enable = true;
    openFirewall = true;
  };

  # Steam configuration
  programs.steam = {
    enable = true;
    # localNetworkGameTransfers.openFirewall = true; # future config
  };

  # Improve bash command history search
  programs.bash = {
    interactiveShellInit = ''
      # Bind up and down arrow keys for history search
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'
    '';
  };

  # Default git configuration
  programs.git = {
    enable = true;
    config.init.defaultBranch = "main";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Terminal emulator
    alacritty
    # Neofetch alternative
    fastfetch
    # Default Browser
    firefox
    # Office suite
    libreoffice
    # General programming tools
    fira-code
    git
    micro
    neovim
  ];


  # =======
  #  USERS
  # =======

  # Install in /etc/profiles instead of $HOME/.nix-profile
  home-manager.useUserPackages = true;

  # Use global pkgs
  home-manager.useGlobalPkgs = true;

  # MAIN USER
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
      # C/C++
      clang_17
      clang-tools_17
      cppcheck
      # CSharp
      dotnet-sdk_8
      # Nix
      nixd
      nixpkgs-fmt
      # NodeJS
      nodejs_20
      # Rust
      rustup
      # Chat
      discord
      mumble
      slack
      zoom-us
      # Games
      itch
      prismlauncher
      # Scripts
      (writeScriptBin "apply-nixos-configuration" ''
        #!/bin/sh
        git add -A && git commit || {
          echo "No changes to commit. Continue (Y/N)?"
          read input
          if [[ "''${input,,}" == "y" ]]; then
            echo "Alright then."
          else
            echo "Exiting"; exit 1
          fi
        }
        git push &&
          sudo nixos-rebuild switch ||
          exit 1
      '')
      # Personal text editor (with extensions)
      (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
          jnoortheen.nix-ide
          ms-dotnettools.csharp
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
          {
            name = "clang-format";
            publisher = "xaver";
            version = "1.9.0";
            sha256 = "q9DvkXbv+GTyeMVIyUQDK49Njsl9msbnOD1gyS4ljC8=";
          }
          # CSharp (Disabled for now...)
          # {
          #   name = "csdevkit";
          #   publisher = "ms-dotnettools";
          #   version = "1.5.4";
          #   sha256 = "vAr5HzLnBYNvXdRkwscpZARvgJOpBeZA4nRNyyIVhDM=";
          #   sourceRoot = "./extension";
          # }
          # {
          #   name = "csharp";
          #   publisher = "ms-dotnettools";
          #   version = "2.23.2";
          #   sha256 = "b4n4HYD4HQ6+LzKjWqN9UXKkQg2A6FWTjUKjD8rlWHs=";
          # }
          # {
          #   name = "vscode-dotnet-runtime";
          #   publisher = "ms-dotnettools";
          #   version = "2.0.2";
          #   sha256 = "7Nx8OiXA5nWRcpFSAqBWmwSwwNLSYvw5DEC5Q3qdDgU=";
          # }
          # Godot
          {
            name = "godot-tools";
            publisher = "geequlim";
            version = "2.0.0";
            sha256 = "6lSpx6GooZm6SfUOjooP8mHchu8w38an8Bc2tjYaVfw=";
          }
          # Markdown
          {
            name = "markdown-preview-github-styles";
            publisher = "bierner";
            version = "2.0.3";
            sha256 = "yuF6TJSv0V2OvkBwqwAQKRcHCAXNL+NW8Q3s+dMFnLY=";
          }
          {
            name = "rewrap";
            publisher = "stkb";
            version = "17.8.0";
            sha256 = "9t1lpVbpcmhLamN/0ZWNEWD812S6tXG6aK3/ALJCJvg=";
          }
          # Rust
          {
            name = "rust-analyzer";
            publisher = "rust-lang";
            version = "0.4.1861";
            sha256 = "VC63pqsOhvXktJEXt0Pnbpw/OROSzRLVNn0SL76VXIg=";
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
    ];

    home.stateVersion = "23.11";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
