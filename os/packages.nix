{ config, pkgs, ... }:
let
  channel = "23.11";

  pin-date = "20240506";

  url-nixpkgs = "https://github.com/NixOS/nixpkgs/";
  url-homemgr = "https://github.com/nix-community/home-manager/";
  url-nixgl = "https://github.com/nix-community/nixGL/";

  # Sources
  nixos-stable = fetchGit {
    name = "nixos-stable-${pin-date}";
    url = url-nixpkgs;
    ref = "refs/heads/nixos-${channel}";
    rev = "27c13997bf450a01219899f5a83bd6ffbfc70d3c";
  };
  home-manager = fetchGit {
    name = "home-manager-${pin-date}";
    url = url-homemgr;
    ref = "refs/heads/release-${channel}";
    rev = "86853e31dc1b62c6eeed11c667e8cdd0285d4411";
  };
  nixgl-git = fetchGit {
    name = "nixgl-${pin-date}";
    url = url-nixgl;
    ref = "refs/heads/main";
    rev = "310f8e49a149e4c9ea52f1adf70cdc768ec53f8a";
  };

  # Constructed commands to run in bash scripts
  cmd-lsrev = "git ls-remote -h";
  cmd-1starg = "| cut -f1";
  cmd-getrev-nixpkgs = "${cmd-lsrev} ${url-nixpkgs} nixos-${channel} ${cmd-1starg}";
  cmd-getrev-homemgr = "${cmd-lsrev} ${url-homemgr} release-${channel} ${cmd-1starg}";
  cmd-getrev-nixgl = "${cmd-lsrev} ${url-nixgl} main ${cmd-1starg}";
in
{
  imports = [
    # Declaratively set home-manager
    (import "${home-manager}/nixos")
  ];

  # Declaratively set nixpkgs
  nix.nixPath = [
    "nixpkgs=${nixos-stable}"
    "nixos-config=/etc/nixos/configuration.nix"
  ];

  nixpkgs.config = {
    # Allow unfree packages
    allowUnfree = true;
    # Add unstable packages
    packageOverrides = pkgs: {
      # Make nixgl available
      nixgl = import nixgl-git { };
    };
  };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Mumble chat server
  services.murmur = {
    enable = true;
    openFirewall = true;
  };

  programs = {
    steam = {
      enable = true;
      # localNetworkGameTransfers.openFirewall = true; # future config
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        steamtinkerlaunch
      ];
    };

    bash = {
      interactiveShellInit = ''
        # Bind up and down arrow keys for history search
        bind '"\e[A": history-search-backward'
        bind '"\e[B": history-search-forward'
        # Neofetch alternative
        fastfetch
      '';
    };

    # Systemwide git configuration
    git = {
      enable = true;
      config = {
        init.defaultBranch = "main";
        safe.directory = "/etc/nixos";
      };
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # List packages installed in system profile. To search, run:
  # list-packages-exposed or list-packages-all
  environment.systemPackages = with pkgs; [
    # Steam addon
    steamtinkerlaunch
    # Neofetch alternative
    fastfetch
    # Default browser
    firefox
    # Office suite
    krita
    libreoffice
    # General programming tools
    fira-code
    git
    libsForQt5.kcharselect
    micro
    neovim
    # Custom shell scripts
    (writeShellScriptBin "nixos-printrevs" ''
      echo -e "nixpkgs:\t$(${cmd-getrev-nixpkgs})" &&
        echo -e "homemgr:\t$(${cmd-getrev-homemgr})" &&
        echo -e "nixgl:\t\t$(${cmd-getrev-nixgl})"
    '')
    (writeShellScriptBin "nixos-listpkgs" ''
      nix-store -q --requisites /run/current-system/sw |
        sed 's|/nix/store/[a-z0-9]*-||' |
        sort |
        uniq |
        column -c "$(tput cols)"
    '')
  ];

  # Install in /etc/profiles instead of $HOME/.nix-profile
  home-manager.useUserPackages = true;

  # Use global pkgs
  home-manager.useGlobalPkgs = true;
}
