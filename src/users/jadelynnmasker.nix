{ config, ... }: {
  # MAIN USER
  users.users.jadelynnmasker = {
    isNormalUser = true;
    description = "Jade Lynn Masker";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.users.jadelynnmasker = { pkgs, ... }: {
    home.stateVersion = config.system.stateVersion;

    home.packages = with pkgs; [
      # Productivity
      clockify
      keepassxc
      # Chat
      discord
      slack
      zoom-us
      # Games
      digital
      prismlauncher
    ];

    programs = {
      git = {
        enable = true;
        userName = "Jade Lynn Masker";
        userEmail = "donottellmetonottellyou@gmail.com";
        extraConfig = {
          # Editor/pager
          core = {
            editor = "hx";
            pager = "less -F -X";
          };

          # Diff/merge tools
          diff.tool = "hx";
          difftool = {
            prompt = false;
            hx.cmd = "hx";
          };
          merge.tool = "hx";
          mergetool = {
            prompt = false;
            hx.cmd = "hx";
          };

          # Signing
          user.signingkey = "5C8B71284AB3000D4AC662349B8135A24A75CB86";
          commit.gpgSign = true;
          push.gpgSign = "if-asked";
          tag.gpgSign = true;
        };
      };

      helix = {
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
            soft-wrap = {
              enable = true;
              wrap-at-text-width = true;
            };
          };
        };
      };

      vscode = {
        enable = true;
        enableUpdateCheck = false;
        mutableExtensionsDir = false;
        extensions = (with pkgs.vscode-extensions; [
          # General
          editorconfig.editorconfig
          equinusocio.vsc-material-theme-icons
          mkhl.direnv
          naumovs.color-highlight
          oderwat.indent-rainbow
          # Compiled Languages Debug
          vadimcn.vscode-lldb
          # C++
          ms-vscode.cpptools
          xaver.clang-format
          # C#
          ms-dotnettools.csdevkit
          ms-dotnettools.csharp
          # Java
          vscjava.vscode-java-pack
          # Markdown
          stkb.rewrap
          yzhang.markdown-all-in-one
          # Nix
          jnoortheen.nix-ide
          # Rust
          rust-lang.rust-analyzer
          tamasfe.even-better-toml
          # Web
          esbenp.prettier-vscode
          formulahendry.auto-close-tag
          formulahendry.auto-rename-tag
          ritwickdey.liveserver
          vincaslt.highlight-matching-tag
        ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          # General
          {
            name = "dependi";
            publisher = "fill-labs";
            version = "0.7.9";
            hash = "sha256-VsjISVDZGGh6/pf3Fd5g8pYDvWXA1+0oZKlQEGLBp4M=";
          }
          {
            name = "vscord";
            publisher = "LeonardSSH";
            version = "5.2.13";
            hash = "sha256-Jgm3ekXFLhylX7RM6tdfi+lRLrcl4UQGmRHbr27M59M=";
          }
          # C++
          {
            name = "c-cpp-flylint";
            publisher = "jbenden";
            version = "1.15.0";
            hash = "sha256-k6sH0Rx4VjGmKjvCR9x/OWrxmo7+S2bvRlZi3Z9PNPw=";
          }
          # C#
          {
            name = "vscode-dotnet-runtime";
            publisher = "ms-dotnettools";
            version = "2.1.5";
            hash = "sha256-6KtcJ4n/XeteLK7KO4PkJgIZn6I5qjimyTPDGMU5DxI=";
          }
          # Godot
          {
            name = "godot-tools";
            publisher = "geequlim";
            version = "2.1.0";
            hash = "sha256-/0D4IJQXcjVtmX5gLKfEvviTQM595Y0EzCxlmVnsnJw=";
          }
        ];

        userSettings = {
          # =========================
          #  GENERAL EDITOR SETTINGS
          # =========================
          # Appearance
          "editor.colorDecorators" = false;
          "editor.cursorBlinking" = "phase";
          "editor.cursorStyle" = "line";
          "editor.experimentalWhitespaceRendering" = "font";
          "editor.guides.highlightActiveIndentation" = "always";
          "editor.minimap.enabled" = false;
          "window.menuBarVisibility" = "hidden";
          "editor.rulers" = [
            {
              "column" = 80;
            }
            {
              "column" = 100;
            }
            {
              "column" = 120;
            }
          ];
          "editor.renderWhitespace" = "boundary";
          "editor.wordWrap" = "bounded";
          "editor.wordWrapColumn" = 120;
          "editor.wrappingIndent" = "deepIndent";
          "window.titleBarStyle" = "native";
          "workbench.editor.highlightModifiedTabs" = true;
          "workbench.iconTheme" = "eq-material-theme-icons";
          "workbench.sideBar.location" = "right";
          # Font
          "chat.editor.fontSize" = 12;
          "chat.editor.lineHeight" = 18;
          "debug.console.fontSize" = 12;
          "debug.console.lineHeight" = 18;
          "editor.codeLensFontSize" = 12;
          "editor.fontFamily" = "'Fira Code', monospace";
          "editor.fontLigatures" = true;
          "editor.fontSize" = 12;
          "editor.lineHeight" = 18;
          "markdown.preview.fontSize" = 12;
          "markdown.preview.lineHeight" = 1.25;
          "notebook.markup.fontSize" = 12;
          "scm.inputFontSize" = 12;
          "screencastMode.fontSize" = 48;
          "terminal.integrated.fontSize" = 12;
          # Behavior
          "editor.autoClosingBrackets" = "languageDefined";
          "editor.autoClosingComments" = "languageDefined";
          "editor.autoClosingDelete" = "always";
          "editor.autoClosingOvertype" = "always";
          "editor.autoClosingQuotes" = "languageDefined";
          "editor.folding" = false;
          "editor.formatOnPaste" = true;
          "editor.formatOnSave" = true;
          "editor.formatOnType" = true;
          "editor.inlayHints.enabled" = "offUnlessPressed";
          "editor.insertSpaces" = true;
          "editor.linkedEditing" = true;
          "editor.stickyTabStops" = true;
          "explorer.compactFolders" = false;
          "explorer.confirmDelete" = false;
          "explorer.confirmDragAndDrop" = false;
          "explorer.excludeGitIgnore" = true;
          "files.autoSave" = "onFocusChange";
          "files.insertFinalNewline" = true;
          "files.trimFinalNewlines" = true;
          "files.trimTrailingWhitespace" = true;
          "git.openRepositoryInParentFolders" = "always";
          "security.workspace.trust.emptyWindow" = true;
          "security.workspace.trust.startupPrompt" = "never";
          "security.workspace.trust.untrustedFiles" = "newWindow";
          "terminal.integrated.confirmOnExit" = "hasChildProcesses";
          "terminal.integrated.confirmOnKill" = "always";
          "terminal.integrated.enablePersistentSessions" = false;
          "terminal.integrated.persistentSessionReviveProcess" = "never";
          "terminal.integrated.tabs.hideCondition" = "never";
          # ========================================
          #  Language / Extension Specific Settings
          # ========================================
          # General
          "color-highlight.markRuler" = false;
          "indentRainbow.colors" = [
            "rgba(15, 0, 0, 0.25)"
            "rgba(0, 15, 0, 0.25)"
            "rgba(0, 0, 15, 0.25)"
            "rgba(15, 15, 0, 0.25)"
            "rgba(15, 0, 15, 0.25)"
            "rgba(0, 15, 15, 0.25)"
            "rgba(63, 0, 0, 0.25)"
            "rgba(0, 63, 0, 0.25)"
            "rgba(0, 0, 63, 0.25)"
            "rgba(63, 63, 0, 0.25)"
            "rgba(63, 0, 63, 0.25)"
            "rgba(0, 63, 63, 0.25)"
            "rgba(255, 0, 0, 0.25)"
            "rgba(0, 255, 0, 0.25)"
            "rgba(0, 0, 255, 0.25)"
            "rgba(255, 255, 0, 0.25)"
            "rgba(255, 0, 255, 0.25)"
            "rgba(0, 255, 255)"
            "rgb(255, 0, 0)"
            "rgb(0, 255, 0)"
            "rgb(0, 0, 255)"
            "rgb(255, 255, 0)"
            "rgb(255, 0, 255)"
            "rgb(0, 255, 255)"
            "rgb(255,255,255)"
            "rgb(255,255,255)"
            "rgb(255,255,255)"
            "rgba(0, 0, 0, 0)"
            "rgba(0, 0, 0, 0)"
            "rgba(0, 0, 0, 0)"
          ];
          "indentRainbow.errorColor" = "rgba(255, 255, 255, 0.25)";
          "indentRainbow.excludedLanguages" = [ "plaintext" "markdown" ];
          # C/C++
          "c-cpp-flylint.flawfinder.enable" = false;
          "c-cpp-flylint.flexelint.enable" = false;
          "c-cpp-flylint.language" = "c";
          "c-cpp-flylint.lizard.enable" = false;
          # Discord Rich Presence
          "vscord.app.name" = "Visual Studio Code";
          # Godot
          "godotTools.editorPath.godot4" = "godot4";
          "godotTools.lsp.autoReconnect.attempts" = 10;
          "godotTools.lsp.autoReconnect.cooldown" = 1000;
          # Nix
          "[nix]" = {
            "editor.defaultFormatter" = "jnoortheen.nix-ide";
          };
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          # Rewrap
          "[git-commit]"."rewrap.wrappingColumn" = 72;
          "rewrap.wrappingColumn" = 80;
          # Rust
          "[rust]"."editor.defaultFormatter" = "rust-lang.rust-analyzer";
          "rust-analyzer.check.command" = "clippy";
          "rust-analyzer.lens.implementations.enable" = false;
          # Toml
          "evenBetterToml.formatter.columnWidth" = 80;
          # Web
          "[css]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[jsonc]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[markdown]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
            "editor.guides.indentation" = false;
            "editor.renderWhitespace" = "none";
            "editor.tabSize" = 4;
          };
          "liveServer.settings.donotShowInfoMsg" = true;
          "prettier.tabWidth" = 2;
        };
      };
    };

  };
}
