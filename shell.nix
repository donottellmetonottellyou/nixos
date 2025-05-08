{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  packages = with pkgs; [
    git
    nix-output-monitor

    (writeShellScriptBin "fast-switch-config" ''
      sudo nixos-rebuild switch --fast --log-format internal-json |&
        sudo nom --json
    '')
    (writeShellScriptBin "fast-boot-config" ''
      sudo nixos-rebuild boot --fast --log-format internal-json |&
        sudo nom --json
    '')
    (writeShellScriptBin "update-boot-config" ''
      sudo nixos-rebuild boot --upgrade-all --log-format internal-json |&
        sudo nom --json
    '')
    (writeShellScriptBin "commit-config" ''
      git add -i || exit 1
      git commit

      cd /etc/nixos &&
        sudo git merge --ff-only worktree || {
          echo "Failed to apply changes cleanly to /etc/nixos!"
          echo "Was /etc/nixos dirtied?"
          exit 1
        }
    '')
    (writeShellScriptBin "push-config" ''
      cd /etc/nixos &&
        git push || {
          echo "Failed to push changes to remote!"
          echo "Do changes in the remote need to be integrated?"
          exit 1
        }
    '')
    (writeShellScriptBin "amend-config" ''
      git add -i || exit 1
      git commit --amend

      cd /etc/nixos &&
        sudo git reset --hard HEAD~1 &&
        sudo git merge --ff-only worktree || {
          echo "Failed to reapply commit to /etc/nixos!"
          echo "Be careful to investigate completely!"
          exit 1
        }
    '')
    (writeShellScriptBin "list-pkgs" ''
      nix-store -q --requisites /run/current-system/sw |
        sed 's|/nix/store/[a-z0-9]*-||' |
        sort |
        uniq |
        column -c "$(tput cols)"
    '')
  ];
}
