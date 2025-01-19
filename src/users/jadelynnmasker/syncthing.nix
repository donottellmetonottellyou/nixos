{ config, ... }: {
  services.syncthing = {
    enable = true;

    user = "jadelynnmasker";
    dataDir = "/home/jadelynnmasker";

    openDefaultPorts = true;
    overrideDevices = false;
    settings = {
      folders = {
        "Camera" = {
          path = "${config.services.syncthing.dataDir}/Camera";
          versioning = {
            type = "trashcan";
            params.cleanoutDays = 30;
          };
        };
        "Documents" = {
          path = "${config.services.syncthing.dataDir}/Documents";
          versioning = {
            type = "trashcan";
            params.cleanoutDays = 30;
          };
        };
      };
    };
  };
}
