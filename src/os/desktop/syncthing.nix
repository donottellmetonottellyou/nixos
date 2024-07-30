{ ... }:
let
  home = "/home/jadelynnmasker";
in
{
  users.users.syncthing.extraGroups = [
    "wheel"
  ];

  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    settings = {
      options = {
        limitBandwidthInLan = true;
        maxFolderConcurrency = 1;
        relaysEnabled = false;
        urAccepted = 3;
      };
      devices = {
        dendorian.id = "WEH2EXP-CS72MGX-Z4OBGGI-63QCS3J-2VNNMKA-NZJVWP6-UZZ5ACW-N4SRDAZ";
      };
      folders = {
        Camera = {
          path = "${home}/Pictures/Camera";
          devices = [ "dendorian" ];
          copyOwnershipFromParent = true;
        };
        Documents = {
          path = "${home}/Documents";
          devices = [ "dendorian" ];
          copyOwnershipFromParent = true;
        };
      };
    };
  };
}
