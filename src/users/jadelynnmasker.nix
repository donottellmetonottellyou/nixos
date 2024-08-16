{ config, ... }: {
  # MAIN USER
  users.users.jadelynnmasker = {
    isNormalUser = true;
    description = "Jade Lynn Masker";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager.users.jadelynnmasker = { pkgs, ... }: {
    home.packages = with pkgs; [
      keepassxc
      # Chat
      discord
      mumble
      slack
      zoom-us
      # Games
      digital
      lutris
      gnome3.adwaita-icon-theme
      prismlauncher
      wineWowPackages.waylandFull
    ];

    gtk = {
      enable = true;
      cursorTheme = {
        name = "Breeze";
        size = 24;
      };
    };

    programs = {
      git = {
        enable = true;
        userName = "Jade Lynn Masker";
        userEmail = "donottellmetonottellyou@gmail.com";
        extraConfig = {
          # Editor/pager
          core = {
            editor = "code --wait";
            pager = "less -F -X";
          };

          # Diff/merge tools
          diff.tool = "vscode";
          difftool.vscode.cmd = "code --wait --diff $LOCAL $REMOTE";
          merge.tool = "vscode";
          mergetool = {
            prompt = false;
            vscode.cmd = "code --wait $MERGED";
          };

          # Signing
          gpg.format = "ssh";
          user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINeyl/ImKcReudO9kQym0YD+ygcIa7bMDuEgWqZk/A0f jadelynnmasker@ananda";
          commit.gpgSign = true;
          push.gpgSign = "if-asked";
          tag.gpgSign = true;
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
          yzhang.markdown-all-in-one
          stkb.rewrap
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
            version = "0.7.1";
            hash = "sha256-RCEh3cy4JVwdEEY3LVAj+0yDQ/6KgvL3QvQEbU5EfYw=";
          }
          {
            name = "vscord";
            publisher = "LeonardSSH";
            version = "5.2.12";
            hash = "sha256-WGDEizYG6UAqe1jnhvjfFouXDA9Yr5P+BjxPahAIsTE=";
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
            version = "2.0.9";
            hash = "sha256-hbg6HQWkmEa7F5Wk2JKXpLVXHrnGKfu02uRjwjhJ50k=";
          }
          # Godot
          {
            name = "godot-tools";
            publisher = "geequlim";
            version = "2.0.0";
            hash = "sha256-6lSpx6GooZm6SfUOjooP8mHchu8w38an8Bc2tjYaVfw=";
          }
        ];

        userSettings = {
          # =========================
          #  GENERAL EDITOR SETTINGS
          # =========================
          # Appearance
          "workbench.iconTheme" = "eq-material-theme-icons";
          "window.menuBarVisibility" = "hidden";
          "window.titleBarStyle" = "native";
          "editor.minimap.enabled" = false;
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
          "editor.experimentalWhitespaceRendering" = "font";
          "workbench.sideBar.location" = "right";
          "workbench.editor.highlightModifiedTabs" = true;
          "editor.colorDecorators" = false;
          "editor.cursorStyle" = "line";
          "editor.cursorBlinking" = "phase";
          "editor.guides.highlightActiveIndentation" = "always";
          # Behavior
          "git.openRepositoryInParentFolders" = "always";
          "explorer.compactFolders" = false;
          "editor.folding" = false;
          "explorer.excludeGitIgnore" = true;
          "editor.inlayHints.enabled" = "offUnlessPressed";
          "editor.stickyTabStops" = true;
          "editor.insertSpaces" = true;
          "files.trimTrailingWhitespace" = true;
          "files.insertFinalNewline" = true;
          "editor.linkedEditing" = true;
          "explorer.confirmDelete" = false;
          "security.workspace.trust.emptyWindow" = true;
          "security.workspace.trust.untrustedFiles" = "newWindow";
          "security.workspace.trust.startupPrompt" = "never";
          "explorer.confirmDragAndDrop" = false;
          # Set font & size
          "editor.fontFamily" = "'Fira Code', monospace";
          "editor.fontLigatures" = true;
          "editor.fontSize" = 12;
          "editor.codeLensFontSize" = 12;
          "screencastMode.fontSize" = 48;
          "debug.console.fontSize" = 12;
          "scm.inputFontSize" = 12;
          "terminal.integrated.fontSize" = 12;
          "notebook.markup.fontSize" = 12;
          "chat.editor.fontSize" = 12;
          "markdown.preview.fontSize" = 12;
          # Set line heights
          "editor.lineHeight" = 18;
          "debug.console.lineHeight" = 18;
          "chat.editor.lineHeight" = 18;
          "markdown.preview.lineHeight" = 1.25;
          # Word wrap
          "editor.wordWrap" = "bounded";
          "editor.wrappingIndent" = "deepIndent";
          "editor.wordWrapColumn" = 120;
          # Disable terminal persistence
          "terminal.integrated.enablePersistentSessions" = false;
          "terminal.integrated.persistentSessionReviveProcess" = "never";
          # Confirm on terminal close
          "terminal.integrated.confirmOnExit" = "hasChildProcesses";
          "terminal.integrated.confirmOnKill" = "always";
          # Format on save/type/paste & autosave
          "files.autoSave" = "onFocusChange";
          "files.trimFinalNewlines" = true;
          "editor.formatOnPaste" = true;
          "editor.formatOnSave" = true;
          "editor.formatOnType" = true;
          # Set general code formatting rules
          "editor.autoClosingBrackets" = "beforeWhitespace";
          "editor.autoClosingComments" = "beforeWhitespace";
          "editor.autoClosingQuotes" = "beforeWhitespace";
          # ========================================
          #  Language / Extension Specific Settings
          # ========================================
          # General
          "color-highlight.markRuler" = false;
          "indentRainbow.excludedLanguages" = [ "plaintext" "markdown" ];
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
          # C/C++
          "c-cpp-flylint.language" = "c";
          "c-cpp-flylint.flexelint.enable" = false;
          "c-cpp-flylint.flawfinder.enable" = false;
          "c-cpp-flylint.lizard.enable" = false;
          # Discord Rich Presence
          "vscord.app.name" = "Visual Studio Code";
          # Godot
          "godotTools.editorPath.godot4" = "godot4";
          "godotTools.lsp.autoReconnect.cooldown" = 1000;
          "godotTools.lsp.autoReconnect.attempts" = 5;
          # Nix
          "[nix]" = {
            "editor.defaultFormatter" = "jnoortheen.nix-ide";
          };
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          # Rewrap
          "rewrap.wrappingColumn" = 80;
          "[git-commit]"."rewrap.wrappingColumn" = 72;
          # Rust
          "[rust]"."editor.defaultFormatter" = "rust-lang.rust-analyzer";
          "rust-analyzer.check.command" = "clippy";
          # Toml
          "evenBetterToml.formatter.columnWidth" = 80;
          # Web
          "liveServer.settings.donotShowInfoMsg" = true;
          "prettier.tabWidth" = 2;
          "[css]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[json]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[jsonc]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[html]"."editor.defaultFormatter" = "esbenp.prettier-vscode";
          "[markdown]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
            "editor.guides.indentation" = false;
            "editor.renderWhitespace" = "none";
            "editor.tabSize" = 4;
          };
        };
      };
    };

    home.stateVersion = config.system.stateVersion;
  };
}
