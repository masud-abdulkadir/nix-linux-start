{
  pkgs,
  nix-index-database,
  username,
  homeDir,
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


  home = {
    # User & Home Directory 
    username = "${username}";
    homeDirectory = "/home/${username}";

    #packages
    home.packages = stable-packages ++ unstable-packages;

    #stateVersion
    stateVersion = "24.05";

  };


  programs = {
    home-manager.enable = true;
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
   };
