{ config, pkgs, ... }: {
  imports = [ ./jadelynnmasker.nix ];

  # MAIN USER
  users.users.jadelynnmasker = {
    isNormalUser = true;
    description = "Jade Lynn Masker";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
