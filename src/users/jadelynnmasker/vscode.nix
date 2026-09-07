{ config, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    package = (
      pkgs.vscode.overrideAttrs { extraNativeBuildInputs = config.programs.helix.extraPackages; }
    );
  };
}
