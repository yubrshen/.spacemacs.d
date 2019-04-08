;;; Personal Layer -*- lexical-binding: t; -*-

(setq personal-packages
      '((blog        :location local)
        (outline-ivy :location local)
        (personal    :location local)))

;;; Blog

(defun personal/init-blog ()
  (use-package blog
    :if (executable-find "hugo")
    :init
    (progn
      (setq blog-dir          "~/dev/blog")
      (setq blog-public-dir   "~/dev/public-blog")
      (setq blog-working-file "~/dev/blog/content/post/notate-part-1.org"))

    :config
    (spacemacs/set-leader-keys
      "ab" 'blog-deploy
      "aa" 'blog-start-server
      "ae" 'blog-end-server
      "af" 'blog-goto-working-file)))

;;; Outline-ivy

(defun personal/init-outline-ivy ()
  (use-package outline-ivy
    :defer t
    :bind ("C-j" . oi-jump)))

;;; Personal

(defun personal/init-personal ()
  (use-package personal
    :if eric?))
