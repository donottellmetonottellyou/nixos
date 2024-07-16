{ pkgs ? import <nixpkgs> { } }:
let
  cmd-user-nix = "cd /home/jadelynnmasker/Code/NixOS";

  git-apply-worktree = pkgs.writeShellScriptBin "git-apply-worktree" ''
    git add -A &&
      git commit

    cd /etc/nixos &&
      sudo git merge --ff-only worktree &&
      ${cmd-user-nix} || {
        echo "Failed to apply changes cleanly to /etc/nixos!"
        echo "Was /etc/nixos dirtied?"
        exit 1
      }
  '';
  git-push-worktree = pkgs.writeShellScriptBin "git-push-worktree" ''
    ${git-apply-worktree}/bin/git-apply-worktree &&
      cd /etc/nixos &&
      git push &&
      ${cmd-user-nix} || {
        echo "Failed to push changes to remote!"
        echo "Do changes in the remote need to be integrated?"
        exit 1
      }
  '';
  git-reapply-worktree = pkgs.writeShellScriptBin "git-reapply-worktree" ''
    git add -A &&
      git commit --amend &&
      cd /etc/nixos &&
      sudo git reset --hard HEAD~1 &&
      sudo git merge --ff-only worktree &&
      ${cmd-user-nix} || {
        echo "Failed to reapply commit to /etc/nixos!"
        echo "Be careful to investigate completely!"
        exit 1
      }
  '';
in
pkgs.mkShell {
  packages = [
    git-apply-worktree
    git-push-worktree
    git-reapply-worktree
  ];
}
