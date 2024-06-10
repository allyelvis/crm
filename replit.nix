{ pkgs }: {
  deps = [
    pkgs.run
    pkgs.gitleaks
    pkgs.haskellPackages.mail-pool
    pkgs.unicon-lang
    pkgs.golines
    pkgs.haskellPackages.debian-binary
    pkgs.mysql-client
    pkgs.bashInteractive
    pkgs.nodePackages.bash-language-server
    pkgs.man
  ];
}