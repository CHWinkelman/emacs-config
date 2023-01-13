;;; early-init.el --- Early Init File
;;; Commentary:
;; This part is confusing to me still but we are working on that.
;; So far it is all sourced from https://github.com/Phundrak/dotfiles/blob/master/org/config/emacs.org#early-init

;;; Code:
(setq gc-cons-threshold (* 1024 1024 1024))

(setq-default
      package-enable-at-startup nil
      inhibit-startup-message   t
      frame-resize-pixelwise    t  ; fine resize
      package-native-compile    t) ; native compile packages

;;; * Initial frame info
(scroll-bar-mode -1)               ; disable scrollbar
(tool-bar-mode -1)                 ; disable toolbar
(tooltip-mode -1)                  ; disable tooltips
(set-fringe-mode 10)               ; give some breathing room
(blink-cursor-mode 0)              ; disable blinking cursor

;; Set window size
;; Needs to be in early init or window goes off the size
(add-to-list 'default-frame-alist '(width  . 180))
(add-to-list 'default-frame-alist '(height . 60))

;;; early-init.el ends here
