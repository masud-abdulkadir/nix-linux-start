{
  # FIXME: uncomment the next line if you want to reference your GitHub/GitLab access tokens and other secrets
  # secrets,
  pkgs,
  nix-index-database,
  ...
}: let
  unstable-packages = with pkgs.unstable; [
    # FIXME: select your core binaries that you always want on the bleeding-edge
    bat
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
    # FIXME: customize these stable packages to your liking for the languages that you use

    # FIXME: you can add plugins, change keymaps etc using (jeezyvim.nixvimExtend {})
    # https://github.com/LGUG2Z/JeezyVim#extending
    # jeezyvim
    # jeezyvim.nixvimExtend { vimPluggins.harpoon }

    # key tools
    gh # for bootstrapping
    just

    # core languages
    rustup

    # rust stuff
    cargo-cache
    cargo-expand

    # local dev stuf

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
    username = "${username}";
    homeDirectory = "/home/${username}";

  };

  home.packages =
    stable-packages
    ++ unstable-packages
    ++
    # FIXME: you can add anything else that doesn't fit into the above two lists in here
    [
      # pkgs.some-package
      # pkgs.unstable.some-other-package
    ];

  home.stateVersion = "24.05";


  programs = {
    home-manager.enable = true;
    nix-index.enable = true;
    nix-index.enableFishIntegration = true;
    nix-index-database.comma.enable = true;
   };
