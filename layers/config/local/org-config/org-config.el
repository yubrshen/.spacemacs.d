(require 'org)
;; (require 'org-contacts) ; to avoid the problem of (void-function org-projectile:per-repo)
(require 'org-bullets)
(require 'ox-bibtex)
(require 'ox-extra)
;(require 'ox-reveal)
(load "~/programming/write-slides-with-emacs-org-reveal/org-reveal/ox-reveal.el")

(provide 'org-config)

;;; Bindings and Hooks

(add-hook 'org-mode-hook (lambda () (auto-fill-mode 1)))
(add-hook 'org-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook 'org-toggle-blocks)

(spacemacs/set-leader-keys "aof" 'org-open-at-point-global)

(define-key org-mode-map (kbd "C-c t") 'org-toggle-blocks)

(evil-define-key '(normal visual motion) org-mode-map
  "gh" 'outline-up-heading
  "gj" 'outline-forward-same-level
  "gk" 'outline-backward-same-level
  "gl" 'outline-next-visible-heading
  "gu" 'outline-previous-visible-heading)

;; Quick refile of project tasks
(setq org-refile-targets '((nil :regexp . "Week of")))

(spacemacs/set-leader-keys-for-major-mode 'org-mode "r" 'org-refile)

;;; Theming

(setq org-priority-faces '((65 :inherit org-priority :foreground "red")
                           (66 :inherit org-priority :foreground "brown")
                           (67 :inherit org-priority :foreground "blue")))
(setq org-ellipsis "")
(setq org-bullets-bullet-list '("" "" "" ""))

;;; Templates

(setq
 org-structure-template-alist
 '(("n" "#+NAME: ?")
   ("q" "#+BEGIN_QUOTE\n\n#+END_QUOTE")

   ;; Language Blocks
   ("c" "#+BEGIN_SRC clojure\n\n#+END_SRC")
   ("d" "#+BEGIN_SRC dot\n\n#+END_SRC")
   ("e" "#+BEGIN_EXAMPLE \n\n#+END_EXAMPLE")
   ("h" "#+BEGIN_SRC haskell\n\n#+END_SRC")
   ;; ("l" "#+BEGIN_SRC lisp\n\n#+END_SRC")
   ;;("p" "#+BEGIN_SRC python\n\n#+END_SRC")

   ;; Collapse previous header by default in themed html export
   ("clps" ":PROPERTIES:\n :HTML_CONTAINER_CLASS: hsCollapsed\n :END:\n")
   ;; Hugo title template
   ("b" "#+TITLE: \n#+SLUG: \n#+DATE: 2017-mm-dd
#+CATEGORIES: \n#+SUMMARY: \n#+DRAFT: false")
   ;; Yu Shen's own definitions:
   ("E" "#+BEGIN_SRC emacs-lisp\n?\n#+END_SRC")
   ("S" "#+BEGIN_SRC sh\n?\n#+END_SRC")
   ("uml" "#+BEGIN_SRC plantuml :file uml.png \n?\n#+END_SRC\n#results:")
   ("ditaa" "#+NAME:?\n#+BEGIN_SRC ditaa \n\n#+END_SRC\n"
    "\n<src lang=\"ditaa\">\n?\n</src>")
    ("sql" "#+NAME:?\n#+BEGIN_SRC sql :noweb no-export :tangle \n\n#+END_SRC\n"
      "<src lang=\"sql\">\n?\n</src>")
    ;;  :engine mssql :cmdline \"-S localhost -U SA -P <my password>\" \n\n#+END_SRC\n"
    ;; is the setting to execute SQL statements with Microsoft SQL server with my local set up
    ;; The setting is best set as global properties with org-file

   ("ps" "#+BEGIN_SRC python \n?\n#+END_SRC\n" "<src lang=\"python\">\n?\n</src>")
   ("p" "#+NAME:?\n#+BEGIN_SRC python :noweb no-export :tangle  \n\n#+END_SRC\n"
    "<src lang=\"python\">\n?\n</src>")
   ("pe" "#+END_SRC\n\n?\n#+BEGIN_SRC python \n" "</src>\n<src lang=\"python\">")
   ("cc" "#+NAME:?\n#+BEGIN_SRC C++ :noweb no-export :tangle :main no \n\n#+END_SRC\n"
    "<src lang=\"C++\">\n?\n</src>")
   ("clj" "#+NAME:?\n#+BEGIN_SRC clojure \n\n#+END_SRC\n"
    "\n<src lang=\"clojure\">\n?\n</src>")
   ("cs" "#+END_SRC\n\n\n#+NAME: ?\n#+BEGIN_SRC clojure \n"
    "</src>\n<src lang=\"clojure\">")
   ("r" "#+NAME:?\n#+BEGIN_SRC R \n\n#+END_SRC\n"
    "\n<src lang=\"R\">\n?\n</src>")
   ("rs" "#+END_SRC\n\n\n#+NAME: ?\n#+BEGIN_SRC R \n" "</src>\n<src lang=\"R\">")
   ("j" "#+NAME:?\n#+BEGIN_SRC javascript \n\n#+END_SRC\n"
    "\n<src lang=\"javascript\">\n?\n</src>")
   ("js" "#+END_SRC\n\n\n#+NAME: ?\n#+BEGIN_SRC javascript \n"
    "</src>\n<src lang=\"javascript\">")
   ("elsp" "#+NAME:?\n#+BEGIN_SRC emacs-lisp \n\n#+END_SRC\n"
    "\n<src lang=\"emacs-lisp\">\n?\n</src>")
   ("elsps" "#+END_SRC\n\n\n#+NAME: ?\n#+BEGIN_SRC emacs-lisp \n"
    "</src>\n<src lang=\"emacs-lisp\">")
   ("shell" "#+NAME:?\n#+BEGIN_SRC shell \n\n#+END_SRC\n"
    "\n<src lang=\"shell\">\n?\n</src>")
   ("l" "#+NAME:?\n#+BEGIN_SRC latex \n\n#+END_SRC\n"
    "\n<src lang=\"latex\">\n?\n</src>")))

;;; Org Blocks

;; Hide all org-blocks, including src, quote, etc. blocks, on buffer load
(defvar org-blocks-hidden nil)
(defun org-toggle-blocks ()
  (interactive)
  (if org-blocks-hidden
      (org-show-block-all)
    (org-hide-block-all))
  (setq-local org-blocks-hidden (not org-blocks-hidden)))

;;; Export

(ox-extras-activate '(ignore-headlines))

(when linux?
  (setq org-file-apps '((auto-mode . emacs)
                        ("\\.mm\\'" . default)
                        ("\\.x?html?\\'" . "/usr/bin/firefox %s")
                        ("\\.pdf\\'" . default))))

;; (add-to-list 'org-latex-packages-alist '("" "minted"))
;; (setq org-latex-listings 'minted)
;; (setq org-latex-minted-options '(("frame" "lines")
;;                                  ("fontsize" "\\scriptsize")
;;                                  ("xleftmargin" "\\parindent")
;;                                  ("linenos" "")))
;; having trouble with minted packages

;; Use xelatex instead of pdflatex to support Chinese text
;; (setq
;;  org-latex-pdf-process
;;  '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;    "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;    "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
(setq
  org-latex-to-pdf-process
  '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
     "xelatex -shell-escape  -interaction nonstopmode -output-directory %o %f"
     "xelatex -shell-escape  -interaction nonstopmode -output-directory %o %f"))
;; To export Chinese text, the org file must have the following options set:
;; #+LATEX_HEADER: usepackage{xltxtra}
;; #+LATEX_HEADER: setmainfont{WenQuanYi Micro Hei}

;;; Babel

(org-babel-do-load-languages
 'org-babel-load-languages '((python .  t)
                             (haskell . t)
                             (clojure . t)
                             (dot .     t)
                             (emacs-lisp . t)
                             (C . t)
                             (ditaa . t)
                             (js . t)
                             (latex . t)
                             (shell . t) ; sh does not work, shell works
                             (plantuml . t)
                              (sql . t)
                             ))

(setq org-confirm-babel-evaluate nil)
(setq org-src-fontify-natively t)
(setq org-src-tab-acts-natively t)
(setq org-src-preserve-indentation t)
(setq org-src-window-setup 'current-window)
(setq org-babel-default-header-args:python
      (cons '(:results . "output file replace")
            (assq-delete-all :results org-babel-default-header-args)))

;;; Yu Shen's babel related customization

(load "~/programming/emacs-lisp/literate-tools.el")
(setq Org-Reveal-root "file:///home/yubrshen/programming/write-slides-with-emacs-org-reveal/reveal.js")
(setq Org-Reveal-title-slide nil)

;;; My keybinding

;; The following might be in keybinding section.

(evil-escape-mode)
(setq-default evil-escape-key-sequence ",,")
(setq-default evil-escape-delay 0.3)
;; the suggested is 0.2, but to Yu Shen it's still not enough delay,
;; 0.3 seems better.
;; The delay between the two key presses can be customized with the variable
;; evil-escape-delay. The default value is 0.1.
;; If your key sequence is composed with the two same characters it is
;; recommended to set the delay to 0.2.

;;; Org-capture and Org-agenda customization

(setq org-directory "~/zoom-out")
; set proper value of org-capture file; have a centralized notes.org
(setq org-default-notes-file (os-path (concat org-directory "/" "notes.org")))

(setq org-contacts-files (list (os-path "~/Dropbox/contacts.org")))
(setq org-plantuml-jar-path "~/bin/plantuml.jar")
(setq org-agenda-files (list org-default-notes-file
                             (os-path "~/Dropbox/schedule.org")))
(setq org-todo-keywords
  '((sequence "TODO(t)" "|" "DONE(d)")
     (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
     (sequence "HOLD(h)" "|" "PNEDING(p)" "|"  "CANCELED(c)")))
;; permanently and globablly change the marge for org export to PDF:
(setq org-latex-packages-alist '(("margin=2cm" "geometry" nil)))
