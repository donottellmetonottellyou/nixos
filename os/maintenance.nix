{ config, pkgs, ... }: {
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
}
