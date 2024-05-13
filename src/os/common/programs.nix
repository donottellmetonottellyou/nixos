{ config, pkgs, ... }: {
  programs = {
    bash = {
      interactiveShellInit = ''
        # Bind up and down arrow keys for history search
        bind '"\e[A": history-search-backward'
        bind '"\e[B": history-search-forward'
        # Neofetch alternative
        fastfetch --load-config neofetch
      '';
    };

    # Systemwide git configuration
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
  };
}
