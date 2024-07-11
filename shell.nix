{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  packages = with pkgs; [
    (writeShellScriptBin "git-apply-wortree" ''
      git add -A &&
        git commit &&
        cd /etc/nixos &&
        sudo git merge --ff-only worktree &&
        cd /home/jadelynnmasker/Code/NixOS
    '')
  ];
}
