{ pkgs, ... }:
{
  programs = {
    niri.enable = true; # window manager
    waybar = {
      # wayland bar
      enable = true;
      systemd.target = "niri.service";
    };
  };

  environment.systemPackages = with pkgs; [
    alacritty # terminal
    fuzzel # application launcher
    mako # notifications
    swaybg # wallpaper
    swayidle # idling
    swaylock # locking the screen
    xwayland-satellite # xwayland inside wayland
  ];

  security.soteria.enable = true; # enable elevating to root

  systemd.user = {
    services = {
      niri = {
        name = "niri.service";
        upholds = [
          # provided by packages
          "mako.service"
          "waybar.service"

          # custom services
          "swaybg.service"
          "swayidle.service"
        ];
      };

      swaybg = {
        name = "swaybg.service";
        serviceConfig = {
          ExecStart = "${pkgs.swaybg}/bin/swaybg -m fill -i '%h/Desktop/background.png'";
        };
      };
      swayidle = {
        name = "swayidle.service";
        serviceConfig = {
          ExecStart = "${pkgs.swayidle}/bin/swayidle -w timeout 601 'niri msg action power-off-monitors' timeout 600 'swaylock -f' before-sleep 'swaylock -f'";
        };
      };
    };
  };
}
