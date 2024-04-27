{ config, pkgs, ... }:
let
  channel = "23.11";

  nixos-stable = fetchGit {
    name = "nixos-stable-20240418"; # Add date later with script
    url = "https://github.com/nixos/nixpkgs/";
    ref = "refs/heads/nixos-${channel}";
    # `git ls-remote https://github.com/nixos/nixpkgs nixos-channel`
    rev = "dd37924974b9202f8226ed5d74a252a9785aedf8";
  };
  home-manager = fetchGit {
    name = "home-manager-20240407"; # Add date later with script
    url = "https://github.com/nix-community/home-manager/";
    ref = "refs/heads/release-${channel}";
    # `git ls-remote https://github.com/nix-community/home-manager release-channel`
    rev = "86853e31dc1b62c6eeed11c667e8cdd0285d4411";
  };

  # NixGL allows for running opengl binaries easier on nixos
  nixgl-git = fetchGit {
    name = "nixgl-20240402";
    url = "https://github.com/nix-community/nixGL/";
    ref = "refs/heads/main";
    # `git ls-remote https://github.com/nix-community/nixGL/ main`
    rev = "310f8e49a149e4c9ea52f1adf70cdc768ec53f8a";
  };
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

    # Improve bash command history search
    bash.interactiveShellInit = ''
      # Bind up and down arrow keys for history search
      bind '"\e[A": history-search-backward'
      bind '"\e[B": history-search-forward'
    '';

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
    libreoffice
    # General programming tools
    fira-code
    git
    libsForQt5.kcharselect
    micro
    neovim
    # Custom shell scripts
    (writeShellScriptBin "list-packages-exposed" ''
      nixos-option environment.systemPackages |
        grep "derivation" |
        sed -e 's/^.*\([a-z0-9]\{32\}\)-\([^/]*\)\.drv.*$/\2/' |
        sort |
        uniq |
        column -c "$(tput cols)"
    '')
    (writeShellScriptBin "list-packages-all" ''
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
