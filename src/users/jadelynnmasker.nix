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
      # C++
      clang_17
      clang-tools_17
      cppcheck
      # C#
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
          # C#
          ms-dotnettools.csdevkit
          ms-dotnettools.csharp
          # Markdown
          yzhang.markdown-all-in-one
          stkb.rewrap
          # Nix
          jnoortheen.nix-ide
          # Rust
          rust-lang.rust-analyzer
          serayuzgur.crates
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
            version = "5.2.11";
            hash = "sha256-Dc8lzJYJEaKNXvGJxuQ9NulZxHFDVujYOGoeKmrltNA=";
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
            version = "2.0.5";
            hash = "sha256-acP3NULTNNyPw5052ZX1L+ymqn9+t4ydoCns29Ta1MU=";
          }
          # Godot
          {
            name = "godot-tools";
            publisher = "geequlim";
            version = "2.0.0";
            hash = "sha256-6lSpx6GooZm6SfUOjooP8mHchu8w38an8Bc2tjYaVfw=";
          }
          # Web
          {
            name = "vscode-standard";
            publisher = "standard";
            version = "2.1.3";
            hash = "sha256-EyaMpDBC1ePqN9hDg6s8yyhuLGbZUGDDqmhiBsmenf8=";
          }
        ];
      })
    ];

    home.stateVersion = config.system.stateVersion;
  };
}
