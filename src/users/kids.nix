{ config, ... }: {
  # MAIN USER
  users.users.kids = {
    isNormalUser = true;
    description = "Kids";
    extraGroups = [ ];
  };

  home-manager.users.kids = { pkgs, ... }: {
    home.stateVersion = config.system.stateVersion;

    home.packages = with pkgs; [
      prismlauncher
    ];
  };
}
