{ pkgs, ... }: {
  imports = [
    <home-manager/nixos>
  ];

  nixpkgs.config = {
    # Allow unfree packages
    allowUnfree = true;
  };

  users.defaultUserShell = pkgs.zsh;

  home-manager = {
    # Install in /etc/profiles instead of $HOME/.nix-profile
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "old";
  };
}
