{ config, pkgs, ... }: {
  # Disable suspend on laptop lid close
  services.logind.lidSwitchExternalPower = "ignore";

  environment.etc."NetworkManager/conf.d/custom.conf".text = ''
    [connection]
    wifi.powersave = 2
  '';
}
