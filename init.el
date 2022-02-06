;;-----------------------------------------------------------------------------
;; Some general notes about using emacs
;;-----------------------------------------------------------------------------
;; Useful emacs command: igrep-visited-files (greps for stuff in all visited
;; files!). search find all open buffers
;;-----------------------------------------------------------------------------

;; (setq myhomedir "/home/zippy"); Linux
(cond ((eq system-type 'darwin)
       (setq myhomedir "/Users/zippy"); MacOS
       )
      ((eq system-type 'windows-nt)
       (setq myhomedir "/Users/zippy"); Windows
       (setq-default buffer-file-coding-system 'utf-8-unix)
       ))
(setq mydocumentsdir (concat (eval 'myhomedir) "/Documents")); Linux, MacOS
;;(setq mydocumentsdir "/mnt/f/Users/zippy/OneDrive/Documents"); WSL tdesk


;; Windows 10 specific stuff
(cond ((eq system-type 'windows-nt)
       (require 'package)
       (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
       (add-to-list 'load-path "~/.emacs.d/packages/")
       ;;ispell replacement:
       (set 'ispell-program-name "hunspell")
       (setq ispell-hunspell-dict-paths-alist
             '(("en_US" "c:/Hunspell/en_US.aff")
               ("default" "c:/Hunspell/default.aff")))
       (setq ispell-local-dictionary-alist
             '(("default" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "default") nil utf-8)
               ("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_US") nil utf-8)))
       (flyspell-mode 1)
       ))

;;-----------------------------------------------------------------------
;; Function keys and numeric keypad:
;;-----------------------------------------------------------------------

;(define-key global-map [f1] 'mouse-consolidated-yank)               ; F1
(define-key global-map [f1] 'broken-next-error)                      ; F1
(define-key global-map [M-f1] 'next-error)                           ; M-F1
(define-key global-map [f2] 'switch-to-buffer)                       ; F2
(define-key global-map [f3] 'view-file)                              ; F3
(define-key global-map [f4] 'save-buffer)                            ; F4
(define-key global-map [f5] 'call-last-kbd-macro)                    ; F5
(define-key global-map [f6] 'uniquify-rationalize-file-buffer-names) ; F6
(define-key global-map [f7] 'clearcase-ediff-named-version-current-buffer) ; F7
(define-key global-map [f8] 'goto-line)                              ; F8
;; Define F9 to reread saved version of current file:
(define-key global-map [f9]
  (quote (lambda nil (interactive) (revert-buffer t "yes"))))        ; F9
(define-key global-map [M-f9] 'revert-all-buffers)                   ; M-F9
(define-key global-map [f10]
  (quote (lambda nil (interactive) (compare-windows t))))            ; F10
(define-key global-map [f11] "\C-u0\C-l")                            ; F11
(define-key global-map [f12] 'query-replace)                         ; F12
(define-key global-map [kp-divide] 'other-window)                    ; / keypad
(define-key global-map [kp-subtract] 'isearch-forward)               ; - keypad
(define-key global-map [kp-add] 'isearch-repeat-forward)             ; + keypad

;; Macintosh keyboard (aluminum 2009):
(define-key global-map [f13] 'overwrite-mode)                        ; F13
(define-key global-map [S-f13] 'x-clipboard-yank)                    ; S-F13
(define-key global-map [C-S-f13] 'x-clipboard-yank)                    ; S-F13

;;-----------------------------------------------------------------------------
;; Window frame widgets, modeline, menubar, and such:
;;-----------------------------------------------------------------------------

(setq line-number-mode 1)          ; Display cursor's line number in modeline
(setq column-number-mode 1)        ; Display cursor's column number in modeline
(set-variable 'pending-delete-modeline-string nil) ; No "PenDel" in modeline
(set-variable 'modeline-multibyte-status nil) ; No "ISO8".. in modeline

;; Show path or buffer name on X Window titlebar:
(setq frame-title-format
      '("%S: " (buffer-file-name "%f"
                                 (dired-directory dired-directory "%b"))))


;;-----------------------------------------------------------------------
;; Other stuff to make Emacs work how I like it.
;;-----------------------------------------------------------------------

;; Copiers of this file beware these changes:
;;(global-set-key "\C-z" 'undo) ;
(global-set-key "\C-x\C-v" 'view-file) ; Default binding was find-alternate-file
(global-set-key "\M-?" help-map)      ; Make esc-? help-map key (formerly ^h).
;;(global-set-key "\C-h" 'backward-delete-char-untabify)  ; Make ^h backspace.
(global-set-key "\C-h" 'delete-backward-char) ; Make ^h backspace.
(global-set-key "\M-h" 'backward-kill-word) ; Make esc-h backward delete word.
(global-set-key [delete] 'delete-char) ; Make Delete key delete char at cursor.
(global-set-key "\M-r" 'recompile)
(global-set-key "\M-s" 'replace-string)
(global-set-key "\M-'" 'al) ; indents whole buffer (see my defun for al below)
(setq show-trailing-whitespace nil) ; Set to t to turn on.
(define-key global-map [C-f12] 'delete-trailing-whitespace)
(setq compilation-scroll-output t) ; Scroll compilation buffer as it compiles

(auto-image-file-mode)

;; Horizontal scrolling:
(define-key global-map [\M-\C-right]
  (quote (lambda nil (interactive) (scroll-left 1))))
(define-key global-map [\M-\C-left]
  (quote (lambda nil (interactive) (scroll-right 1))))


(setq display-warning-suppressed-classes '(info notice warning));//no-op?
(setq display-warning-minimum-level 'error);//trying this out 2/04/2004

;; Uniquify: if you have multiple buffers with the same file name, this
;; appends enough of the paths to the file to distinguish them (following a
;; "|" character). Much better than the standard Emacs filename, filename<1>,
;; etc.:
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward) ; maybe try forward instead

;; Ibuffer makes buffer list like dired:
;;   t - toggles marks (so hitting it will mark everybuffer)
;;   O - will search all marked buffers like occur
;;problems (require 'ibuffer)
;;problems (global-set-key "\C-x\C-b" 'ibuffer)

;; Syntax highlighting (font-lock-mode); always do it, with colors:
(require 'font-lock)
(remove-hook 'font-lock-mode-hook 'turn-on-fast-lock)
(remove-hook 'font-lock-mode-hook 'turn-on-lazy-shot)
(setq-default font-lock-use-fonts nil)
(setq-default font-lock-use-colors '(color))
(setq-default font-lock-maximum-decoration t)
;; Maximum fontifyable buffer size in K:
(setq-default font-lock-maximum-size 2560000)
;; Turn off "Font" indicator of font-lock-mode in modeline, to save space
;twilliam (setcar (cdr (assq 'font-lock-mode minor-mode-alist)) nil)


;; Turn off vertical scroll bars by default; use my vsb/unvsb functions
;; defined below to toggle this on/off again:
;;twilliam (set-specifier vertical-scrollbar-visible-p nil)

;; Parens highlighting (set to highlight entire expression betwen parens):
;twilliam (paren-set-mode (`sexp))

;; Make Meta-q do query-replace function:
;(global-unset-key "\M-q")
;(global-set-key "\M-q" 'query-replace)
;(local-unset-key "\M-q")
;(local-set-key "\M-q" 'query-replace)
;(define-key global-map "\M-q" 'query-replace)

(delete-selection-mode 1)                ; Set up to delete selection auto.
(global-set-key "\C-xw" 'write-region)   ; Make ^xw write mark region to file.
(global-set-key "\C-x\C-i" 'insert-file) ; Make ^x^i insert file at cursor.
(global-set-key "\M- " 'set-mark-command); Make esc-space set mark.

;;XP (setq visible-bell t)                ; Flash screen instead of beeping bell
;;MacOSXBug (setq visible-bell t)                ; Flash screen instead of beeping bell
(load (concat (eval 'myhomedir) "/.emacs.d/packages/rwd-bell.el")) ; Alternative to visible bell
(setq auto-save-default nil)         ; Turn off default autosave
(setq-default case-fold-search 1)    ; Make searches case-insensitive.
(setq-default fill-column 78)        ; Fill out to column 79 on fill commands.
(global-set-key "\C-c\C-f" 'fill-paragraph) ; Make ^c^f do fill-paragraph.

(setq tab-width 2)
(setq tab-stop-list '(2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60 62 64 66 68 70 72 74 76))
;; (setq tab-width 4)
;; (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76))
(setq transient-mark-mode 1)      ; Set transient-mark mode (hilights stay)
(setq next-line-add-newlines nil) ; Stop down-arrow from adding empty lines at
                                  ; end of buffer.
(setq-default indent-tabs-mode nil) ; "Tab" or C-i inserts spaces, not tab
                                    ; characters.
;;twilliam????  (setq-default pending-delete-mode nil) ; Typing deletes selected text.
;;(set-variable 'pending-delete-modeline-string nil) ; No "PenDel" in modeline
;;mscmvc conflixt(global-set-key "\C-c\C-c" 'comment-region) ; Self-explanatory
(global-set-key "\C-cc" 'comment-region) ; Self-explanatory.

(global-unset-key "\C-x\C-z")        ; Nuke suspend-or-iconify-emacs binding
(global-unset-key "\C-z")            ; Nuke suspend-or-iconify-emacs binding
(global-set-key "\C-c\C-i" 'iconify-emacs) ; Bind this to iconify windows.
(global-set-key "\C-c\C-n" 'iconify-emacs) ; Bind this to iconify windows.


;;tjw (global-set-key "\C-down" 'view-scroll-lines-up);
;;tjw (global-set-key "\C-up" 'view-scroll-lines-down);
;;tjw (define-key global-map 'control-down 'view-scroll-lines-up);
;;tjw (define-key global-map 'control-up 'view-scroll-lines-down);

;; *****

;; -----------------------------------------------------------------------
;; Mouse actions
;; -----------------------------------------------------------------------
;; Note: following *can't* be bound to a key; only to a mouse action:
;; Quick way to get selectable list (menu) of buffers, to jump between:
(global-set-key [(shift button3)] 'popup-buffer-menu)


;;-----------------------------------------------------------------------
;; My own elisp functions, keyboard macro definitions, and aliases.
;;-----------------------------------------------------------------------

(setq load-path (cons (concat (eval 'myhomedir) "/.emacs.d/packages") load-path))

;;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph    
(defun unfill-paragraph ()
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(fset 'cf_foo
   "\C-xi~/lcf\C-m\C-[xreplace-string\C-m|\C-m,\C-m\C-x\C-s\C-xk\C-m")

(fset 'p_foo
   "\C-xi~/lp\C-m\C-[xreplace-string\C-m|\C-m,\C-m\C-x\C-s\C-xk\C-m")

(defun revert-all-buffers()
  "Refreshes all open buffers from their respective files"
  (interactive)
  (let* ((list (buffer-list))
         (buffer (car list)))
    (while buffer
      (if (string-match "\\*" (buffer-name buffer)) 
	      (progn
	        (setq list (cdr list))
	        (setq buffer (car list)))
        (progn
          (set-buffer buffer)
          (revert-buffer t t t)
          (setq list (cdr list))
          (setq buffer (car list))))))
  (message "Refreshing open files"))

(fset 'fixwhitespace
   [?\M-x ?r ?e ?p ?l ?a ?c ?e ?- ?s ?t ?r ?i ?n ?g return ?\C-q tab return ?  ?  return ?\M-< ?\M-x ?r ?e ?p ?l ?a ?c ?e ?- ?s ?t ?r ?i ?n ?g return ?\C-q ?\C-m return return ?\M-< M-f12 ?\M-' ?\C-x ?\C-s ?\C-x ?k return])

(defun al ()
  "Run indent-region on entire file. Use to format an entire C++ file, for example."
  (interactive)
  (point-to-register 97 nil) (beginning-of-buffer) (set-mark-command nil)
  (end-of-buffer) (indent-region (region-beginning) (region-end) nil)
  (jump-to-register 97 nil) (exchange-point-and-mark) (exchange-point-and-mark)
  (set-mark-command nil))

(defun date-stamp ()
  "Prints the date and time in the current buffer at the point."
  (interactive)
  (insert (format-time-string "%a %b %e %Y %H:%M:%S"))
  )

(setq desktop-base-file-name (concat ".emacs." (system-name) ".desktop") )
(setq desktop-base-lock-name (concat ".emacs." (system-name) ".desktop.lock") )

(defun ds ()
  "Save desktop (list of open files) to ~/.emacs.<hostname>.desktop. zippy"
  (interactive)
;;Windows10   (desktop-save "~/")
  (desktop-save (concat (eval 'myhomedir) "/"))
  )

(defun ir ()
  "Indent region. zippy"
  (interactive)
  (indent-region (region-beginning) (region-end) nil)
  )

(fset 'sk
   [?\[ ?s ?e ?a ?r ?c ?h ?  ?k ?e ?y ?w ?o ?r ?d ?\]])

(defun vb ()
  "Turn on visible-bell mode. zippy"
  (interactive)
  (set-variable (quote visible-bell) t)
  )

(defun tws ()
  "Turn on display of trailing whitespace."
  (interactive)
  (set-variable 'show-trailing-whitespace t)
  )
(defun untws ()
  "Turn off display of trailing whitespace."
  (interactive)
  (set-variable 'show-trailing-whitespace nil)
  )

(defun trunc ()
  "Turn line-wrapping off."
  (interactive)
  (set-variable 'truncate-lines 1)
  (setq truncate-partial-width-windows 1)
  )

(defun untrunc ()
  "Turn line-wrapping on."
  (interactive)
  (set-variable 'truncate-lines nil)
  (setq truncate-partial-width-windows nil)
  ;;  (eval-expression (quote (setq truncate-partial-width-windows nil)) nil)
  ;; Interactively: M-: (setq truncate-partial-width-windows nil) RET
  )

(defun hsb ()
  "Turn on horizontal scroll bars."
  (interactive)
  (set-specifier horizontal-scrollbar-visible-p t)
  )

(defun unhsb ()
  "Turn off horizontal scroll bars."
  (interactive)
  (set-specifier horizontal-scrollbar-visible-p nil)
  )

(defun vsb ()
  "Turn on vertical scroll bars."
  (interactive)
  (set-specifier vertical-scrollbar-visible-p t)
  )

(defun unvsb ()
  "Turn off vertical scroll bars."
  (interactive)
  (set-specifier vertical-scrollbar-visible-p nil)
  )

(fset 'broken-next-error
   [?\C-x ?o ?\C-x ?o ?\C-x ?b ?* ?c ?o ?m ?p ?i tab return ?\M-< ?\C-s ?e ?r ?r ?o ?r ?: ?\C-a return])

(fset 'bleen
   [?\C-d ?\C-d ?\C-d ?\C-_ ?\C-  ?\C-s ?| ?\C-b ?\C-b ?\C-w ?\C-n ?\C-n ?\C-n ?\C-n ?\C-e ?\C-r ?/ ?\C-f ?\C-y ?\C-k ?} ?\M-< ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-d ?\C-d ?\C-d ?\C-  ?\C-s ?| ?\C-b ?\C-b ?\C-w ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-e ?\C-r ?/ ?\C-f ?\C-y ?\C-k ?} ?\M-< ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-d ?\C-d ?\C-d ?\C-  ?\C-s ?| ?\C-b ?\C-b ?\C-w ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-e ?\C-r ?/ ?\C-f ?\C-y ?\C-k ?} ?\M-< ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-d ?\C-d ?\C-d ?\C-  ?\C-s ?| ?\C-b ?\C-b ?\C-w ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-e ?\C-r ?/ ?\C-f ?\C-y ?\C-k ?} ?\M-< ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-d ?\C-d ?\C-d ?\C-  ?\C-s ?| ?\C-b ?\C-b ?\C-w ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-e ?\C-r ?/ ?\C-f ?\C-y ?\C-k ?} ?\M-< ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-d ?\C-d ?\C-d ?\C-  ?\C-s ?| ?\C-b ?\C-b ?\C-w ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-e ?\C-r ?/ ?\C-f ?\C-y ?\C-k ?} ?\M-< ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-d ?\C-d ?\C-d ?\C-  ?\C-s ?| ?\C-b ?\C-b ?\C-w ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-e ?\C-r ?/ ?\C-f ?\C-y ?\C-k ?} ?\M-< ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-p ?\C-d ?\C-d ?\C-d ?\C-e ?\C-h ?\C-h ?\C-h ?\C-_ ?\C-  ?\C-a ?\C-w backspace ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-n ?\C-e ?\C-r ?/ ?\C-f ?\C-y ?\C-k ?}])

(defun ne () "Insert instance of Tim\'s log-file entry separtor at file end."
       (interactive)
       (end-of-buffer nil) (search-backward "logend")
       (beginning-of-line) (set-mark-command nil)
       (insert "\n----------------------------\n\n----------------------------\n")
       (previous-line 2) (set-mark-command nil) (date-stamp) (set-mark-command nil)
       (next-line 1) (end-of-line) (set-mark-command nil) (previous-line 1) (previous-line 1) (beginning-of-line) (center-region (region-beginning) (region-end))
       (next-line 3)  (insert "\n\n\n") (previous-line 2) (set-mark-command nil)
       )

;; (fset 'ne
;;    [?\M-x ?e ?e return return return ?\C-u ?2 ?8 ?- return ?\M-x ?d ?a ?t ?e ?- ?s ?t ?a ?m ?p return return ?\C-u ?2 ?8 ?- return return ?\C-p ?\C-p ?\C-p ?\C-p ?\M-x ?c ?e ?n ?t ?e ?r ?- ?l ?i ?n ?e return ?\C-n ?\M-x ?c ?e ?n ?t ?e ?r ?- ?l ?i ?n ?e return ?\C-n ?\M-x ?c ?e ?n ?t ?e ?r ?- ?l ?i ?n ?e return ?\C-n ?\C-n])

(defun ee () "Put cursor at last-entry insertion point of Tim\'s log-file."
  (interactive)
  (beginning-of-buffer nil) (search-forward "logend")
  (beginning-of-line) (previous-line 2) (end-of-line)
  )

(defun hostname () "\nEcho value of Unix hnanl environment variable."
  (interactive)
  (set-variable 'hostname-message '$hnanl ) ; How to make this work???
  (display-message 'message hostname-message )
  )

(defun uq () "\nShortcut for uniquify-rationalize-file-buffer-names."
  (interactive)
  (uniquify-rationalize-file-buffer-names)
  )

(defun fm () "\nShortcut for font-lock-mode."
  (interactive)
  (font-lock-mode)
  )

(defalias 'tidy (read-kbd-macro
"C-r ... SPC C-a C-SPC C-s java C-f C-x C-x C-x C-x C-SPC C-r affected SPC files SPC 2*<C-n> C-a C-x C-x C-x r k 2*<C-n>"))

(defalias 'cpptidy (read-kbd-macro
"C-r ... SPC C-a C-SPC C-s src C-f C-x C-x C-x C-x C-SPC C-r affected SPC files SPC 2*<C-n> C-a C-x C-x C-x r k 2*<C-n>"))

(defalias 'gc
  (read-kbd-macro "M-x set- goal- colu TAB RET"))

(defalias 'fl (read-kbd-macro "M-x font-lock-fontify-buffer RET"))

(defalias 'fp (read-kbd-macro "M-x fill-paragraph RET"))

(defalias 'gu (read-kbd-macro
"C-s > C-e C-r . C-SPC M-b M-w C-a RET C-p #ifndef SPC C-y _h C-SPC 2*<M-b> M-x upcase- reg TAB RET C-n C-e RET #endif C-n C-a"))

(defalias 'g4u (read-kbd-macro
"M-x gu RET 3*<C-p> 2*<C-k> C-y C-n C-y C-p M-f M-h define 2*<C-n> C-a"))

(defalias 'gsu (read-kbd-macro
"C-e M-b M-SPC M-f M-w C-a RET C-p #ifndef SPC STL_ C-y _h C-SPC 3*<M-b> M-x upcase- reg TAB RET C-a 2*<C-k> C-y C-n C-y C-p M-f M-h define C-e RET #endif C-n C-a"))

(defun pi () "\nIndent paragraph."
  (interactive)
  (fill-paragraph nil)
  (mark-paragraph)
  (indent-region (region-beginning) (region-end) nil)
  )

;; Perforce Description text highlight for typeover:
(defalias 'pd
  (read-kbd-macro "C-s Description: C-s C-n M-b C-b C-SPC C-e"))

(defalias 'nsheadersfix (read-kbd-macro
"C-e C-SPC C-n M-f M-b C-w C-n C-a C-SPC M-f M-b C-w C-e C-SPC C-n C-a M-f M-b C-w C-n C-a C-SPC M-f M-b C-w C-e C-SPC C-n C-a M-f M-b C-w C-n C-a C-SPC M-f M-b C-w C-e C-SPC C-n C-a M-f M-b C-w C-n C-a C-SPC M-f M-b C-w C-e C-SPC C-n C-a M-f M-b C-w C-n C-k"))

;; Fix one line of email header cut from Netscape mail and pasted to Xemacs:
(defalias 'hf (read-kbd-macro
"C-s : M-b C-SPC C-a C-w C-s : C-e C-SPC M-f M-b C-SPC C-x C-x C-SPC C-p C-e C-w C-n C-a"))


(defun f72 () "\nSet fill column to 72."
  (interactive)
  (set-fill-column 72))

(defalias 'like043 (read-kbd-macro
"C-s <ca C-a 2*<C-k> C-r <ra C-n C-a C-y C-s <accrualdcb C-a 2*<C-k> C-r <ra 2*<C-n> C-a C-y C-s <pa C-a 2*<C-k> C-r <ra 3*<C-n> C-a C-y C-s <accrualstartdate C-a 2*<C-k> C-r <ra 4*<C-n> C-a C-y C-s <cu C-a 2*<C-k> C-r <ra 5*<C-n> C-a C-y C-s <accruale C-a 2*<C-k> C-r <ra 6*<C-n> C-a C-y C-s <paydate C-a 2*<C-k> C-r <ra 7*<C-n> C-a C-y C-s <not C-a 2*<C-k> C-r <ra 8*<C-n> C-a C-y"))


;; For comparing jfidmath toString() outputs to C++ printit() outputs; this
;; moves to next "=" and resumes comparison from there.
(defalias 'ec
  (read-kbd-macro "C-s = C-b C-x o C-s = C-b C-x o <f10>"))

;;-----------------------------------------------------------------------
;; General, and text-mode stuff
;;-----------------------------------------------------------------------
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-filladapt-mode)
(add-hook 'c++-mode-hook 'turn-on-filladapt-mode)
(require 'filladapt) ; This smart-indent numbered/bulleted lists and such
(show-paren-mode 1)
(setq show-paren-delay 0)
;;Windows10 (require 'igrep) ; igrep-visited-files and other grep enhancements

;; More from Colin Rafferty:
;;zippy (global-set-key [(return)] 'newline-and-indent)
;;zippy (global-set-key [(linefeed)] 'newline)
(global-set-key [(linefeed)] 'newline-and-indent)

;; Stuff from file I copied to modify that might be useful someday:
;(setq text-mode-hook '(lambda () (auto-fill-mode 1))) ;auto fill in text mode.
;(setq html-mode-hook '(lambda () (auto-fill-mode 0))) ;not in html mode.
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;;-----------------------------------------------------------------------
;; SVN stuff
;;-----------------------------------------------------------------------
(add-to-list 'vc-handled-backends 'SVN)

;;-----------------------------------------------------------------------
;; Shell-mode stuff
;;-----------------------------------------------------------------------
(add-hook 'shell-mode-hook
          (function (lambda ()
		      (setq comint-input-ring-file-name
                            "~zippy/emacs/.shellhist"
			    )
		      )))


;;-----------------------------------------------------------------------
;; C++
;;-----------------------------------------------------------------------
(defun my-c++-indent-setup ()
  (c-set-style "k&r")
  (setq c-basic-offset 2) ;;tim2
  ;; (setq c-basic-offset 4) ;;tim4
  (setq indent-tabs-mode nil)
  (setq show-trailing-whitespace nil)
  (c-set-offset (quote innamespace) 2 nil)) ;;tim2
  ;; (c-set-offset (quote innamespace) 4 nil)) ;;tim4
(add-hook 'c++-mode-hook 'my-c++-indent-setup)

(defun c-lineup-template-arglist (langelem)
  ;; for use as offset for template-args-cont.
  (save-match-data
    (save-excursion
      (beginning-of-line)
      (condition-case nil
          (let ((count 1))
            (while (not (zerop count))
              (re-search-backward "[<>]")
              (setq count (+ count (if (looking-at "<") -1 1))))
            (1+ (- (current-column) (c-langelem-col langelem t))))
        (error 0)))))

;;(c-set-offset (quote innamespace) 2 nil)
;; (c-set-offset 'innamespace 2)
;;zippy (c-set-offset 'inline-open '0)
;;zippy (c-set-offset 'substatement-open '0)
;;zippy (c-set-offset 'substatement '0) ;;the new world...
;;zippy (c-set-offset 'template-args-cont 'c-lineup-template-arglist)

;; Allow skipping forward/backward among "words" in ThisCapsNamingConvention:
(global-set-key [(meta B)] 'c-backward-into-nomenclature)
(global-set-key [(meta F)] 'c-forward-into-nomenclature)


;;-----------------------------------------------------------------------
;; Auto-insert copyright, include guards, etc. in new C++ and Perl files:
;; -----------------------------------------------------------------------

(require 'autoinsert)
(add-hook 'find-file-hooks 'auto-insert)
(setq auto-insert t)
(setq auto-insert-query t)

(defvar sf-auto-insert-header-prompt t)
(defvar sf-auto-insert-header-unique-level 0)
(defvar sf-auto-insert-java-class t)

(defun sf-auto-insert-header-name (file-name pos)
  ((read-string "Include guard to use: " auto-insert-string)
   auto-insert-string))

(defun spg-copyright-c (&optional comment)
  (let* ((c (or comment "//"))
	 (bar (make-string 77 (elt c 0))))
    (concat
     c " Copyright (c) "
     (substring (current-time-string) 20 24)
     " Argonne National Laboratory. All rights reserved.\n\n")))

(setq auto-insert-alist
      `((("\\.H$\\'" . "c++ header")
         (concat
;;          "_spg_"
;;          "_spgx_x"
          "_cdsmm_x"
;;          (replace-regexp "n" "zzz" (file-name-directory buffer-file-name) )
          (replace-regexp "/" "zzz" (file-name-directory buffer-file-name) )
          "_"
          (file-name-sans-extension (file-name-nondirectory buffer-file-name))
          "_H_")
         "#ifndef " str "\n"
         "#define " str "\n\n"
         (spg-copyright-c)
;;          _ "\n\nnamespace mbspr\n{\n    namespace Core\n    {\n\n    }\n}\n\n#endif\n")
         _ "\n\n#endif\n")
        (("\\.C$\\'" . "c++ body")
         ""
         (spg-copyright-c)
         _)
        (("\\.cpp$\\'" . "c++ body")
         ""
         (spg-copyright-c)
         _)
        (("\\.pl$\\'" . "perl")
         ""
         "#!/tp/bin/perl\n\n"
         (spg-copyright-c "#")
         _)
        (("\\.sh$\\'" . "shell script")
         ""
         "#!/bin/ksh\n\n"
         (spg-copyright-c "#")
         _)
        (("\\.ksh$\\'" . "shell script")
         ""
         "#!/bin/ksh\n\n"
         (spg-copyright-c "#")
         _)
        (("\\akefile$\\'" . "makefile")
         ""
         "# -*- Mode: makefile -*-\n\n"
         (spg-copyright-c "#")
         _)
        (("\\.mk$\\'" . "makefile")
         ""
         "# -*- Mode: makefile -*-\n\n"
         (spg-copyright-c "#")
         _)
        (("make.inc\\'" . "makefile")
         ""
         "# -*- Mode: makefile -*-\n\n"
         (spg-copyright-c "#")
         _)
      ))



;;-----------------------------------------------------------------------
;; Perl
;;-----------------------------------------------------------------------
(set-variable 'cperl-indent-level 2)
(set-variable 'cperl-brace-offset 0)
(set-variable 'cperl-continued-brace-offset 0)
(set-variable 'cperl-continued-statment-offset 0)
(set-variable 'cperl-brace-imaginary-offset 0)

(set-variable 'perl-indent-level 2)
(set-variable 'perl-brace-offset -2)
(set-variable 'perl-continued-brace-offset -2)
(set-variable 'perl-continued-statment-offset 2)
(set-variable 'perl-brace-imaginary-offset 0)


;;-----------------------------------------------------------------------
;; (k)sh
;;-----------------------------------------------------------------------
;; See sh-mode help for documentation of these variables:
(setq sh-indent 2)
(setq sh-case-indent 2)
(setq sh-case-item-offset 2)
(setq sh-group-offset 0)
(setq sh-brace-offset 0)

;;-----------------------------------------------------------------------
;; SQL
;;-----------------------------------------------------------------------

(setq sql-sybase-program "/tp/bin/sqsh")
(setq sql-user "zippy")
(setq sql-password "zippy123")
(setq sql-server "IQPSPGX1")
(setq sql-database "spgx")

;;-----------------------------------------------------------------------
;; XML
;;-----------------------------------------------------------------------
(load (concat (eval 'myhomedir) "/.emacs.d/packages/nxml-mode-20041004/rng-auto.el"))

;;-----------------------------------------------------------------------
;; Personal auto mode selection
;;-----------------------------------------------------------------------
(setq auto-mode-alist
      (append
       '(
         ("\\.[s]htm[l][f]$\\'" . html-mode)    ; HTML files
         ("\\.htmlf$\\'" . html-mode)    ; HTML files
;;         ("\\.[Xx][Mm][Ll]$\\'" . xml-mode) ; XML files
         ("\\.[Xx][Mm][Ll]$\\'" . nxml-mode) ; XML files
         ("\\.[ctyYP]$\\'" . c-mode)      ; Extended set of c-mode files.
         ("\\.[HhC]$\\'" . c++-mode)      ; C++ source files
         ("\\.cpp$\\'" . c++-mode)        ; C++ source files
         ("\\.tpp$\\'" . c++-mode)        ; C++ source files
         ("\\.hpp$\\'" . c++-mode)        ; C++ source files
         ("\\.f77$\\'" . fortran-mode)    ; f77 source files
         ("\\.f90$\\'" . f90-mode)    ; f90 source files
         ("\\.F90$\\'" . f90-mode)    ; f90 source files
         ("\\.F$\\'" . fortran-mode)      ; f77 sources to be C-preprocessed
         ("\\.[135]$\\'" . nroff-mode)    ; troff man page source files.
         ("\\.mlabs$\\'" . nroff-mode)    ; troff man page source files.
         ("\\.mk\\'" . makefile-mode)                 ; Makefile mode
         ("[GNU][Mm]akefile*$\\'" . makefile-mode)    ; Makefile mode
         ("\\.[Xx][eE]macs*$\\'" . emacs-lisp-mode) ; Emacs startup files
         ("\\.log\\'" . text-mode)      ; (tjw) my log files, like ms.log
         ("\\.login\\'" . sh-mode)      ; .login files (currently, login ksh)
         ("\\.[k]sh\\'" . sh-mode)      ; ksh shell script files.
         ("\\.profile*$\\'" . sh-mode)  ; ksh shell script files.
         ("\\.envfile*$\\'" . sh-mode)  ; ksh shell script files.
         ("\\.xrdb\\'" . xrdb-mode)     ; X resources files.
         )
       auto-mode-alist))


;;-----------------------------------------------------------------------
;; Abbreviations
;;-----------------------------------------------------------------------
(setq default-abbrev-mode t)
(setq custom-abbrev-file (concat (eval 'myhomedir) "/.emacs.d/emacs-abbrev"))
(cond ((file-exists-p custom-abbrev-file) (load-file custom-abbrev-file)))

;;-----------------------------------------------------------------------
;; Faces (fonts and colors for font-lock and other modes)
;;-----------------------------------------------------------------------
(cond ((display-graphic-p)
       ;; Graphical code goes here.
       (setq custom-file (concat (eval 'myhomedir) "/.emacs.d/xemacs-" (system-name) "-custom.el"));
       )
      (t
       ;; Console-specific code
       (setq custom-file (concat (eval 'myhomedir) "/.emacs.d/emacs-custom-24.el"));
       ))
(load-file custom-file);


;;-----------------------------------------------------------------------
;; PostScript printing
;;-----------------------------------------------------------------------
(defun sp1585 () "\nAssign 1585 3rd floor printers (BW only)"
  (interactive)
  (setq zippybwprinter "hqp404") ; 1585 B&W
  (setq zippycolorprinter "hqc201") ; Note: b&w, not color
  )
(defun spcig35 () "\nAssign Citadel 35th floor printers (BW only)"
  (interactive)
  (setq zippybwprinter "chimortgages3-35") ; 1585 B&W
  (setq zippycolorprinter "chimortgages3-35") ; Note: b&w, not color
  )

;;(setq ps-lpr-command "lpr")
(setq ps-lpr-command "lp")
;;printerOutOfCyanToner (setq ps-lpr-switches " -Pcgc401 ")
;;(setq ps-lpr-switches " -Pcgp401 ")
(setq ps-lpr-switches '(" -Ppr_2d11_color_mcs_anl_gov_generic_ps"))
(setq ps-print-color-p t)
;(setq ps-print-color-p nil)
;(setq ps-bold-faces
;      "font-lock-keyword-face
;               font-lock-type-face
;               font-lock-xml-tag-name-face")
;(setq ps-italic-faces
;      "font-lock-comment-face
;               font-lock-string-face")
;(setq ps-default-fg "black")
;(setq ps-default-bg "white")
(defun pcb () "\nPrint buffer in color."
  (interactive)
  (setenv "PRINTER" zippycolorprinter)
  (set-variable 'ps-print-color-p t)
  (set-face-background 'default "white")
  (ps-print-buffer-with-faces)
  (set-face-background 'default "ivory")
  )
(defun pcr () "\nPrint region in color."
  (interactive)
  (setenv "PRINTER" zippycolorprinter)
  (set-variable 'ps-print-color-p t)
  (set-face-background 'default "white")
  (set-face-background 'zmacs-region "white")
  (ps-print-region-with-faces (point) (mark) nil)
  (set-face-background 'zmacs-region "yellow")
  (set-face-background 'default "ivory")
  )
(defun fpcb () "\nPrint buffer in color to a .pdf file."
  (interactive)
  (set-variable 'ps-print-color-p t)
  (set-face-background 'default "white")
  (set-variable 'tjwps (concat (eval 'mydocumentsdir) "/printouts//" (file-name-nondirectory (buffer-file-name)) ".ps"))
  (set-variable 'tjwpdf (concat (eval 'mydocumentsdir) "/printouts/" (file-name-nondirectory (buffer-file-name)) ".pdf"))
  (ps-print-buffer-with-faces tjwps)
  (shell-command (concat "/usr/bin/ps2pdf " tjwps " " tjwpdf))
  (delete-file tjwps)
  (set-face-background 'default "ivory")
  )
(defun fpcr () "\nPrint region in color to a .pdf file."
  (interactive)
  (set-variable 'ps-print-color-p t)
  (set-face-background 'default "white")
  (set-face-background 'region "white")
  (set-variable 'tjwps (concat (eval 'mydocumentsdir) "/printouts/" (file-name-nondirectory (buffer-file-name)) ".ps"))
  (set-variable 'tjwpdf (concat (eval 'mydocumentsdir) "/printouts/" (file-name-nondirectory (buffer-file-name)) ".pdf"))
  (ps-print-region-with-faces (point) (mark) tjwps)
  (shell-command (concat "ps2pdf " tjwps " " tjwpdf))
  (delete-file tjwps)
  (set-face-background 'region "yellow")
  (set-face-background 'default "ivory")
  )


(defun pb () "\nPrint buffer in black and white."
  (interactive)
  (setenv "PRINTER" zippybwprinter)
  (set-variable 'ps-print-color-p nil)
;  (setq ps-bold-faces
;        (quote (font-lock-function-name-face font-lock-builtin-face font-lock-keyword-face font-lock-warning-face font-lock-xml-tag-name-face)))
;  (setq ps-italic-faces
;        (quote (font-lock-comment-face font-lock-string-face)))
;  (setq ps-underlined-faces (quote (nil)))
;;notworkingrightsap8  (ps-print-buffer-with-faces)
    (ps-print-buffer)
  )
(defun pr () "\nPrint region in black and white."
  (interactive)
  (setenv "PRINTER" zippybwprinter)
  (set-variable 'ps-print-color-p nil)
  (setq ps-bold-faces
        (quote (font-lock-function-name-face font-lock-builtin-face font-lock type-face font-lock-keyword-face font-lock-warning-face font-lock-xml-tag-name-face)))
  (setq ps-italic-faces
        (quote (font-lock-comment-face font-lock-string-face)))
  (ps-print-region-with-faces (point) (mark) nil)
  )



;;-----------------------------------------------------------------------
;; gdb-mode stuff from Ik Yoo
;;-----------------------------------------------------------------------
(setq gdb-font-lock-keywords
      (append '((" in \\([^:]+::[^ \(]+\\)[ \(].*$" 1 font-lock-keyword-face t)
                ("^#0[ ]+\\([^:]+::[^ ]+\\)" 1 font-lock-keyword-face t)
                (" at \\(.+\\)$" 1 font-lock-reference-face t)
                ("\"[^\"]*\"" 0 font-lock-string-face t)
                ("\\([a-zA-Z_]+\\) =" 1 font-lock-variable-name-face t)
                )))
(add-hook 'gdb-mode-hook
          (lambda ()
            (setq font-lock-defaults '(gdb-font-lock-keywords t t))
            (turn-on-font-lock)))


;(setq gnus-select-method '(nntp "discuss"))


;;-------------------------------------------------------------------------
;; Matlab stuff from mathworks
;;-------------------------------------------------------------------------
(autoload 'matlab-mode "matlab" "Enter MATLAB mode." t)
(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
(autoload 'matlab-shell "matlab" "Interactive MATLAB mode." t)

;;-------------------------------------------------------------------------
;; Aquamacs stuff for Macintosh
;;-------------------------------------------------------------------------
;; (setq mac-command-modifier 'meta)

;;-------------------------------------------------------------------------
;; Personal Emacs Documentation:
;;-------------------------------------------------------------------------

;; list-command-history shows history of minibuffer commands for that buffer
