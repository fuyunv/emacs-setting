;; misc
(setq-default indent-tabs-mode nil);;tabs indent disable
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

;; 匹配的括号之间来回跳转, C-M-f,C-M-b,%
(defun my-match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
		((looking-at "\\s\)") (forward-char 1) (backward-list 1))
		(t (self-insert-command (or arg 1)))))
(global-set-key "%" 'my-match-paren)

;; push and pop a tmp postion
(defun ska-point-to-register()
  "Store cursorposition _fast_ in a register.
Use ska-jump-to-register to jump back to the stored
position."
  (interactive)
  (setq zmacs-region-stays t)
  (point-to-register 8))

(defun ska-jump-to-register()
  "Switches between current cursorposition and position
that was stored with ska-point-to-register."
  (interactive)
  (setq zmacs-region-stays t)
  (let ((tmp (point-marker)))
	(jump-to-register 8)
	(set-register 8 tmp)))
(global-set-key [(control ?\.)] 'ska-point-to-register)
(global-set-key [(control ?\,)] 'ska-jump-to-register)

;; my-go-to-char
(defun my-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `my-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
					 char)
	(search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))
(define-key global-map (kbd "C-c a") 'my-go-to-char)

;;hide region
(require 'hide-region)
(global-set-key (kbd "C-c r") 'hide-region-hide)
(global-set-key (kbd "C-c R") 'hide-region-unhide)

 ;; hide lines
(require 'hide-lines)
(global-set-key (kbd "C-c l") 'hide-lines)
(global-set-key (kbd "C-c L") 'show-all-invisible)
