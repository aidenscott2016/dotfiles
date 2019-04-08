;c load package manager, add the Melpa package registry
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; bootstrap use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; load evil
(setq evil-want-C-i-jump nil)
(use-package evil
  :ensure t ;; install the evil package if not installed
  :init ;; tweak evil's configuration before loading it
  (setq evil-search-module 'evil-search)
  (setq evil-ex-complete-emacs-commands nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (setq evil-shift-round nil)
  (setq evil-want-C-u-scroll t)
  :config ;; tweak evil after loading it
  (evil-mode)

  ;; example how to map a command in normal mode (called 'normal state' in evil)
  (define-key evil-normal-state-map (kbd ", w") 'evil-window-vsplit))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (general syndicate use-package list-packages-ext let-alist evil-leader))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(use-package syndicate
  :ensure t)
(use-package general
  :ensure t
)


;org-mode-evil-calendar
(defmacro my-org-in-calendar (command)
  (let ((name (intern (format "my-org-in-calendar-%s" command))))
    `(progn
       (defun ,name ()
         (interactive)
         (org-eval-in-calendar '(call-interactively #',command)))
       #',name)))

(general-def org-read-date-minibuffer-local-map
  "M-h" (my-org-in-calendar calendar-backward-day)
  "M-l" (my-org-in-calendar calendar-forward-day)
  "M-k" (my-org-in-calendar calendar-backward-week)
  "M-j" (my-org-in-calendar calendar-forward-week)
  "M-H" (my-org-in-calendar calendar-backward-month)
  "M-L" (my-org-in-calendar calendar-forward-month)
  "M-K" (my-org-in-calendar calendar-backward-year)
  "M-J" (my-org-in-calendar calendar-forward-year))
