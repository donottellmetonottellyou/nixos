{pkgs, ...}: {
  services = {
    # AI Backend
    ollama = {
      enable = true;
      package = pkgs.unstable.ollama;
      acceleration = false;
    };
    # AI Frontend
    open-webui = {
      enable = true;
      openFirewall = true;
    };
  };
}
