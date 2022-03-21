(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aquamacs-additional-fontsets nil t)
 '(aquamacs-customization-version-id 215 t)
 '(aquamacs-tool-bar-user-customization nil t)
 '(auto-hscroll-mode nil)
 '(blink-cursor-mode nil)
 '(c-offsets-alist
   '((template-args-cont . c-lineup-template-arglist)
     (substatement . 0)
     (substatement-open . 0)
     (inline-open . 0)
     (innamespace . 2)
     (comment-intro . c-lineup-comment)))
 '(calendar-today-marker 'calendar-today-face)
 '(case-fold-search 1)
 '(clearcase-checkout-arguments '("\"-unreserved\""))
 '(clearcase-keep-uncheckouts nil)
 '(clearcase-suppress-checkout-comments t)
 '(clearcase-viewroot "/lx-dgcv02/view_store")
 '(column-number-mode t)
 '(current-language-environment "ASCII")
 '(default-frame-alist
    '((menu-bar-lines . 1)
      (foreground-color . "black")
      (background-color . "ivory")
      (cursor-type . box)
      (cursor-color . "purple")
      (internal-border-width . 0)
      (left-fringe . 1)
      (right-fringe)
      (fringe)
      (tool-bar-lines . 0)))
 '(ediff-keep-variants t)
 '(ediff-split-window-function 'split-window-horizontally)
 '(emulate-mac-us-keyboard-mode t)
 '(filladapt-token-table
   '(("^" beginning-of-line)
     (">+" citation->)
     ("\\(\\w\\|[0-9]\\)[^'`\"< 	
]*>[ 	]*" supercite-citation)
     (";+" lisp-comment)
     ("#+" sh-comment)
     ("%+" postscript-comment)
     ("^[ 	]*\\(//\\|\\*\\)[^ 	]*" c++-comment)
     ("@c[ \\t]" texinfo-comment)
     ("@comment[ 	]" texinfo-comment)
     ("\\\\item[ 	]" bullet)
     ("[0-9]+\\.[ 	]" bullet)
     ("[0-9]+\\(\\.[0-9]+\\)+[ 	]" bullet)
     ("[A-Za-z]\\.[ 	]" bullet)
     ("(?[0-9]+)[ 	]" bullet)
     ("(?[A-Za-z])[ 	]" bullet)
     ("[0-9]+[A-Za-z]\\.[ 	]" bullet)
     ("(?[0-9]+[A-Za-z])[ 	]" bullet)
     ("[-~*+]+[ 	]" bullet)
     ("o[ 	]" bullet)
     ("[\\@]\\(param\\|throw\\|exception\\|addtogroup\\|defgroup\\)[ 	]*[A-Za-z_][A-Za-z_0-9]*[ 	]+" bullet)
     ("[\\@][A-Za-z_]+[ 	]*" bullet)
     ("[ 	]+" space)
     ("$" end-of-line)))
 '(ispell-program-name "/opt/local/bin/aspell")
 '(line-number-mode 1)
 '(mark-holidays-in-calendar t)
 '(ns-command-modifier 'meta)
 '(ns-right-command-modifier 'meta)
 '(ns-tool-bar-display-mode nil t)
 '(ns-tool-bar-size-mode nil t)
 '(safe-local-variable-values
   '((c-offsets-alist
      (inexpr-class . +)
      (inexpr-statement . +)
      (lambda-intro-cont . +)
      (inlambda . c-lineup-inexpr-block)
      (template-args-cont c-lineup-template-args +)
      (incomposition . +)
      (inmodule . +)
      (innamespace . +)
      (inextern-lang . +)
      (composition-close . 0)
      (module-close . 0)
      (namespace-close . 0)
      (extern-lang-close . 0)
      (composition-open . 0)
      (module-open . 0)
      (namespace-open . 0)
      (extern-lang-open . 0)
      (objc-method-call-cont c-lineup-ObjC-method-call-colons c-lineup-ObjC-method-call +)
      (objc-method-args-cont . c-lineup-ObjC-method-args)
      (objc-method-intro .
                         [0])
      (friend . 0)
      (cpp-define-intro c-lineup-cpp-define +)
      (cpp-macro-cont . +)
      (cpp-macro .
                 [0])
      (inclass . +)
      (stream-op . c-lineup-streamop)
      (arglist-cont-nonempty c-lineup-gcc-asm-reg c-lineup-arglist)
      (arglist-cont c-lineup-gcc-asm-reg 0)
      (arglist-intro . +)
      (catch-clause . 0)
      (else-clause . 0)
      (do-while-closure . 0)
      (label . 2)
      (access-label . -)
      (substatement-label . 2)
      (substatement . +)
      (statement-case-open . 0)
      (statement-case-intro . +)
      (statement-block-intro . +)
      (statement-cont . +)
      (statement . 0)
      (brace-entry-open . 0)
      (brace-list-entry . 0)
      (brace-list-intro . +)
      (brace-list-close . 0)
      (brace-list-open . 0)
      (block-close . 0)
      (inher-cont . c-lineup-multi-inher)
      (inher-intro . +)
      (member-init-cont . c-lineup-multi-inher)
      (member-init-intro . +)
      (annotation-var-cont . +)
      (annotation-top-cont . 0)
      (topmost-intro-cont . c-lineup-topmost-intro-cont)
      (topmost-intro . 0)
      (knr-argdecl . 0)
      (func-decl-cont . +)
      (inline-close . 0)
      (inline-open . +)
      (class-close . 0)
      (class-open . 0)
      (defun-block-intro . +)
      (defun-close . 0)
      (defun-open . 0)
      (string . c-lineup-dont-change)
      (arglist-close . c-lineup-arglist)
      (substatement-open . 0)
      (case-label . 0)
      (block-open . 0)
      (c . 1)
      (comment-intro . 0)
      (knr-argdecl-intro . -))
     (c-cleanup-list scope-operator brace-else-brace brace-elseif-brace brace-catch-brace empty-defun-braces list-close-comma defun-close-semi)
     (c-hanging-semi&comma-criteria c-semi&comma-no-newlines-before-nonblanks)
     (c-hanging-colons-alist
      (member-init-intro before)
      (inher-intro)
      (case-label after)
      (label after)
      (access-label after))
     (c-hanging-braces-alist
      (substatement-open after)
      (brace-list-open after)
      (brace-entry-open)
      (defun-open after)
      (class-open after)
      (inline-open after)
      (block-open after)
      (block-close . c-snug-do-while)
      (statement-case-open after)
      (substatement after))
     (c-comment-only-line-offset . 0)
     (c-tab-always-indent . t)))
 '(save-completions-flag t)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tab-width 4)
 '(text-mode-hook '(toggle-text-mode-auto-fill text-mode-hook-identify))
 '(today-visible-calendar-hook '(calendar-mark-today))
 '(tool-bar-mode nil nil (tool-bar))
 '(transient-mark-mode 1)
 '(uniquify-buffer-name-style 'post-forward nil (uniquify))
 '(view-calendar-holidays-initially nil)
 '(visual-line-mode nil t)
 '(woman-fill-column 65)
 '(woman-fill-frame nil)
 '(woman-use-own-frame nil)
 '(x-bitmap-file-path
   '("/usr/X11R6/include/X11/bitmaps:/usr/share/emacs/21.3/etc/")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "White" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "nil" :family "Monaco"))))
 '(bold ((t (:foreground "gold4" :slant normal :weight bold :height 130 :width normal :foundry "nil" :family "Monaco"))))
 '(calendar-today-face ((t (:foreground "deeppink1" :weight extra-bold))))
 '(cursor ((t (:background "purple" :foreground "orange"))))
 '(f90-mode-default ((t (:inherit autoface-default :height 130 :family "Monaco"))) t)
 '(font-lock-comment-face ((((class color) (background light)) (:foreground "sienna"))))
 '(font-lock-function-name-face ((((class color) (background light)) (:foreground "indianred3"))))
 '(font-lock-keyword-face ((((class color) (background light)) (:foreground "darkgoldenrod"))))
 '(font-lock-string-face ((((class color) (background light)) (:foreground "steelblue3"))))
 '(font-lock-variable-name-face ((((class color) (background light)) (:foreground "turquoise4"))))
 '(font-lock-warning-face ((t (:foreground "hotpink" :weight bold))))
 '(fundamental-mode-default ((t (:inherit autoface-default :height 130 :family "Monaco"))) t)
 '(highlight ((((class color) (background light)) (:background "lightseagreen"))))
 '(isearch ((((class color) (background light)) (:background "lightpink" :inverse-video nil))))
 '(italic ((t (:foreground "purple" :underline t :slant italic :height 130 :width normal :foundry "nil" :family "Monaco"))))
 '(mode-line ((((type x w32 mac) (class color)) (:background "grey75" :foreground "black" :box (:line-width -1 :style released-button) :family "helv"))))
 '(nxml-attribute-local-name-face ((t (:foreground "firebrick"))))
 '(nxml-attribute-value-delimiter-face ((t (:inherit nxml-delimited-data-face))))
 '(nxml-attribute-value-face ((t (:inherit nxml-delimited-data-face))))
 '(nxml-cdata-section-content-face ((t (:inherit nxml-text-face))))
 '(nxml-comment-content-face ((t (:foreground "sienna"))))
 '(nxml-comment-delimiter-face ((t (:foreground "sienna"))))
 '(nxml-delimited-data-face ((((class color) (background light)) (:inherit font-lock-string-face))))
 '(nxml-delimiter-face ((((class color) (background light)) nil)))
 '(nxml-namespace-attribute-value-face ((t (:inherit nxml-attribute-value-face))))
 '(nxml-text-face ((t nil)))
 '(region ((((class color) (background light)) (:background "yellow"))))
 '(secondary-selection ((((class color) (background light)) (:background "peach puff"))))
 '(show-paren-mismatch ((((class color)) (:background "red" :foreground "green"))))
 '(text-mode-default ((t (:inherit autoface-default :stipple nil :strike-through nil :underline nil :slant normal :weight normal :height 130 :width normal :family "Monaco")))))
