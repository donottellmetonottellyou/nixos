{ config, ... }:
{
  nix = {
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
      # Allow unstable packages for niche usecases and quick fixes
      unstable = import <nixos-unstable> {
        config = config.nixpkgs.config;
      };
    };
  };
}
