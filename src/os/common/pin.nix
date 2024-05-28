{ ... }: {
  imports = [
    <home-manager/nixos>
  ];

  nixpkgs.config = {
    # Allow unfree packages
    allowUnfree = true;
  };

  # Install in /etc/profiles instead of $HOME/.nix-profile
  home-manager.useUserPackages = true;

  # Use global pkgs
  home-manager.useGlobalPkgs = true;
}
