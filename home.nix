{
  pkgs,
  nix-index-database,
}: let
  unstable-packages = with pkgs.unstable; [
    bottom
    coreutils
    curl
    du-dust
    fd
    findutils
    fx
    git
    git-crypt
    jq
    killall
    procs
    ripgrep
    tmux
    tre
    unzip
    vim
    wget
    zip
  ];

  stable-packages = with pkgs; [
    # key tools
    gh # for bootstrapping
    just

    # core languages
    rustup

    # rust stuff
    cargo-cache
    cargo-expand

    # treesitter
    tree-sitter

    # language servers
    nil # nix

    # formatters and linters
    alejandra # nix
    deadnix # nix
    nodePackages.prettier
    shellcheck
    shfmt
    statix # nix
  ];
in {
  imports = [
    nix-index-database.hmModules.nix-index
  ];


  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "dlurker";
  home.homeDirectory = "/home/dlurker";


  home.packages = stable-packages ++ unstable-packages;

  home.stateVersion = "24.05";


  programs = {
    home-manager.enable = true;
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
   };
