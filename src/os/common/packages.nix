{ config, pkgs, ... }: {
  # List packages installed in system profile for servers and desktop. To
  # search, run `nixos-listpkgs`
  environment.systemPackages = with pkgs; [
    # Neofetch alternative
    fastfetch
    # General programming tools
    micro
    neovim
    # Custom shell scripts
    (writeShellScriptBin "nixos-listpkgs" ''
      nix-store -q --requisites /run/current-system/sw |
        sed 's|/nix/store/[a-z0-9]*-||' |
        sort |
        uniq |
        column -c "$(tput cols)"
    '')
  ];
}
