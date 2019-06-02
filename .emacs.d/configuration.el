(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package auto-compile
  :config (auto-compile-on-load-mode))

(setq load-prefer-newer t)

(load "~/code/src/github.com/hrs/sensible-defaults.el/sensible-defaults.el")
(sensible-defaults/open-files-from-home-directory)
(sensible-defaults/increase-gc-threshold)
(sensible-defaults/delete-trailing-whitespace)
(sensible-defaults/treat-camelcase-as-separate-words)
(sensible-defaults/automatically-follow-symlinks)
(sensible-defaults/make-scripts-executable)
(sensible-defaults/single-space-after-periods)
(sensible-defaults/offer-to-create-parent-directories-on-save)
(sensible-defaults/apply-changes-to-highlighted-region)
(sensible-defaults/overwrite-selected-text)
(sensible-defaults/ensure-that-files-end-with-newline)
(sensible-defaults/confirm-closing-emacs)
(sensible-defaults/quiet-startup)
(sensible-defaults/make-dired-file-sizes-human-readable)
(sensible-defaults/shorten-yes-or-no)
(sensible-defaults/always-highlight-code)
(sensible-defaults/refresh-buffers-when-files-change)
(sensible-defaults/show-matching-parens)
(sensible-defaults/set-default-line-length-to 80)
(sensible-defaults/open-clicked-files-in-same-frame-on-mac)
(sensible-defaults/yank-to-point-on-mouse-click)
(sensible-defaults/use-all-keybindings)
(sensible-defaults/backup-to-temp-directory)

(use-package solarized-theme
  :config
  (setq solarized-scale-org-headlines nil)
  (setq solarized-use-variable-pitch nil
      solarized-height-plus-1 1.0
      solarized-height-plus-2 1.0
      solarized-height-plus-3 1.0
      solarized-height-plus-4 1.0))
  (load-theme 'solarized-dark t)

(setq user-full-name "Terrence Ho"
      user-mail-address "terrenceho.books@gmail.com")

(use-package evil
  :config
  (evil-mode 1))

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

(use-package evil-org
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda () (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package org)
(require 'org)

(setq org-todo-keywords
  '((sequence "TODO(t)" "IN-PROGRESS(i)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
(setq org-todo-keyword-faces
      '(("TODO" :foreground "red" :weight bold)
	  ("IN-PROGRESS" :foreground "blue" :weight bold)
	  ("WAITING" :foreground "orange" :weight bold)
	  ("DONE" :foreground "forest green" :weight bold)
	  ("CANCELLED" :foreground "magenta" :weight bold)))

(setq org-use-fast-todo-selection t)

(use-package org-bullets
  :init
  (add-hook 'org-mode-hook 'org-bullets-mode))

(setq org-ellipsis "⤵")

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
(setq org-edit-src-content-indentation 0)

(use-package htmlize)

(use-package ox-gfm)
(eval-after-load "org"
  '(require 'ox-gfm nil t))

(use-package ox-hugo
  :ensure t            ;Auto-install the package from Melpa (optional)
  :after ox)
