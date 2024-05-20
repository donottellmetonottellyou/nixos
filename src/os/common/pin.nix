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
  cmd-getrev-nixpkgs = "git ls-remote -h ${url-nixpkgs} nixos-${channel} | cut -f1";
  cmd-getrev-homemgr = "git ls-remote -h ${url-homemgr} release-${channel} | cut -f1";
  cmd-getrev-nixgl = "git ls-remote -h ${url-nixgl} main | cut -f1";
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
    (writeShellScriptBin "nixos-fetch-revs" ''
      check_hash_status() {
        local name=$1
        local hash=$2
        local pin_path="/etc/nixos/src/os/common/pin.nix"

        if [ ! -e "$pin_path" ]; then
          echo "Script expects sources to be pinned at $pin_path: aborting."
          exit 1
        fi

        if grep -q "$hash" "$pin_path"; then
          echo -e "$name:\t\t\t\t\t\t\tUp to date."
        else
          echo -e "$name:\t$hash\tNot found!"
        fi
      }

      check_hash_status "nixpkgs" "$(${cmd-getrev-nixpkgs})"
      check_hash_status "homemgr" "$(${cmd-getrev-homemgr})"
      check_hash_status "  nixgl" "$(${cmd-getrev-nixgl})"
    '')
  ];

  # Install in /etc/profiles instead of $HOME/.nix-profile
  home-manager.useUserPackages = true;

  # Use global pkgs
  home-manager.useGlobalPkgs = true;
}
