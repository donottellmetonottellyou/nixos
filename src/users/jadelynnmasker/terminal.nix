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
        background = "#1a1d1f";
        foreground = "#ffffff";
        enabled_layouts = "grid";
        tab_bar_edge = "top";
        tab_bar_style = "slant";
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
