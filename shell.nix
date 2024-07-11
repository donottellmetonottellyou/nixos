{ pkgs ? import <nixpkgs> { } }:
let
  git-apply-worktree = pkgs.writeShellScriptBin "git-apply-worktree" ''
    git add -A &&
      git commit

    cd /etc/nixos &&
      sudo git merge --ff-only worktree &&
      cd /home/jadelynnmasker/Code/NixOS || {
        echo "Failed to apply changes cleanly to /etc/nixos!"
        echo "Was /etc/nixos dirtied?"
        exit 1
      }
  '';
  git-push-worktree = pkgs.writeShellScriptBin "git-push-worktree" ''
    ${git-apply-worktree}/bin/git-apply-worktree &&
      cd /etc/nixos &&
      git push &&
      cd /home/jadelynnmasker/Code/NixOS || {
        echo "Failed to push changes to remote!"
        echo "Do changes in the remote need to be integrated?"
        exit 1
      }
  '';
in
pkgs.mkShell {
  packages = [
    git-apply-worktree
    git-push-worktree
  ];
}
