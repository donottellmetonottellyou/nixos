{ config, ... }: {
  services.syncthing = {
    enable = true;

    user = "jadelynnmasker";
    dataDir = "/home/jadelynnmasker";

    openDefaultPorts = true;
    settings = {
      devices.dendorian.id = "XCOYGHU-ZCI7VDM-MGE4XHN-XRQGZTM-X3XHD6P-VG2XM7K-633PSJS-P6K3KA5";
      folders = {
        "Camera" = {
          path = "${config.services.syncthing.dataDir}/Pictures/Camera";
          devices = [ "dendorian" ];
          versioning = {
            type = "trashcan";
            params.cleanoutDays = 30;
          };
        };
        "Documents" = {
          path = "${config.services.syncthing.dataDir}/Documents";
          devices = [ "dendorian" ];
          versioning = {
            type = "trashcan";
            params.cleanoutDays = 30;
          };
        };
      };
    };
  };
}
