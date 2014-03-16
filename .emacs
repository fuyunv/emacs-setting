;;To add a single directory to the front of your ‘load-path’
(add-to-list 'load-path "~/.emacs.d/site-lisp/")
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(add-to-list 'load-path "~/.emacs.d/yasnippet")

;;yasnippet,必须在auto-complete之前，因为它会用到yasnippet
(require 'yasnippet)
(setq yas/prompt-functions 
   '(yas/dropdown-prompt yas/x-prompt yas/completing-prompt yas/ido-prompt yas/no-prompt))
(yas/global-mode 1)
(yas/minor-mode-on) ; 以minor mode打开，这样才能配合主mode使用

;;auto-complete
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/site-liap/ac-dict")
(setq ac-use-quick-help nil)
(setq ac-auto-start 2) ;; 输入2个字符才开始补全
(global-set-key "\M-/" 'auto-complete)  ;; 补全的快捷键，用于需要提前补全
;; Show menu 0.1 second later
(setq ac-auto-show-menu 0.1)
;; 选择菜单项的快捷键
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
;; menu设置为12 lines
(setq ac-menu-height 12)

;;(require 'xcscope)
;;c mode 才加载xcscope
(add-hook 'c-mode-common-hook
	  '(lambda ()
	     (require 'xcscope)))
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
(define-key global-map [(meta f10)]    'cscope-display-buffer-toggle)

;;buffer menu
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;;browse-kill-ring
(require 'browse-kill-ring)
(global-set-key [(control c)(k)] 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

;;在左边显示行号 
(global-linum-mode 'linum-mode)

;;输入左边的括号，就会自动补全右边的部分.包括(), "", [] , {} , 等等。 
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

(setq x-select-enable-clipboard t);支持emacs和外部程序的粘贴 
(setq frame-title-format '("@ " buffer-file-name " " ));在标题栏显示buffer名称

;; 以 y/n代表 yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;; 显示括号匹配 
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;; 显示时间，格式如下
(display-time-mode 1) 
(setq display-time-24hr-format t) 
(setq display-time-day-and-date t) 

;;关闭自动备份功能
(setq make-backup-files nil)

;;关闭自动保存模式
(setq auto-save-mode nil)
(setq auto-save-default nil)

;;tab setting
(setq tab-width 4)
(setq default-tab-width 4)
(setq indent-tabs-mode t)
(setq c-basic-offset 4)

;; C language setting
(add-hook 'c-mode-hook
          '(lambda ()
             (c-set-style "K&R")
             (setq tab-width 8)
             (setq indent-tabs-mode t)
             (setq c-basic-offset 8)))

;; C++ language setting
(add-hook 'c++-mode-hook
          '(lambda ()
             (c-set-style "K&R")
             ;;(c-toggle-auto-state)
             (setq tab-width 8)
             (setq indent-tabs-mode t)
             (setq c-basic-offset 8)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (deeper-blue)))
 '(delete-selection-mode nil)
 '(display-time-mode t)
 '(mark-even-if-inactive t)
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
