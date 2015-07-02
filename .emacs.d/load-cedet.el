;; cedet emacs23开始内置cedet
;;(require 'cedet)

;;semantic
(require 'semantic-ia nil 'noerror)
(require 'semantic-tag-folding nil 'noerror)
(require 'semantic-c nil 'noerror)

;; url: http://alexott.net/en/writings/emacs-devenv/EmacsCedet.html
;;;; Helper tools.
(custom-set-variables
 '(semantic-default-submodes
   (quote (global-semanticdb-minor-mode
           global-semantic-decoration-mode
           global-semantic-idle-completions-mode
           global-semantic-idle-scheduler-mode
           global-semantic-idle-summary-mode
           global-semantic-mru-bookmark-mode
           global-semantic-highlight-func-mode
           global-semantic-stickyfunc-mode
           global-semantic-idle-local-symbol-highlight-mode)))
 '(semantic-idle-scheduler-idle-time 1.5))
(semantic-mode 1)

;;;; smart complitions
(require 'semantic/ia)
(setq-mode-local c-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(setq-mode-local c++-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))

;;;; Include settings
(require 'semantic/bovine/gcc)
(require 'semantic/bovine/c)

(defconst cedet-user-include-dirs
  (list
   "." ".."
   "./include" "./inc" "../include" "../inc"))
(setq cedet-sys-include-dirs
      (list
       "/usr/include"
       "/usr/local/include"))

(let (include-dirs cedet-user-include-dirs)
  (setq include-dirs (append include-dirs cedet-sys-include-dirs))
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c++-mode)
          (semantic-add-system-include dir 'c-mode))
        include-dirs))

(setq semantic-c-dependency-system-include-path "/usr/include/")

;;;; TAGS Menu
(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))
(add-hook 'semantic-init-hooks 'my-semantic-hook)

;;;; Semantic DataBase存储位置
(setq semanticdb-default-save-directory
      (expand-file-name "~/.emacs.d/semanticdb"))

;; if you want to enable support for gnu global
;; (when (cedet-gnu-global-version-check t)
;;   (semanticdb-enable-gnu-global-databases 'c-mode)
;;   (semanticdb-enable-gnu-global-databases 'c++-mode))
;; enable ctags for some languages:
;;  Unix Shell, Perl, Pascal, Tcl, Fortran, Asm
;; (when (cedet-ectag-version-check t)
;;     (semantic-load-enable-primary-exuberent-ctags-support))

;; gnu global TAGS。
(require 'semantic/db-global)
(semanticdb-enable-gnu-global-databases 'c-mode)
(semanticdb-enable-gnu-global-databases 'c++-mode)

;; EDE: plan to use projects
(global-ede-mode t)
(ede-cpp-root-project "test"
                      :name "test Project"
                      ;; Any file at root directory of the project
                      :file "~/.emacs" ; "~/work/Proj1/Makefile"
                      ;; Relative to the project's root directory
                      :include-path '("/" "/include")
                      :system-include-path '("/usr/include")
                      :spp-table '(("MACRO" . "")))
(ede-enable-generic-projects)
(setq my-base-dir (concat (getenv "HOME") "/include"))
(semantic-add-system-include (concat my-base-dir "/common") 'c++-mode)
(add-to-list 'auto-mode-alist (cons my-base-dir 'c++-mode))
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat my-base-dir "/config.h"))
;; keywords and stuff, set up indenting correctly for new kewords
(setq c-protection-key (concat "\\<\\(public\\|protected"
                               "\\|private"
                               "\\)\\>")
      c-C++-access-key (concat "\\<\\|public\\|protected\\|private"
                               "\\)\\>[ \t]*:"))
(setq c-macro-names-with-semicolon '("DEBUG"))
(c-make-macro-with-semi-re)

;;;;  缩进或者补齐
;; hippie-try-expand settings
(setq hippie-expand-try-functions-list
      '(yas/hippie-try-expand
        semantic-ia-complete-symbol
        try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs))

(defun indent-or-complete ()
  "Complete if point is at end of a word, otherwise indent line."
  (interactive)
  (if (looking-at "\\>")
      (hippie-expand nil)
    (indent-for-tab-command)))

(defun yyc/indent-key-setup ()
  "Set tab as key for indent-or-complete"
  (local-set-key  [(tab)] 'indent-or-complete))

;;;; C-mode-hooks .
(defun my-cedet-hook ()
  "cedet hook key map"
  ;; Semantic functions.
  (semantic-default-c-setup)
  (local-set-key "\C-cb" 'semantic-mrub-switch-tags)
  (local-set-key "\C-cR" 'semantic-symref)
  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cp" 'semantic-ia-show-summary)
  (local-set-key "\C-cl" 'semantic-ia-show-doc)
  (local-set-key "\C-cr" 'semantic-symref-symbol)
  (local-set-key "\C-c/" 'semantic-ia-complete-symbol)
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  (local-set-key "." 'semantic-complete-self-insert)
  (local-set-key ">" 'semantic-complete-self-insert)
  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  (local-set-key [(tab)] 'indent-or-complete))
(add-hook 'c-mode-common-hook 'my-cedet-hook)
(add-hook 'c++-mode-common-hook 'my-cedet-hook)

;; 代码中的跳转
(defadvice push-mark (around semantic-mru-bookmark activate)
  "Push a mark at LOCATION with NOMSG and ACTIVATE passed to `push-mark'.
If `semantic-mru-bookmark-mode' is active, also push a tag onto
the mru bookmark stack."
  (semantic-mrub-push semantic-mru-bookmark-ring (point) 'mark)
  ad-do-it)

;; 查找函数调用 Srecode的使用
;;;; Custom template for srecode
;;(setq srecode-map-load-path
;;  (list (srecode-map-base-template-dir)
;;    (expand-file-name "~/.emacs.d/templates/srecode")))

(global-set-key
 [S-f10] ;; 跳转到上一次的地方
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

(setq semanticdb-project-roots (list (expand-file-name "/")))
