{ ... }: {
  imports = [
    ./system/global.nix
    ./system/packages.nix
    ./system/plasma.nix
    ./system/programs.nix

    ./system/ai.nix
  ];
}
