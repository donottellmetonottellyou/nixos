{ pkgs, ... }: {
  home.packages = with pkgs; [
    wl-clipboard # needed for clipboard
  ];

  programs = {
    kitty = {
      enable = true;
      font = {
        package = pkgs.fira-code;
        name = "Fira Code";
        size = 12;
      };
      shellIntegration.enableZshIntegration = true;
      settings = {
        scrollback_lines = 0;
        background = "#1a1d1f";
        foreground = "#ffffff";
        confirm_os_window_close = 0;
      };
    };
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
