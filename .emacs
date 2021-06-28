;;; Melpa --- None
;;(require 'package)
;;(add-to-list 'package-archives
;;             '("melpa" . "https://melpa.org/packages/") t)
;;(when (< emacs-major-version 24)
;;  ;; For important compatibility libraries like cl-lib
;;  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "https://melpa.org/packages/")
   t)
  (package-initialize))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(beacon-mode t)
 '(imenu-list-size 50)
 '(nyan-mode t)
 '(package-selected-packages
   (quote
    (lsp-mode py-autopep8 flycheck-pycheckers flycheck hl-todo typescript-mode jenkinsfile-mode jedi use-package elpy dockerfile-mode feature-mode magit yaml-mode zenburn-theme grandshell-theme nyan-mode multi-term imenu-list dimmer beacon rainbow-delimiters zoom helm diff-hl markdown-mode shell-pop rjsx-mode pyenv-mode-auto origami neotree neon-mode multiple-cursors go-eldoc go-autocomplete color-theme-sanityinc-tomorrow all-the-icons ace-window)))
 '(shell-pop-term-shell "/bin/zsh")
 '(shell-pop-universal-key "C-t"))



;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(when (string= system-type "darwin")       
  (setq dired-use-ls-dired nil))


;;theme set up
(load-theme 'zenburn t)

;; default font setting
(set-default-font "Monoid 9")

;;multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
        
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)



;; indent 4 spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)


;;pyenv-mode-auto
(require 'pyenv-mode-auto)

;;ace-window key set
(global-set-key (kbd "C-x o") 'ace-window)


;;js -> jsx-mode
(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
;;for JSX
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . rjsx-mode))


;; NeoTree
(global-set-key [f8] 'neotree-toggle)


(require 'all-the-icons)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))




(global-linum-mode t)
;; line-num mode setting
(defun sol-linum-mode ()  
    (linum-mode)
      (setq linum-format "%d -")
      (set-face-foreground 'linum "white")
    )   

;; python
(add-hook 'python-mode-hook 'sol-linum-mode)
;; elisp
(add-hook 'emacs-lisp-mode-hook 'sol-linum-mode)
;; sql
(add-hook 'sql 'sol-linum-mode)


;; time display
(display-time)

;; yes or no -> y or n
(fset 'yes-or-no-p 'y-or-n-p)


;;Tramp mode
(setq tramp-default-method "ssh")


;;origami mode
(global-set-key (kbd "C-{") 'origami-close-node);
(global-set-key (kbd "C-}") 'origami-open-node);


(global-origami-mode 1);


;; ======================================================================
;; GO Setup
;; ======================================================================

;;Load Go-specific language syntax
;;For gocode use https://github.com/mdempsky/gocode

;;Goimports
(defun go-mode-setup ()
  (go-eldoc-setup)
  (add-hook 'before-save-hook 'gofmt-before-save))
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook 'go-mode-setup)


;;Configure golint
(add-to-list 'load-path (concat (getenv "GOPATH")  "/src/github.com/golang/lint/misc/emacs"))
(require 'golint)


;; ;; Godef

(defun my-go-mode-hook ()
  ; Call Gofmt before saving   
  (add-hook 'before-save-hook 'gofmt-before-save)
  ; Godef jump key binding 
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "M-*") 'pop-tag-mark)
  )
(add-hook 'go-mode-hook 'my-go-mode-hook)

;; (defun auto-complete-for-go ()
;; (auto-complete-mode 1))
;; (add-hook 'go-mode-hook 'auto-complete-for-go)
;;
;;
;; (with-eval-after-load 'go-mode
;;    (require 'go-autocomplete))



;; disable welcome page
(setq inhibit-startup-screen t)


(setq make-backup-files nil)

;; git diff highlight
(global-diff-hl-mode)

;; ;; zoom config
;; (defun my/fix-imenu-size ()
;;   (with-selected-window (get-buffer-window "*Ilist*")
;;     (setq window-size-fixed t)
;;     (window-resize (selected-window) (- 50 (window-total-width)) t t)))

;; (add-hook 'imenu-list-update-hook 'my/fix-imenu-size)


;; beacon-mode
(beacon-mode 1)
(setq beacon-size 70)
(setq beacon-color "#F34")


;; dimmer mode
(dimmer-mode t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; imenu-list
(global-set-key (kbd "C-'") #'imenu-list-smart-toggle)


;; multi-term
(setq multi-term-program "/bin/zsh")

;; overwrite selected text
(delete-selection-mode t)


;; elpy init
(elpy-enable)
(setq elpy-rpc-backend "jedi")  

(use-package elpy
  :ensure t
  :init
  (elpy-enable))


(defun my-python-mode-hook ()
  (local-set-key (kbd "M-.") 'elpy-goto-definition)
  (local-set-key (kbd "M-*") 'pop-tag-mark)
  )
(add-hook 'python-mode-hook 'my-python-mode-hook)


(global-hl-todo-mode t)
(setq hl-todo-keyword-faces
      '(("TODO"   . "#FF0000")
        ("FIXME"  . "#FF0000")
        ("DEBUG"  . "#A020F0")
        ("GOTCHA" . "#FF4500")
        ("STUB"   . "#1E90FF")))


    
;; (use-package lsp-mode
;;   :init
;;   ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
;;   (setq lsp-keymap-prefix "C-c l")
;;   :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
;;          (python-mode . lsp))
;;   :commands lsp)

;; ;; optionally
;; (use-package lsp-ui :commands lsp-ui-mode)

(when (load "flycheck" t t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
