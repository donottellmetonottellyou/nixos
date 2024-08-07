{ ... }: {
  # Garbage collection and optimization
  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 30d";
    };
    settings = {
      auto-optimise-store = true;
      max-jobs = 2;
    };
  };
}
