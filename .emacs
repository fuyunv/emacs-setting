;;To add a single directory to the front of your ‘load-path’
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;;go mode
(add-to-list 'load-path "~/.emacs.d/go-mode")
(require 'go-mode-load)

;;php mode
(add-to-list 'load-path "~/.emacs.d/php-mode")
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
(add-to-list 'load-path "~/.emacs.d/yasnippet")
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
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/site-liap/ac-dict")
(setq ac-use-quick-help nil)
(setq ac-auto-start 1) ;; 输入1个字符开始补全
(setq ac-auto-show-menu 0.1);; Show menu 0.1 second later
(setq ac-menu-height 12);; menu设置为12 lines
(setq ac-use-menu-map t);; 选择菜单项的快捷键
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
(global-set-key "\M-/" 'auto-complete);; 强制补全开始

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
(global-set-key (kbd "C-x C-b") 'ibuffer-and-update)

;;browse-kill-ring
(require 'browse-kill-ring)
(global-set-key [(control c)(k)] 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

;;输入左边的括号，就会自动补全右边的部分.包括(), "", [] , {} , ...
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

;; C language setting
(add-hook 'c-mode-hook
          '(lambda ()
             (c-set-style "K&R")
             (setq tab-width 4)
             (setq indent-tabs-mode t)
             (setq c-basic-offset 4)))

;; C++ language setting
(add-hook 'c++-mode-hook
          '(lambda ()
             (c-set-style "K&R")
             ;;(c-toggle-auto-state)
             (setq tab-width 4)
             (setq indent-tabs-mode t)
             (setq c-basic-offset 4)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(delete-selection-mode nil)
 '(display-time-mode t)
 '(ecb-layout-window-sizes nil)
 '(ecb-options-version "2.32")
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
;;能把一个代码块缩起来，需要的时候再展开
;; M-x hs-minor-mode
;; C-c @ ESC C-s show all
;; C-c @ ESC C-h hide all
;; C-c @ C-s show block
;; C-c @ C-h hide block
;; C-c @ C-c toggle hide/show

;;hot key
(global-set-key (kbd "<f1>") 'eshell) ; shell->本地shell, eshell->emacs shell
(global-set-key (kbd "<f2>") 'ecb-minor-mode)
(global-set-key (kbd "<f5>") 'semantic-ia-fast-jump) ; 智能跳转 跳转到定义
(global-set-key (kbd "<f6>") 'find-tag)
(global-set-key (kbd "<f7>") 'pop-tag-mark)

(global-set-key (kbd "<f11>") 'hs-hide-block) ; 隐藏代码块
(global-set-key (kbd "<f12>") 'hs-show-block) ; 显示代码块

;;emacs23开始内置cedet
;;cedet
(require 'cedet)

;;semantic
(require 'semantic-ia nil 'noerror)
(require 'semantic-tag-folding nil 'noerror)
(require 'semantic-c nil 'noerror)
(global-ede-mode t)                      ; enable the project management system

(global-set-key (kbd "M-q") 'semantic-ia-complete-symbol-menu)
(global-set-key [f10] 'semantic-ia-fast-jump);; 智能跳转 跳转到定义
(global-set-key [S-f10] ;; 跳转到上一次的地方
				(lambda ()
				  (interactive)
                  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
                      (error "Semantic Bookmark ring is currently empty"))
                  (let* ((ring (oref semantic-mru-bookmark-ring ring))
                         (alist (semantic-mrub-ring-to-assoc-list ring))
                         (first (cdr (car alist))))
                    (if (semantic-equivalent-tag-p (oref first tag)
                                                   (semantic-current-tag))
                        (setq first (cdr (car (cdr alist)))))
                    (semantic-mrub-switch-tags first))))
(define-key c-mode-map [M-S-f12] 'semantic-analyze-proto-impl-toggle)

(setq semanticdb-project-roots (list (expand-file-name "/")))
(defconst cedet-user-include-dirs
  (list
   "/usr/include"
   "/usr/local/include"
   ""))

;;ecb
(add-to-list 'load-path  "~/.emacs.d/ecb-2.32")

;;(load-file "~/.emacs.d/ecb-2.32/ecb.el")
;;切换到目录窗口 Ctrl-c . g d 
;;切换到函数/方法窗口 Ctrl-c . g m 
;;切换到文件窗口 Ctrl-c . g s 
;;切换到历史窗口 Ctrl-c . g h 
;;切换到上一个编辑窗口 Ctrl-c . g l
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
(setq ecb-windows-width 0.15)

;;;;;;;;;; misc
(global-linum-mode 'linum-mode);;行号显示
(setq x-select-enable-clipboard t);; 支持emacs和外部程序的粘贴
(setq frame-title-format '("-@-" buffer-file-name " " ));; 在标题栏显示buffer名称
(fset 'yes-or-no-p 'y-or-n-p);; 以 y/n代表 yes/no
;; 显示时间，格式如下
(display-time-mode 1) 
(setq display-time-24hr-format t) 
(setq display-time-day-and-date t) 
(setq make-backup-files nil);;关闭自动备份功能
;; 关闭自动保存模式
(setq auto-save-mode nil)
(setq auto-save-default nil)
;; tab setting
(setq tab-width 4)
(setq default-tab-width 4)
(setq indent-tabs-mode t)
(setq c-basic-offset 4)
;; 各窗口间切换
(global-set-key [M-left] 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up] 'windmove-up)
(global-set-key [M-down] 'windmove-down)

;; 隐藏和显示ecb窗口
(define-key global-map [(control f1)] 'ecb-hide-ecb-windows)
(define-key global-map [(control f2)] 'ecb-show-ecb-windows)

;;revert current buffer
(global-set-key [(control c) r] 'revert-buffer)
;;semantic-mode start
(semantic-mode)

;; windows os spec
(if (eq system-type `windows-nt)
    (let ()
      (run-with-idle-timer 0.1 nil 'w32-send-sys-command 61488)
      (custom-set-variables
       '(custom-enabled-themes (quote (dichromacy)))
       '(ecb-source-path (quote (("c:" "c:"))))
       '(ecb-wget-setup (quote cons))
       '(inhibit-startup-screen t)
       '(tool-bar-mode nil))))

;;only for linux
(if (eq system-type `gnu/linux)
	`(lambda()
	   (setq load-path
			 (cons (expand-file-name "~/.emacs.d/site-lisp/llvm") load-path))
	   (require 'llvm-mode)
	   (setq load-path
			 (cons (expand-file-name "~/.emacs.d/site-lisp/llvm") load-path))
	   (require 'tablegen-mode)))

;; UTF-8
(if 0
    (lambda()
      (setq current-language-environment "UTF-8")
      (setq default-input-method "chinese-py")
      (setq locale-coding-system 'utf-8)
      (set-terminal-coding-system 'utf-8)
      (set-keyboard-coding-system 'utf-8)
      (set-selection-coding-system 'utf-8)
      (prefer-coding-system 'utf-8)
      ;; get around the Ctrl+SPACE key binding for inputing method
      (global-set-key "\C-cm" 'set-mark-command)
      ;; highlight marked region
      (transient-mark-mode t)
      ;; enable syntax highlight
      (global-font-lock-mode t)
      ;; show column number on status bar
      (setq column-number-mode t)))

;;etags generate-tag-table
(defun generate-tag-table()
  "Generate tag tables under current directory(Linux)."
  (interactive)
  (let   
      ((exp "")
       (dir ""))
    (setq dir (read-from-minibuffer "generate tags in:" default-directory)
          exp (read-from-minibuffer "suffix:" "*.[ch]"))
	(setq command_local (concat "rm -f TAGS && find " dir " -name " "\"" exp "\"" " | xargs -n 1 etags -a"))
	(message command_local)
	(message "tags generating...")
	(with-temp-buffer
	  (shell-command
	   command_local
	   (buffer-name)))
	(message "tags generated!")))

;; nav-49
(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-nav-49")
(require 'nav)
(nav-disable-overeager-window-splitting)
;; Optional: set up a quick key to toggle nav
;; (global-set-key [f8] 'nav-toggle)

;; 启动emacsclient服务，不会打开新的emacs
(server-start)
