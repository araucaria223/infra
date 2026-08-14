{
  flake.wrappers.emacs = {
    pkgs,
    wlib,
    ...
  }: {
    imports = [wlib.wrapperModules.emacs];

    package = pkgs.emacs-pgtk;

    emacsPackages = epkgs: with epkgs.melpaPackages; [
      evil
      doom-themes
      which-key
      vterm
      nix-mode
    ];
    userDirectory = "~/.config/emacs";

    configFile = ''
      (require 'evil)
      (require  'nix-mode)
      (require 'which-key)
      (require 'vterm)

      (evil-mode 1)
      (load-theme 'doom-one t)
      (global-display-line-numbers-mode 1)

      (add-to-list 'default-frame-alist '(undecorated . t))
      (set-frame-parameter nil 'undecorated t)

      (menu-bar-mode -1)
      (tool-bar-mode -1)
      (scroll-bar-mode -1)
    '';
  };
}
