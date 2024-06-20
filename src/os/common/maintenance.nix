{ ... }: {
  # Garbage collection and optimization
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
      randomizedDelaySec = "1h";
    };
    settings = {
      auto-optimise-store = true;
      max-jobs = 2;
    };
  };
}
