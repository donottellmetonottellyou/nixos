{ pkgs, config, ... }:
{
  users.users.lfs = {
    isNormalUser = true;
    description = "Linux From Scratch User";
    group = "lfs";
    useDefaultShell = false;
    shell = pkgs.bash;
  };

  users.groups.lfs.name = "lfs";
}
