{ ... }: {
  programs = {
    bash = {
      interactiveShellInit = ''
        # Bind up and down arrow keys for history search
        bind '"\e[A": history-search-backward'
        bind '"\e[B": history-search-forward'

        fastfetch --load-config neofetch
      '';
    };

    git = {
      enable = true;
      config = {
        core.fsmonitor = true;
        init.defaultBranch = "main";
        safe.directory = "/etc/nixos";
      };
    };

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    # Per-directory cached dev environments
    direnv = {
      enable = true;
      silent = true;
    };
  };
}
