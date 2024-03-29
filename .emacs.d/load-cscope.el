;; cscope setting
(defun cscope-keymap()
  (interactive)
  (require 'xcscope)
  ;;cscope 全局快捷键
  (define-key global-map [(control f3)]  'cscope-set-initial-directory)
  (define-key global-map [(control f4)]  'cscope-unset-initial-directory)
  (define-key global-map [(control f5)]  'cscope-find-this-symbol)
  (define-key global-map [(control f6)]  'cscope-find-global-definition)
  (define-key global-map [(control f7)]  'cscope-find-global-definition-no-prompting)
  (define-key global-map [(control f8)]  'cscope-pop-mark)
  (define-key global-map [(control f9)]  'cscope-next-symbol)
  (define-key global-map [(control f10)] 'cscope-next-file)
  (define-key global-map [(control f11)] 'cscope-prev-symbol)
  (define-key global-map [(control f12)] 'cscope-prev-file)
  (define-key global-map [(meta f9)]     'cscope-display-buffer)
  (define-key global-map [(meta f10)]    'cscope-display-buffer-toggle))

;;c/c++ mode cscope hook
(add-hook 'c-mode-hook 'cscope-keymap)
(add-hook 'c++-mode-hook 'cscope-keymap)
