{ config, pkgs, ... }: {
  home-manager.users.jadelynnmasker = { pkgs, ... }: {

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
          user.signingKey = "BDA496D2B8AFE0B087AC49B60EFCE08AB6147F98";
          commit.gpgSign = true;
          push.gpgSign = "if-asked";
          tag.gpgSign = true;
        };
      };
    };


    home.packages = with pkgs; [
      # Personal web browser
      google-chrome
      # Chat
      discord
      mumble
      slack
      zoom-us
      # Games
      itch
      prismlauncher
      # C/C++
      clang_17
      clang-tools_17
      cppcheck
      # CSharp
      dotnet-sdk_8
      # Git
      github-desktop
      # Nix
      nixd
      nixpkgs-fmt
      # Nix opengl drivers
      nixgl.auto.nixGLDefault
      # NodeJS
      corepack_20
      nodejs_20
      # Rust
      rustup
      # Personal text editor (with extensions)
      (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
          # General
          editorconfig.editorconfig
          pkief.material-icon-theme
          # C++
          ms-vscode.cpptools
          xaver.clang-format
          # CSharp
          ms-dotnettools.csharp
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
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          # C/C++
          {
            name = "c-cpp-flylint";
            publisher = "jbenden";
            version = "1.14.0";
            sha256 = "HOcFx8jjLPGW7LHq8t0mNmnuhFS+JtkD3+gCtV6eBCo=";
          }
          # Godot
          {
            name = "godot-tools";
            publisher = "geequlim";
            version = "2.0.0";
            sha256 = "6lSpx6GooZm6SfUOjooP8mHchu8w38an8Bc2tjYaVfw=";
          }
          # Rust
          {
            name = "crates";
            publisher = "serayuzgur";
            version = "0.6.6";
            sha256 = "HXoH1IgMLniq0kxHs2snym4rerScu9qCqUaqwEC+O/E=";
          }
          # Web
          {
            name = "open-in-browser";
            publisher = "techer";
            version = "2.0.0";
            sha256 = "3XYRMuWEJfhureHmx1KfT+N9aBuqDagj0FErJQF/teg=";
          }
          {
            name = "vscode-standard";
            publisher = "standard";
            version = "2.1.3";
            sha256 = "EyaMpDBC1ePqN9hDg6s8yyhuLGbZUGDDqmhiBsmenf8=";
          }
        ];
      })
    ];

    home.stateVersion = "23.11";
  };
}
