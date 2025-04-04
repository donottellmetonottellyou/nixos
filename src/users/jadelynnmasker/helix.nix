{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      # Language support
      lldb           # debugging in multiple languages
      markdown-oxide # markdown
      nil            # nix
      nixpkgs-fmt    # nix
      taplo          # toml
    ];
    sessionVariables = {
      EDITOR = "hx";
    };
  };

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
        cursor-shape = {
          insert = "bar";
          normal = "underline";
          select = "block";
        };
        auto-save = true;
        whitespace = {
          render = "all";
          characters = {
            space = ".";
            tab = "|";
            tabpad = "-";
            nbsp = "*";
            nnbsp = "*";
            newline = "\\";
          };
        };
        indent-guides = {
          render = true;
          character = "|";
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
