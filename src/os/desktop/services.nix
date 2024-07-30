{ ... }: {
  services = {
    # Mumble chat server
    murmur = {
      enable = true;
      openFirewall = true;
    };

    # Peer-to-peer cloud synchronization
    syncthing = {
      enable = true;
      openDefaultPorts = true;
      guiAddress = null;
      dataDir = "/home/jadelynnmasker";
      settings = {
        options = {
          limitBandwidthInLan = true;
          maxFolderConcurrency = 1;
          relaysEnabled = false;
          urAccepted = 1;
        };
        devices = {
          dendorian.id = "WEH2EXP-CS72MGX-Z4OBGGI-63QCS3J-2VNNMKA-NZJVWP6-UZZ5ACW-N4SRDAZ";
        };
        folders = {
          Camera = {
            path = "~/Pictures/Camera";
            devices = [ "dendorian" ];
            copyOwnershipFromParent = true;
          };
          Documents = {
            path = "~/Documents";
            devices = [ "dendorian" ];
            copyOwnershipFromParent = true;
          };
        };
      };
    };
  };
}
