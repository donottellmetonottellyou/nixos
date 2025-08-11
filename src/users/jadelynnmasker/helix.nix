{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [
      csharpier # csharp
      netcoredbg # csharp
      omnisharp-roslyn # csharp
      clang-tools # C/C++
      lemminx # XML
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
            space = " ";
            tab = "|";
            tabpad = "-";
            nbsp = "~";
            nnbsp = "~";
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
        insert-final-newline = true;
        lsp = {
          display-progress-messages = true;
        };
      };
      keys = {
        normal.p = ":clipboard-paste-after";
        normal.P = ":clipboard-paste-before";
        normal.y = ":clipboard-yank";
      };
    };
    languages = {
      language = [
        {
          name = "c";
          auto-format = true;
        }
        {
          name = "cpp";
          auto-format = true;
        }
        {
          name = "c-sharp";
          formatter.command = "dotnet-csharpier";
          language-servers = [
            {
              name = "omnisharp";
              except-features = [ "format" ];
            }
          ];
        }
        {
          name = "nix";
          auto-format = true;
          formatter.command = "nixfmt";
        }
        {
          name = "toml";
          formatter = {
            command = "taplo";
            args = [ "format" ];
          };
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
          formatter.command = "dotnet-csharpier";
        }
      ];
      language-server = {
        omnisharp = {
          command = "OmniSharp";
        };
        lemminx = {
          command = "lemminx";
        };
        rust-analyzer = {
          config = {
            cargo.noDeps = true;
            check.command = "clippy";
          };
        };
      };
    };
  };
}
