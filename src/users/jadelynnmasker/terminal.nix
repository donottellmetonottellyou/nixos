{ pkgs, ... }: {
  home.packages = with pkgs; [
    wl-clipboard # needed for clipboard
  ];

  programs = {
    kitty = {
      enable = true;
      font = {
        package = pkgs.fira-code-nerdfont;
        name = "FiraCode Nerd Font";
        size = 12;
      };
      keybindings = {
        "ctrl+shift+enter" = "new_window_with_cwd";
        "ctrl+shift+n" = "new_os_window_with_cwd";
        "ctrl+shift+t" = "new_tab_with_cwd";
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
  };
}
