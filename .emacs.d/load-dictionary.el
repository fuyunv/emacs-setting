(add-to-list 'load-path "~/.emacs.d/site-lisp/dictionary")
(load "dictionary-init")

;; install dictd
;;sudo apt-get install dictd dict
;;sudo apt-get install dict-stardic ;download dictionary
;;sudo service dictd start
;;dict -D ;test dict server

;; choose a dictionary server
(setq dictionary-server "localhost")
;; for dictionary tooltip mode
;; choose the dictionary: "wn" for WordNet
;; "web1913" for Webster's Revised Unabridged Dictionary(1913) so on

;; Tool-tip support for GNU Emacs 21
(setq dictionary-tooltip-dictionary "localhost")
;;(setq dictionary-tooltip-dictionary "eng-deu")
(global-dictionary-tooltip-mode 1)

;; key bindings
(global-set-key "\C-cs" 'dictionary-search)
(global-set-key "\C-cm" 'dictionary-match-words)
(global-set-key "\C-cd" 'dictionary-lookup-definition)
;; Popup menu for GNU Emacs 21, and XEmacs 21
(if (boundp 'running-xemacs)
	(global-set-key [(control button3)] 'dictionary-mouse-popup-matching-words)
  (global-set-key [mouse-3] 'dictionary-mouse-popup-matching-words))
