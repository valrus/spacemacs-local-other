;;; packages.el --- local layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Ian Mccowan <ianmccowan@MacBook-Pro>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `local-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `local/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `local/pre-init-PACKAGE' and/or
;;   `local/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst local-packages
  '(
    css-mode
    enh-ruby-mode
    fill-column-indicator
    flycheck
    js2-mode
    ruby-mode
    spaceline
    web-mode
    )
  "The list of Lisp packages required by the local layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun local/web-mode-settings ()
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2))

(defun local/post-init-web-mode ()
  (spacemacs/add-to-hook
   'web-mode-hook
   '(local/web-mode-settings)))

(defun local/post-init-fill-column-indicator ()
  (setq fci-rule-width 1)
  (setq fci-rule-color "lightblue"))

(defun local/post-init-css-mode ()
  (setq-default css-indent-offset 2))

(defun local/js2-mode-hook ()
  (setq js-indent-level 2))

(defun local/post-init-js2-mode ()
  (add-hook 'js2-mode-hook 'local/js2-mode-hook))

(defun local/common-ruby-mode-settings ()
  (setq ruby-insert-encoding-magic-comment nil))

(defun local/enh-ruby-hook ()
  (local/common-ruby-mode-settings)

  (turn-on-fci-mode)
  (setq-default fill-column 100)

  ;; Don't tell me about trailing whitespace
  (setq show-trailing-whitespace nil)
  (setq spacemacs-show-trailing-whitespace nil)
  ;; Don't add newlines to the end of every file
  (setq mode-require-final-newline nil)

  (setq enh-ruby-add-encoding-comment-on-save nil)
  (setq enh-ruby-use-encoding-map nil))

(defun local/post-init-enh-ruby-mode ()
  (setq enh-ruby-program (concat (getenv "HOME") "/.rvm/rubies/ruby-2.3.5/bin/ruby"))
  (add-hook 'enh-ruby-mode-hook 'local/enh-ruby-hook))

(defun local/post-init-ruby-mode ()
  (local/common-ruby-mode-settings))

(defun local/post-init-enh-ruby-mode ()
  (local/common-ruby-mode-settings))

(defun local/post-init-flycheck ()
  (setq-default flycheck-scss-lint-executable
                (concat (getenv "HOME") "/.rvm/gems/ruby-2.3.5@global/bin/scss-lint")))

(defun local/post-init-spaceline ()
  (let ((modeline-font "Iosevka Slab")
        (modeline-height 100))
                                        ; File name and navigation percentage
    (set-face-attribute 'mode-line nil
                        :font modeline-font
                        :height modeline-height
                        :weight 'ultra-light)
    (set-face-attribute 'mode-line-inactive nil
                        :font modeline-font
                        :height modeline-height
                        :weight 'ultra-light)
    ;; Other modeline faces
    (set-face-attribute 'powerline-active1 nil
                        :font modeline-font
                        :height modeline-height
                        :weight 'ultra-light)
    (set-face-attribute 'powerline-active2 nil
                        :font modeline-font
                        :height modeline-height
                        :weight 'ultra-light)
    (set-face-attribute 'powerline-inactive1 nil
                        :font modeline-font
                        :height modeline-height
                        :weight 'ultra-light)
    (set-face-attribute 'powerline-inactive2 nil
                        :font modeline-font
                        :height modeline-height
                        :weight 'ultra-light)
    )
  (setq powerline-default-separator nil)
  (spaceline-compile))

;;; packages.el ends here
