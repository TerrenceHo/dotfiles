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
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(setq ring-bell-function 'ignore)

;; (use-package solarized-theme
;;   :config
;;   (setq solarized-scale-org-headlines nil)
;;   (setq solarized-use-variable-pitch nil
;;       solarized-height-plus-1 1.0
;;       solarized-height-plus-2 1.0
;;       solarized-height-plus-3 1.0
;;       solarized-height-plus-4 1.0))
;;   (load-theme 'solarized-dark t)
(use-package doom-themes
  :init
  (load-theme 'doom-city-lights t)
  :config
  (setq doom-themes-enable-bold nil    ; if nil, bold is universally disabled
        doom-themes-enable-italic nil) ; if nil, italics is universally disabled
  (doom-themes-org-config)
  )

(scroll-bar-mode -1)

(setq scroll-conservatively 100)

(setq user-full-name "Terrence Ho"
      user-mail-address "terrenceho.books@gmail.com")

(setq-default tab-width 4)

(setq evil-want-C-i-jump nil)

(use-package evil
  :config
  (evil-mode 1))

(setq evil-vsplit-window-right t) ;; like vim's 'splitright'
(setq evil-split-window-below t) ;; like vim's 'splitbelow'

;; (use-package nlinum-relative
;;     :config
;;     ;; something else you want
;;     (nlinum-relative-setup-evil)             ;; setup for evil
;;     (setq nlinum-relative-current-symbol "") ;; "" for the current line number
;;     (setq nlinum-relative-redisplay-delay 0) ;; delay
;;     (add-hook 'text-mode-hook 'nlinum-relative-mode))

;; (let ((height (face-attribute 'default :height)))
;;   ;; only for `nlinum-relative' users:
;;   (set-face-attribute 'nlinum-relative-current-face nil :height height))

(use-package evil-leader
  :ensure t
  :config
  (global-evil-leader-mode))
;; (evil-leader/set-leader "\\")
(evil-leader/set-key
  "b" 'switch-to-buffer)

(use-package evil-surround
  :config
  (global-evil-surround-mode 1))

(use-package evil-commentary
    :ensure t
    :bind (:map evil-normal-state-map
                ("gc" . evil-commentary)))

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

(setq org-directory "~/org")

(setq initial-buffer-choice "~/org/index.org")

(setq org-log-done 'time)
(setq org-todo-keywords
  '((sequence "TODO(t)" "IN-PROGRESS(i)" "WAITING(w@)" "|" "DONE(d)" "CANCELLED(c@)")
	(sequence "UNREAD(u)" "READING(e)" "STALLED(s@)" "|" "READ(r)")))
(setq org-todo-keyword-faces
      '(("TODO" :foreground "red" :weight bold)
	  ("IN-PROGRESS" :foreground "dodger blue" :weight bold)
	  ("WAITING" :foreground "orange" :weight bold)
	  ("DONE" :foreground "forest green" :weight bold)
	  ("CANCELLED" :foreground "magenta" :weight bold)
	  ("UNREAD" :foreground "red" :weight bold)
	  ("READING" :foreground "dodger blue" :weight bold)
	  ("STALLED" :foreground "orange" :weight bold)
	  ("READ" :foreground "forest green" :weight bold)
))

(setq org-log-done 'time)

(setq org-enforce-todo-dependencies t)
(setq org-enforce-todo-checkbox-dependencies t)

(setq org-use-fast-todo-selection t)

(setq org-agenda-files (list "~/org/index.org"))

(global-set-key (kbd "C-c a") 'org-agenda)

(setq org-agenda-span 14)

(setq org-agenda-start-on-weekday nil)
(setq org-agenda-start-day "-3d")

(defun air-org-skip-subtree-if-priority (priority)
  "Skip an agenda subtree if it has a priority of PRIORITY.

PRIORITY may be one of the characters ?A, ?B, or ?C."
  (let ((subtree-end (save-excursion (org-end-of-subtree t)))
        (pri-value (* 1000 (- org-lowest-priority priority)))
        (pri-current (org-get-priority (thing-at-point 'line t))))
    (if (= pri-value pri-current)
        subtree-end
      nil)))

(setq org-agenda-custom-commands
      '(("c" "General Agenda Overview"
         (
		  (tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High Priority Unfinished Tasks")))
          (agenda "")
          (alltodo ""
                   ((org-agenda-skip-function
                     '(or (air-org-skip-subtree-if-priority ?A)
                          (org-agenda-skip-if nil '(scheduled deadline))))))))))

(setq org-agenda-include-diary t)

(customize-set-variable 'holiday-bahai-holidays nil)
(customize-set-variable 'holiday-hebrew-holidays nil)
(customize-set-variable 'holiday-islamic-holidays nil)

(global-set-key (kbd "C-c c") 'org-capture)

(setq org-default-notes-file (concat org-directory "/index.org"))
(setq org-default-books-file (concat org-directory "/readinglist.org"))

(setq org-capture-templates
      `(("t" "Todo" entry (file org-default-notes-file) "* TODO %?\n%u\n")
        ("s" "Schedule TODO" entry (file org-default-notes-file) "* TODO %?\n%^{SCHEDULED}p\n")
		("d" "Deadline TODO" entry (file org-default-notes-file) "* TODO %?\n%^{DEADLINE}p\n")
        ("m" "Meeting" entry (file org-default-notes-file) "* MEETING with %? :MEETING:\n%t")
        ("i" "Idea" entry (file org-default-notes-file) "* %? :IDEA: \n%t" :clock-in t :clock-resume t)
		("n" "Quick Notes" entry (file org-default-notes-file) "* %?\n")
		("b" "Book" entry (file org-default-books-file) "* UNREAD %^{TITLE}\n:PROPERTIES:\n:ADDED: %<[%Y-%02m-%02d]>\n:END:%^{AUTHOR}p\n%^{PUBLISHED}p\n%?" :empty-lines 1)
        )
)

(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-allow-creating-parent-nodes 'confirm)

(add-hook 'org-capture-mode-hook 'evil-insert-state)

(use-package org-bullets
  :init
  (add-hook 'org-mode-hook 'org-bullets-mode))

(setq org-ellipsis "⤵")
(set-face-attribute 'org-ellipsis nil :foreground "##61a49e")

(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
(setq org-edit-src-content-indentation 0)

(add-hook 'org-mode-hook '(lambda () (setq fill-column 80)))
(add-hook 'org-mode-hook 'auto-fill-mode)

(use-package htmlize)

(setq org-latex-with-hyperref nil)
(setq TeX-auto-untabify 't)

(use-package ox-gfm)
(eval-after-load "org"
  '(require 'ox-gfm nil t))

(use-package ox-hugo
  :ensure t            ;Auto-install the package from Melpa (optional)
  :after ox)

(setq org-latex-prefer-user-labels t)

(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (python . t)
   ))
;; Syntax highlight in #+BEGIN_SRC blocks
(setq org-src-fontify-natively t)

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package counsel
  :bind
  ("M-x" . 'counsel-M-x)
  ("C-s" . 'swiper)

  :config
  (use-package flx)
  (use-package smex)

  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-re-builders-alist
        '((swiper . ivy--regex-plus)
          (t . ivy--regex-fuzzy))))

(use-package elfeed
  :bind (:map elfeed-search-mode-map
			  ("R" . elfeed-mark-all-as-read)
			  ("0" . elfeed-read-all)
			  ("1" . elfeed-read-news)
			  ("2" . elfeed-read-software-development)
			  ("3" . elfeed-read-personal-finance)
			  ("4" . elfeed-read-finance)
			  ("5" . elfeed-read-scientific-journals)
			  ("6" . elfeed-read-comics)
			  ("7" . elfeed-read-friends)
			  ("8" . elfeed-read-boardgames)
			  ("9" . elfeed-read-trading)
			  )
  :init
  (setq my/default-elfeed-search-filter "@1-month-ago +unread")
  (setq-default elfeed-search-filter my/default-elfeed-search-filter)
  (setq elfeed-search-title-max-width 80) ; newspaper titles are long
  :config
  (elfeed-set-max-connections 32)
  (defun elfeed-mark-all-as-read ()
    "Mark currently shown articles read"
    (interactive)
    (mark-whole-buffer)
    (elfeed-search-untag-all-unread))

  (defun elfeed--read-tag (filter tag)
    "Template for filtering various feed categories.

   FILTER is the filter string to apply, and TAG is a short name of
   the displayed category.

   The cursor is moved to the beginning of the first feed line."
    (setq elfeed-search-filter filter)
    (elfeed-search-update :force)
    (goto-char (point-min))
    (message (concat "elfeed: show " tag)))

  (defun elfeed-read-all ()
    "Show all new titles (except sport)"
    (interactive)
    (elfeed--read-tag my/default-elfeed-search-filter "all"))

  (defun elfeed-read-news ()
    "Show global news articles"
    (interactive)
    (elfeed--read-tag "@1-month-ago +unread +news" "news"))

  (defun elfeed-read-software-development ()
	"Show software development articles"
	(interactive)
	(elfeed--read-tag "@1-month-ago +unread +dev" "dev"))

  (defun elfeed-read-personal-finance ()
	"Show personal finance articles"
	(interactive)
	(elfeed--read-tag "@1-month-ago +unread +personalfinance" "personal finance"))

  (defun elfeed-read-finance ()
	"show finance articles"
	(interactive)
	(elfeed--read-tag "@1-month-ago +unread +finance" "finance"))

  (defun elfeed-read-scientific-journals ()
    "Show scientific news from major journals"
    (interactive)
    (elfeed--read-tag "@1-month-ago +unread +sciencejournal" "scientific journals"))

  (defun elfeed-read-comics ()
	"show comics"
	(interactive)
	(elfeed--read-tag "@1-month-ago +unread +comics" "comics"))

  (defun elfeed-read-friends ()
	"show friends articles"
	(interactive)
	(elfeed--read-tag "@1-month-ago +unread +friends" "friends"))

  (defun elfeed-read-boardgames ()
	"show boardgames articles"
	(interactive)
	(elfeed--read-tag "@1-month-ago +unread +boardgames" "boardgames"))
  (defun elfeed-read-trading ()
	"show trading articles"
	(interactive)
	(elfeed--read-tag "@1-month-ago +unread +trading" "trading"))
  )

(use-package elfeed-org
  :ensure t
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list "~/org/elfeed.org")))

(global-set-key (kbd "C-c r") 'elfeed)

(add-to-list 'evil-emacs-state-modes 'elfeed-show-mode)
(add-to-list 'evil-emacs-state-modes 'elfeed-search-mode)

(evil-add-hjkl-bindings elfeed-search-mode-map)
(evil-add-hjkl-bindings elfeed-show-mode-map)

(define-key elfeed-show-mode-map "o" 'elfeed-show-visit)
(define-key elfeed-search-mode-map "o" 'elfeed-search-browse-url)
