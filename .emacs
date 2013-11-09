;; set Japanese env
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setenv "LC_ALL" "ja_JP.UTF-8")
(prefer-coding-system 'utf-8)
(setq default-file-name-coding-system 'utf-8)

;; other
(global-font-lock-mode t)
(setq line-number-mode t)
(setq frame-title-format
      (concat "%b - emacs@" system-name))
(setq display-time t)
(setq auto-compression-mode t)
(setq make-backup-files nil)
(setq back-up-inhibited t)
(setq backup-directory-alist `(("." . "~/.saves")))
(setq delete-auto-save-files nil)
(setq visible-bell t)
(setq completion-ignore-case t)
(setq-default tab-width 4)
(setq-default c-basic-offset 4)
(show-paren-mode t)
(icomplete-mode 1)
(setq require-final-newline t)
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;; keybind
(global-set-key "\C-z" 'undo)
(define-key global-map "\C-h" 'delete-backward-char)
(define-key global-map "\M-?" 'help-for-help)
(define-key global-map "\C-x\C-u" 'undo)
(define-key global-map "\C-c\C-i" 'dabbrev-expand)
(define-key global-map "\C-cc" 'comment-region)
(define-key global-map "\C-cz" 'uncomment-region)
(define-key global-map "\C-cr" 'replace-string)
(define-key global-map "\C-cu" 'upcase-region)
(define-key global-map "\C-ci" 'indent-region)
(define-key global-map "\C-ct" 'multi-term)
(define-key global-map "\C-c[" 'beginning-of-buffer)
(define-key global-map "\C-c]" 'end-of-buffer)
(define-key global-map "\C-cg" 'goto-line)
(define-key global-map "\C-ca" 'anything)
(define-key global-map "\C-cm" 'moccur-grep-find)
(define-key global-map "\C-cb" 'bookmark-set)

;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

;; packages to install from el-get
(defvar my/el-get-packages
  '(
	color-theme
	color-moccur
	moccur-edit
	wdired
	auto-complete
	multi-term
	smart-compile
	anything
	anything-config
	popwin
	php-mode-improved
	js2-mode
    )
  "A list of packages to install from el-get at launch.")

(el-get 'sync my/el-get-packages)

;; php-mode
(autoload 'php-mode-improved' "php-mode-improved" nil t)
(add-to-list 'auto-mode-alist '("\\.php$". php-mode-improved))

;; js2-mode
(autoload 'js2-mode' "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$". js2-mode))
(when (load "js2" t)
  (setq js-indent-level 4
	js-expr-indent-offset 4
	indent-tabs-mode nil
	js2-cleanup-whitespace nil
	js2-mirror-mode nil
	js2-bounce-indent nil))

;; color-theme
(add-to-list 'load-path "~/.emacs.d/color-theme/")
(when (require 'color-theme nil t)
  (color-theme-initialize)
  (color-theme-charcoal-black))

;; color-moccur
(when (require 'color-moccur nil t)
  ;;set global map
  (define-key global-map (kbd "M-o") 'occur-by-moccur)
  ;;and search with space
  (setq moccur-split-word t)
  ;;not searched by directory search
  (add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
  (add-to-list 'dmoccur-exclusion-mask "^#.+#$")
  (add-to-list 'dmoccur-exclusion-mask "^\*.+\*$")
  (require 'moccur-edit nil t))

;; wdired
(require 'wdired)
(define-key dired-mode-map "r"
  'wdired-change-to-wdired-mode)

;; auto-complete-mode
(when (require 'auto-complete-config nil t)
 (add-to-list 'ac-dictionary-directories
			   "~/.emacs.d/ac-dict")
 (define-key ac-mode-map (kbd "M-TAB") 'auto-complete))

;; multi-term
(when (require 'multi-term nil t)
  (define-key term-raw-map (kbd "C-h") 'term-send-backspace)
  (setq multi-term-program "/bin/bash")
  (define-key term-raw-map (kbd "C-y") 'term-paste))

;;smart-compile
(require 'smart-compile)
(global-set-key "\C-c\C-x" 'smart-compile)

;;anything
(require 'anything-config)
(setq anything-sources
      (list anything-c-source-buffers
	    anything-c-source-files-in-current-dir
            anything-c-source-bookmarks
            anything-c-source-file-name-history
	    ))
(setq anything-samewindow nil)
(global-set-key "\C-c;" 'anything-call-source)

;; popwin
(require 'popwin)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:special-display-config
      '(("*Moccur*")
	("*anything*" :height 20)
	("*anything source select*" :height 20)))
