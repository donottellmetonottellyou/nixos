{ config, ... }: {
  # MAIN USER
  users.users.jadelynnmasker = {
    isNormalUser = true;
    description = "Jade Lynn Masker";
    extraGroups = [ "networkmanager" "wheel" ];
  };

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
      lutris
      gnome3.adwaita-icon-theme
      prismlauncher
      wine-wayland
      # C/C++
      clang_17
      clang-tools_17
      cppcheck
      # CSharp
      dotnet-sdk_8
      # Godot
      godot_4
      # Nix
      nixd
      nixpkgs-fmt
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
          equinusocio.vsc-material-theme-icons
          naumovs.color-highlight
          oderwat.indent-rainbow
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
          formulahendry.auto-close-tag
          formulahendry.auto-rename-tag
          ritwickdey.liveserver
          vincaslt.highlight-matching-tag
        ] ++ vscode-utils.extensionsFromVscodeMarketplace [
          # General
          {
            name = "vscord";
            publisher = "LeonardSSH";
            version = "5.2.9";
            sha256 = "HJvVpX2cativdyxsnVjJBRvITwmkyoWehafWL95S2B0=";
          }
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
            name = "vscode-standard";
            publisher = "standard";
            version = "2.1.3";
            sha256 = "EyaMpDBC1ePqN9hDg6s8yyhuLGbZUGDDqmhiBsmenf8=";
          }
        ];
      })
    ];

    home.stateVersion = config.system.stateVersion;
  };
}
