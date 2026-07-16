{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  packages = with pkgs; [
    git
    nix-output-monitor

    (writeShellScriptBin "fast-switch-config" ''
      set -o pipefail

      sudo nixos-rebuild switch --no-reexec --fallback --log-format internal-json |&
        sudo nom --json
    '')

    (writeShellScriptBin "fast-boot-config" ''
      set -o pipefail

      sudo nixos-rebuild boot --no-reexec --install-bootloader --fallback --log-format internal-json |&
        sudo nom --json
    '')

    (writeShellScriptBin "update-boot-config" ''
      set -o pipefail

      sudo nixos-rebuild boot --upgrade-all --install-bootloader --fallback --log-format internal-json |&
        sudo nom --json
    '')

    (writeShellScriptBin "commit-config" ''
      set -o pipefail

      git add -p || exit 1
      git commit

      sudo git -C /etc/nixos merge --ff-only worktree || {
        echo "Failed to apply changes cleanly to /etc/nixos!"
        echo "Was /etc/nixos dirtied?"
        exit 1
      }
    '')

    (writeShellScriptBin "push-config" ''
      set -o pipefail

      git -C /etc/nixos push || {
        echo "Failed to push changes to remote!"
        echo "Do changes in the remote need to be integrated?"
        exit 1
      }
    '')

    (writeShellScriptBin "amend-config" ''
      set -o pipefail

      git add -p || exit 1
      git commit --amend

      test -z "$(sudo git -C /etc/nixos status --porcelain)" || {
          echo "/etc/nixos is not clean"
          exit 1
      }

      sudo git -C /etc/nixos reset --hard HEAD~1 &&
      sudo git -C /etc/nixos merge --ff-only worktree || {
        echo "Failed to reapply commit to /etc/nixos!"
        echo "Be careful to investigate completely!"
        exit 1
      }
    '')

    (writeShellScriptBin "list-pkgs" ''
      set -o pipefail

      nix-store -q --requisites /run/current-system/sw |
        sed 's|/nix/store/[a-z0-9]*-||' |
        sort |
        uniq |
        column -c "$(tput cols)"
    '')
  ];
}
