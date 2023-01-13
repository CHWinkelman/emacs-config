;;; init.el --- Charles boots init file

;;; Commentary:
;; Charles' boots emac file (starting from scratch, thus boots(strap))

;;; Code:

(setq-default custom-file (expand-file-name ".custom.el" user-emacs-directory))
(when (file-exists-p custom-file) ; Don’t forget to load it, we still need it
  (load custom-file))

;; Initialize package and related archives
(require 'package)
(require 'use-package)
(add-to-list
 'package-archives
 '("melpa" . "http://melpa.org/packages/")
 t)
(package-initialize)
;; set theme
;(use-package zenburn
 ; :config (load-theme 'zenburn :noconfirm))

;; This might do better in early-init? Fuck if I know
;; Source: https://github.com/daviwil/emacs-from-scratch/blob/master/Emacs.org#startup-performance
(defun display-startup-time ()
  "Display startup time on Emacs startup."
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                    (time-subtract after-init-time before-init-time)))
           gcs-done))
(add-hook 'emacs-startup-hook #'display-startup-time)

;; Mac block
(when (eq system-type 'darwin)
  (progn
   ;; Can't even remember where this came from, we'll see if it's necessary
   ;; mute native comp warnings
   ;;(setq warning-minimum-level )

    (use-package exec-path-from-shell
      :after
      (exec-path-from-shell-initialize))

   ;; mac key settings
   ;; http://whattheemacsd.com/mac.el-01.html
   ;; (also prelude)
   (setq-default mac-command-modifier 'meta)
   (setq-default mac-option-modifier 'super)
   (setq-default ns-function-modifier 'hyper)
   ))

;; start emacs as large as possible (hint: use with workspaces)
(set-frame-parameter nil 'fullscreen 'maximized)


;;better defaults from https://github.com/angrybacon/dotemacs/blob/master/dotemacs.org
(setq-default
 ad-redefinition-action 'accept         ; Silence warnings for redefinition
 auto-save-list-file-prefix nil         ; Prevent tracking for auto-saves
 create-lockfiles nil                   ; Locks are more nuisance than blessing
 cursor-in-non-selected-windows nil     ; Hide the cursor in inactive windows
 cursor-type '(hbar . 2)                ; Underline-shaped cursor
 delete-by-moving-to-trash t            ; Delete files to trash
 fill-column 80                         ; Set width for automatic line breaks
 help-window-select t                   ; Focus new help windows when opened
 indent-tabs-mode nil                   ; Stop using tabs to indent
 initial-scratch-message ""             ; Empty the initial *scratch* buffer
 initial-major-mode #'org-mode          ; Prefer `org-mode' for *scratch*
 mouse-yank-at-point t                  ; Yank at point rather than pointer
 native-comp-async-report-warnings-errors 'silent ; Skip error buffers
 read-process-output-max (* 1024 1024)  ; Increase read size for data chunks
 recenter-positions '(5 bottom)         ; Set re-centering positions
 scroll-conservatively 101              ; Avoid recentering when scrolling far
 scroll-margin 1                        ; Add a margin when scrolling vertically
 select-enable-clipboard t              ; Merge system's and Emacs' clipboard
 sentence-end-double-space nil          ; Use a single space after dots
 show-help-function nil                 ; Disable help text everywhere
 tab-always-indent 'complete            ; Indent first then try completions
 tab-width 4                            ; Smaller width for tab characters
 uniquify-buffer-name-style 'forward    ; Uniquify buffer names
 use-short-answers t                    ; Replace yes/no prompts with y/n
 window-combination-resize t            ; Resize windows proportionally
 x-stretch-cursor t)                    ; Stretch cursor to the glyph width
(delete-selection-mode 1)               ; Replace region when inserting text
(global-subword-mode 1)                 ; Iterate through CamelCase words
(mouse-avoidance-mode 'exile)           ; Avoid collision of mouse with point
(put 'downcase-region 'disabled nil)    ; Enable `downcase-region'
(put 'scroll-left 'disabled nil)        ; Enable `scroll-left'
(put 'upcase-region 'disabled nil)      ; Enable `upcase-region'
(set-default-coding-systems 'utf-8)     ; Default to utf-8 encoding

(setq backup-directory-alist `(("." . ,(expand-file-name ".tmp/backups/"
                                                         user-emacs-directory))))

;; from technomancy's better defaults: https://git.sr.ht/~technomancy/better-defaults
(unless (or (fboundp 'helm-mode) (fboundp 'ivy-mode))
  (ido-mode t)
  (setq ido-enable-flex-matching t))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook))

(use-package zenburn-theme
  :ensure t
  :init (load-theme 'zenburn))

(use-package which-key
  :config (which-key-mode))




;;; init.el ends here
