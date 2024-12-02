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
      keybindings = {
        "shift+left" = "move_window left";
        "shift+right" = "move_window right";
      };
      shellIntegration.enableZshIntegration = true;
      settings = {
        scrollback_lines = 10000;
        background = "#1a1d1f";
        foreground = "#ffffff";
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
