{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Language support
    markdown-oxide # markdown
    nil            # nix
    nixpkgs-fmt    # nix
    taplo          # toml
  ];

  programs.helix = {
    enable = true;
    settings = {
      theme = "dark_plus";
      editor = {
        statusline.mode = {
          insert = "INSERT";
          normal = "NORMAL";
          select = "SELECT";
        };
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        cursor-shape = {
          insert = "bar";
          normal = "underline";
          select = "block";
        };
        auto-save = true;
        whitespace = {
          render = {
            space = "none";
            tab = "all";
            nbsp = "all";
            nnbsp = "all";
            newline = "none";
          };
          characters = {
            tab = "⎸";
            tabpad = "―";
          };
        };
        indent-guides = {
          render = true;
          character = "⎸";
          skip-levels = 1;
        };
        soft-wrap.enable = true;
        rulers = [80 100 120];
      };
    };
    languages = {
      language-server.rust-analyzer.config = {
        check.overrideCommand = "clippy";
      };
      language = [
        {
          name = "nix";
          formatter.command = "nixpkgs-fmt";
        }
      ];
    };
  };
}
