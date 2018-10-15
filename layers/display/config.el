;;; -*- lexical-binding: t -*-

;; Display mofidications for `solarized-light' and `zenburn' applied here.

;; Try out changes with `spacemacs/update-theme' to see theme updates
;; or alternatively run `spacemacs/cycle-spacemacs-theme' with 'SPC T n'.
;; I do not style outlines level 4 or greater because I never go that deep.

;;; Configuration
;;;; Core

(setq solarized-use-variable-pitch nil)
(setq face-remapping-alist '(;; Headers
                             (outline-1 org-level-1)
                             (outline-2 org-level-2)
                             (outline-3 org-level-3)

                             ;; Modeline
                             (powerline-active1        mode-line)
                             (powerline-active2        mode-line)
                             (spaceline-highlight-face mode-line)
                             (powerline-inactive1      mode-line-inactive)
                             (powerline-inactive2      mode-line-inactive)))

;;;; Styling
;;;;; Headers

(setq display/headers/common '(:underline t :inherit nil))
(setq display/headers/zenburn
      `((org-level-1
         ,@display/headers/common
         :height 1.35
         :foreground "#DFAF8F")
        (org-level-2
         ,@display/headers/common
         :height 1.25
         :foreground "#BFEBBF")
        (org-level-3
         ,@display/headers/common
         :height 1.15
         :foreground "#7CB8BB")))
(setq display/headers/solarized-light
      `((org-level-1
         ,@display/headers/common
         :height 1.35
         :foreground "#C3A29E")
        (org-level-2
         ,@display/headers/common
         :height 1.25
         :foreground "#8D6B94")
        (org-level-3
         ,@display/headers/common
         :height 1.15
         :foreground "#8C5F66")))

;;;;; Org-blocks

(setq display/org-blocks/common '(:italic nil :underline nil :box t))
(setq display/org-blocks
      `((org-block-begin-line
         ,@display/org-blocks/common)
        (org-block-end-line
         ,@display/org-blocks/common)))

;;;;; Company

(setq display/company/common '(:weight bold :underline nil))
(setq display/company
      `((company-tooltip-common
         ,@display/company/common
         :inherit company-tooltip)
        (company-tooltip-common-selection
         ,@display/company/common
         :inherit company-tooltip-selection)))

;;;;; Mode-line

(setq display/mode-line/common '(:box nil :underline nil))
(setq display/mode-line
      `((mode-line
         ,@display/mode-line/common
         :background nil)
        (mode-line-inactive
         ,@display/mode-line/common)))

;;;;; Font-locks

(setq display/font-locks
      `((font-lock-comment-face
         :italic t
         :weight normal)
        (font-lock-doc-face
         :italic t
         :weight normal)))

;;; Theming
;;;; Common

(setq display/common-theming
      `(,@display/company
        ,@display/mode-line
        ,@display/org-blocks

        (avy-background-face :italic nil)
        (font-lock-comment-face :italic t :weight normal)
        (fringe :background nil)))

;;;; Themes

(setq display/solarized-light-theming
      `(,@display/headers/solarized-light

        ;; Overwrites
        (mode-line-inactive :background "#eee8d5"
                            ,@(alist-get 'mode-line-inactive
                                         display/mode-line))

        (font-lock-comment-face :foreground "#586e75"
                                ,@(alist-get 'font-lock-comment-face
                                             display/font-locks))
        (font-lock-doc-face :foreground "#2aa198"
                            ,@(alist-get 'font-lock-doc-face
                                         display/font-locks))

        ;; Extra
        (sp-show-pair-match-face :background  "CadetBlue3")))

(setq display/zenburn-theming
      `(,@display/headers/zenburn

        ;; Overwrites
        (font-lock-comment-face :foreground "gray50"
                                ,@(alist-get 'font-lock-comment-face
                                             display/font-locks))
        (font-lock-doc-face :foreground "gray65"
                            ,@(alist-get 'font-lock-doc-face
                                         display/font-locks))

        ;; Extra
        (font-lock-comment-delimiter-face :foreground "gray35")
        (font-lock-function-name-face     :foreground "CadetBlue2")
        (font-lock-type-face              :foreground "LightCoral")))

;;;; Set Modifications

(setq theming-modifications
      `((zenburn         ,@display/common-theming
                         ,@display/zenburn-theming)
        (solarized-light ,@display/common-theming
                         ,@display/solarized-light-theming)))
