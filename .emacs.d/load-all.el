;; add a single directory to the front of your ‘load-path’
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;; load file
(load-file "~/.emacs.d/load-dictionary.el")
(load-file "~/.emacs.d/load-cedet.el")
(load-file "~/.emacs.d/load-cscope.el")
(load-file "~/.emacs.d/load-misc.el") ; when ac running at start of this line have bug

;;go mode
(add-to-list 'load-path "~/.emacs.d/site-lisp/go-mode")
(require 'go-mode-load)

;;php mode
(add-to-list 'load-path "~/.emacs.d/site-lisp/php-mode")
(require 'php-mode)

;;highlight
(load-file "~/.emacs.d/site-lisp/highlight.el")
(load-file "~/.emacs.d/site-lisp/idle-highlight-mode.el")
(idle-highlight-mode)

(defun my-coding-hook ()
  (make-local-variable 'column-number-mode)
  (column-number-mode t)
  (if window-system (hl-line-mode t))
  (idle-highlight-mode t))

(add-hook 'emacs-lisp-mode-hook 'my-coding-hook)
(add-hook 'c-mode-hook 'my-coding-hook)
(add-hook 'python-mode-hook 'my-coding-hook)

;;yasnippet,必须在auto-complete之前，因为它会用到yasnippet
(add-to-list 'load-path "~/.emacs.d/site-lisp/yasnippet")
(require 'yasnippet)
(setq yas/prompt-functions
      '(yas/dropdown-prompt
		yas/x-prompt
		yas/completing-prompt
		yas/ido-prompt
		yas/no-prompt))
(yas/global-mode 1)
(yas/minor-mode-on) ; 以minor mode打开，这样才能配合主mode使用

;;auto-complete
(add-to-list 'load-path "~/.emacs.d/site-lisp/auto-complete")
(require 'auto-complete-config)
(ac-config-default)

(setq-default ac-sources '(ac-source-yasnippet
                           ac-source-semantic
                           ac-source-ropemacs
                           ac-source-imenu
                           ac-source-words-in-buffer
                           ac-source-dictionary
                           ac-source-abbrev
                           ac-source-words-in-buffer
                           ac-source-files-in-current-dir
                           ac-source-filename))
;;;; c-mode
(add-hook 'c-mode-hook
          '(lambda ()
             (local-set-key (kbd "RET") 'newline-and-indent)
             (semantic-mode t)))
(setq ac-comphist-file
      (expand-file-name "~/.emacs.d/ac-comphist.dat"))

(set-face-background 'ac-candidate-face "lightgray")
(set-face-underline 'ac-candidate-face "darkgray")
(set-face-background 'ac-selection-face "steelblue")

(ac-set-trigger-key "TAB")
(add-to-list 'ac-dictionary-directories "~/.emacs.d/site-lisp/ac-dict")
(setq ac-use-quick-help nil)
(setq ac-auto-start 3) ;; 输入3个字符开始补全
(setq ac-auto-show-menu 0.5);; Show menu 0.5 second later
(setq ac-menu-height 20);; menu设置为20 lines
(setq ac-use-menu-map t);; 选择菜单项的快捷键
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
(global-set-key "\M-/" 'auto-complete);; 强制补全开始

;;buffer menu
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer-and-update)

;;browse-kill-ring
(require 'browse-kill-ring)
(global-set-key [(control c)(k)] 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

;; auto pair
(defun my-common-mode-auto-pair () 
  (interactive) 
  (make-local-variable 'skeleton-pair-alist) 
  (setq skeleton-pair-alist '(
							  (? ? _ "''") 
							  (? ? _ """") 
							  (? ? _ "()") 
							  (? ? _ "[]") 
							  (?{ _ ?} >))) 
  (setq skeleton-pair t) 
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe) 
  (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe) 
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe) 
  (local-set-key (kbd "\'") 'skeleton-pair-insert-maybe) 
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)) 
(add-hook 'c-mode-hook 'my-common-mode-auto-pair) 
(add-hook 'c++-mode-hook 'my-common-mode-auto-pair) 
(add-hook 'java-mode-hook 'my-common-mode-auto-pair) 
(add-hook 'lisp-mode-hook 'my-common-mode-auto-pair) 
(add-hook 'php-mode-hook 'my-common-mode-auto-pair) 
(add-hook 'python-mode-hook 'my-common-mode-auto-pair) 
(add-hook 'html-mode-hook 'my-common-mode-auto-pair) 
(add-hook 'scheme-mode-hook 'my-common-mode-auto-pair) 
(add-hook 'css-mode-hook 'my-common-mode-auto-pair) 
(add-hook 'sql-mode-hook 'my-common-mode-auto-pair) 
(add-hook 'emacs-lisp-mode-hook 'my-common-mode-auto-pair) 
(add-hook 'text-mode-hook 'my-common-mode-auto-pair) 

(defun my-lang-style-setting()
  (interactive)
  (c-set-style "K&R")
  (setq tab-width 4)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 4))

;; C language setting
(add-hook 'c-mode-hook 'my-lang-style-setting)
(add-hook 'c++-mode-hook 'my-lang-style-setting)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(delete-selection-mode nil)
 '(display-time-mode t)
 '(ecb-layout-window-sizes nil)
 '(ecb-options-version "2.40")
 '(mark-even-if-inactive t)
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t);; 显示括号匹配
 '(setq show-paren-style 'parentheses);;括号匹配的类型
 )

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;代码块收缩功能
(setq hs-minor-mode t)
(load-library "hideshow")
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook 'hs-minor-mode)
(add-hook 'perl-mode-hook 'hs-minor-mode)
(add-hook 'php-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)

;;ecb
(add-to-list 'load-path  "~/.emacs.d/site-lisp/ecb-2.40")
;;切换到目录窗口 Ctrl-c . g d 
;;切换到函数/方法窗口 Ctrl-c . g m 
;;切换到文件窗口 Ctrl-c . g s 
;;切换到历史窗口 Ctrl-c . g h 
;;切换到上一个编辑窗口 Ctrl-c . g l

;; ecb depend cedet plugin
(require 'semantic/analyze)
(provide 'semantic-analyze)
(provide 'semantic-ctxt)
(provide 'semanticdb)
(provide 'semanticdb-find)
(provide 'semanticdb-mode)
(provide 'semantic-load)

(require 'ecb)
(setq stack-trace-on-error t)
;;auto start ecb
;;(setq ecb-auto-activate t)
(setq ecb-tip-of-the-day nil)
(setq ecb-windows-width 0.25)

(define-key global-map [(control f1)] 'ecb-hide-ecb-windows)
(define-key global-map [(control f2)] 'ecb-show-ecb-windows)

;;revert current buffer
(global-set-key [(control c) r] 'revert-buffer)
;;semantic-mode start
(semantic-mode)

;; nav-49
(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-nav-49")
(require 'nav)
(nav-disable-overeager-window-splitting)
;; Optional: set up a quick key to toggle nav
;; (global-set-key [f8] 'nav-toggle)

;; session
(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;; hippie-expand diff with dabbrev-expand
(global-set-key [(meta ?/)] 'hippie-expand)
(setq hippie-expand-try-functions-list
	  '(try-expand-dabbrev
		try-expand-dabbrev-visible
		try-expand-dabbrev-all-buffers
		try-expand-dabbrev-from-kill
		try-complete-file-name-partially
		try-complete-file-name
		try-expand-all-abbrevs
		try-expand-list
		try-expand-line
		try-complete-lisp-symbol-partially
		try-complete-lisp-symbol))

;; server start
(require 'server)
(if (not (server-running-p))
    (server-start))
