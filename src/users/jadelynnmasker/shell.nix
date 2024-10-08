{ pkgs, ... }: {
  home.packages = with pkgs; [
    wl-clipboard # needed for clipboard
  ];

  programs = {
    zellij = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        theme = "nord";
        default_layout = "compact";
        copy_command = "wl-copy";
      };
    };
    zsh = {
      enable = true;
      sessionVariables = {
        ZELLIJ_AUTO_ATTACH = "true";
        ZELLIJ_AUTO_EXIT = "true";
      };
    };
  };
}
