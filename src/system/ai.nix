{...}: {
  services = {
    ollama = {
      enable = true;
      acceleration = false;
      sandbox = false;
    };
    open-webui = {
      enable = true;
      openFirewall = true;
    };
  };
}
