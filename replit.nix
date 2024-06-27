{ pkgs }: {
  deps = [
    pkgs.pkg-config
    pkgs.ncurses
    pkgs.gdb
    pkgs.go_1_19
    pkgs.rustc
    pkgs.typescript
    pkgs.temurin-bin-18
    pkgs.graalvmCEPackages.truffleruby
    pkgs.docker-compose_1
    pkgs.fetchutils
    pkgs.google-cloud-sdk-gce
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