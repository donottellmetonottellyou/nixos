{ pkgs, ... }:
{
  services = {
    # AI Backend
    ollama = {
      enable = true;
      package = pkgs.ollama-cpu;
    };
    # AI Frontend
    open-webui = {
      enable = true;
      openFirewall = true;
    };
  };
}
