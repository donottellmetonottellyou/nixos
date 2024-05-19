{ config, pkgs, ... }:
let
  channel = "23.11";

  pin-date = "20240516";

  url-nixpkgs = "https://github.com/NixOS/nixpkgs/";
  url-homemgr = "https://github.com/nix-community/home-manager/";
  url-nixgl = "https://github.com/nix-community/nixGL/";

  # Sources
  nixos-stable = fetchGit {
    name = "nixos-stable-${pin-date}";
    url = url-nixpkgs;
    ref = "refs/heads/nixos-${channel}";
    rev = "bacb8503d3a51d9e9b52e52a1ba45e2c380ad07d";
  };
  home-manager = fetchGit {
    name = "home-manager-${pin-date}";
    url = url-homemgr;
    ref = "refs/heads/release-${channel}";
    rev = "ab5542e9dbd13d0100f8baae2bc2d68af901f4b4";
  };
  nixgl-git = fetchGit {
    name = "nixgl-${pin-date}";
    url = url-nixgl;
    ref = "refs/heads/main";
    rev = "310f8e49a149e4c9ea52f1adf70cdc768ec53f8a";
  };

  # Constructed commands to run in bash scripts
  cmd-lsrev = "git ls-remote -h";
  cmd-1starg = "| cut -f1";
  cmd-getrev-nixpkgs = "${cmd-lsrev} ${url-nixpkgs} nixos-${channel} ${cmd-1starg}";
  cmd-getrev-homemgr = "${cmd-lsrev} ${url-homemgr} release-${channel} ${cmd-1starg}";
  cmd-getrev-nixgl = "${cmd-lsrev} ${url-nixgl} main ${cmd-1starg}";
in
{
  imports = [
    # Declaratively set home-manager
    (import "${home-manager}/nixos")
  ];

  # Declaratively set nixpkgs
  nix.nixPath = [
    "nixpkgs=${nixos-stable}"
    "nixos-config=/etc/nixos/configuration.nix"
  ];

  nixpkgs.config = {
    # Allow unfree packages
    allowUnfree = true;
    # Add unstable packages
    packageOverrides = pkgs: {
      # Make nixgl available
      nixgl = import nixgl-git { };
    };
  };

  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "nixos-printrevs" ''
      echo -e "nixpkgs:\t$(${cmd-getrev-nixpkgs})" &&
        echo -e "homemgr:\t$(${cmd-getrev-homemgr})" &&
        echo -e "nixgl:\t\t$(${cmd-getrev-nixgl})"
    '')
  ];

  # Install in /etc/profiles instead of $HOME/.nix-profile
  home-manager.useUserPackages = true;

  # Use global pkgs
  home-manager.useGlobalPkgs = true;
}
