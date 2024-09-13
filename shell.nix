{ pkgs ? import <nixpkgs> { } }:
let
  nixos-commit-configuration = pkgs.writeShellScriptBin "nixos-commit-configuration" ''
    git commit

    cd /etc/nixos &&
      sudo git merge --ff-only worktree || {
        echo "Failed to apply changes cleanly to /etc/nixos!"
        echo "Was /etc/nixos dirtied?"
        exit 1
      }
  '';
  nixos-push-configuration = pkgs.writeShellScriptBin "nixos-push-configuration" ''
    cd /etc/nixos &&
      git push || {
        echo "Failed to push changes to remote!"
        echo "Do changes in the remote need to be integrated?"
        exit 1
      }
  '';
  nixos-amend-configuration = pkgs.writeShellScriptBin "nixos-amend-configuration" ''
    git commit --amend

    cd /etc/nixos &&
      sudo git reset --hard HEAD~1 &&
      sudo git merge --ff-only worktree || {
        echo "Failed to reapply commit to /etc/nixos!"
        echo "Be careful to investigate completely!"
        exit 1
      }
  '';
in
pkgs.mkShell {
  packages = [
    nixos-commit-configuration
    nixos-push-configuration
    nixos-amend-configuration
  ];
}
