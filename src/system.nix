{ ... }: {
  imports = [
    ./system/global.nix
    ./system/plasma.nix

    ./system/ai.nix
    ./system/browsers.nix
    ./system/devtools.nix
    ./system/snapshots.nix
    ./system/steam.nix
  ];
}
