{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [
      clang-tools # C/C++
      lemminx # XML
      xq-xml # XML
      lldb # debugging in multiple languages
      markdown-oxide # markdown
      marksman # markdown
      nil # nix
      nixd # nix
      nixfmt-rfc-style # nix
      taplo # toml
      typescript-language-server # Javascript/Typescript
      vscode-langservers-extracted # HTML/CSS/JSON
    ];
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
        rulers = [
          80
          100
          120
        ];
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
          formatter.command = "nixfmt";
        }
        {
          name = "xml";
          auto-format = true;
          language-servers = [
            {
              name = "lemminx";
              except-features = [ "format" ];
            }
          ];
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
