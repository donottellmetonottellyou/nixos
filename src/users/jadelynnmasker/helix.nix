{ pkgs, ... }: {
  home = {
    packages = with pkgs; [
      # ================
      # Language support
      # ================
      lemminx # XML
      xq-xml # XML
      lldb # debugging in multiple languages
      markdown-oxide # markdown
      nil # nix
      nixpkgs-fmt # nix
      taplo # toml
      vscode-langservers-extracted # HTML/CSS/JSON/Javascript
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
        rulers = [ 80 100 120 ];
      };
      keys = {
        normal.p = ":clipboard-paste-after";
        normal.P = ":clipboard-paste-before";
        normal.y = ":clipboard-yank";
      };
    };
    languages = {
      language-server.rust-analyzer.config = {
        check.overrideCommand = "clippy";
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "nixpkgs-fmt";
        }
        {
          name = "xml";
          auto-format = true;
          language-servers = [{
            name = "lemminx";
            except-features = [ "format" ];
          }];
          formatter.command = "xq";
        }
      ];
      language-server = {
        lemminx = {
          command = "lemminx";
        };
      };
    };
  };
}
