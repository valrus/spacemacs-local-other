;; Use 2-space indent everywhere
(setq-default standard-indent 2)

;; Cache huge project
(setq projectile-enable-caching t)

(defun my-ruby-config ()
  (turn-on-fci-mode)
  ;; Don't tell me about trailing whitespace
  (setq show-trailing-whitespace nil))

(add-hook 'enh-ruby-mode-hook 'my-ruby-config)
(add-hook 'ruby-mode-hook 'my-ruby-config)
