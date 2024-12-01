{pkgs, ...}: {
  services = {
    ollama = {
      enable = true;
      package = pkgs.unstable.ollama;
      acceleration = false;
    };
    open-webui = {
      enable = true;
      openFirewall = true;
    };
  };
}
