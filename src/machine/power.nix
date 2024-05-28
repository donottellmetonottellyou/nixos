{ ... }: {
  # Disable suspend on laptop lid close
  services.logind.lidSwitchExternalPower = "ignore";

  # Disable wifi shutoff when screen is locked etc
  environment.etc."NetworkManager/conf.d/custom.conf".text = ''
    [connection]
    wifi.powersave = 2
  '';
}
