; ================================================================
; misc settings
(setq user-mail-address "nkhanhtran@cogini.com")
(setq-default case-fold-search t)
(set-language-environment "UTF-8")
(setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))
(tool-bar-mode 0)
(menu-bar-mode 0)
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized))))) ;; start maximized
(show-paren-mode t)
(setq evil-move-cursor-back nil)
; remember cursor position
(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)
(require 'saveplace)


; ================================================================
; package manager
(require 'package)
(dolist (source '(("marmalade" . "http://marmalade-repo.org/packages/")
                  ("elpa" . "http://tromey.com/elpa/")
                  ("melpa" . "http://melpa.milkbox.net/packages/")
                  ))
  (add-to-list 'package-archives source t))
(package-initialize)


; ================================================================
; autoload packages at start
(when (not package-archive-contents)
  (package-refresh-contents))
(defvar nkhanhtran/elpa-packages
  '(
    ; evil-mode
    evil
    evil-tabs
    ; Color theme
    color-theme
    color-theme-solarized
    ; IDE plugins
    flycheck
    ; Lisp Mode
    elisp-slime-nav
    ; Web Mode
    web-mode
    ; Dired dired-details
    dired-details+
    dired+
    dired-rainbow
    ; misc plugins
    nyan-mode
    smooth-scrolling
  ))
(dolist (p nkhanhtran/elpa-packages)
  (when (not (package-installed-p p))
    (package-install p)))


; ================================================================
; Set theme for emacs
;(load-theme 'solarized-light t)
(load-theme 'solarized-dark t)
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("green" box))
(setq evil-visual-state-cursor '("orange" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))


; ================================================================
; evil-mode
(require 'evil)
(evil-mode 1)
(global-evil-tabs-mode t)


; ================================================================
; Lisp Mode
(progn
  (require 'elisp-slime-nav)
  (defun nk-lisp-hook ()
    (elisp-slime-nav-mode)
    (turn-on-eldoc-mode)
    )
  (add-hook 'emacs-lisp-mode-hook 'nk-lisp-hook)
)

; ================================================================
; misc plugins config
; nyan cat
(require 'nyan-mode)
(nyan-mode)
(nyan-start-animation)

; smooth scrolling
(require 'smooth-scrolling)
(setq smooth-scroll-margin 10)
(setq scroll-conservatively 9999
      scroll-preserve-screen-position t)


; ================================================================
; custom keyboard shortcuts
; global keys
(define-key global-map (kbd "RET") 'newline-and-indent)

; evil key
(define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
(define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
(define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
(define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
(define-key evil-normal-state-map (kbd "M-k") (lambda ()
                    (interactive)
                    (evil-scroll-up nil)))
(define-key evil-normal-state-map (kbd "M-j") (lambda ()
                        (interactive)
                        (evil-scroll-down nil)))


; ================================================================
; Web Mode
(defun nk-setup-web ()
  ; enable web-mode
  (web-mode)

  ; localize some variables
  (make-local-variable 'web-mode-code-indent-offset)
  (make-local-variable 'web-mode-markup-indent-offset)
  (make-local-variable 'web-mode-css-indent-offset)

  ; set indentation, can set different indentation level for different code type
  (setq web-mode-code-indent-offset 4)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-markup-indent-offset 2)

  ; enable auto-completion for web-mode
  (setq web-mode-ac-sources-alist
    '(("css" . (ac-source-words-in-buffer ac-source-css-property))
      ("html" . (ac-source-words-in-buffer ac-source-abbrev))
      ("php" . (ac-source-words-in-buffer
                ac-source-words-in-same-mode-buffers
                ac-source-dictionary)))))

(add-to-list 'auto-mode-alist '("\\.php$" . nk-setup-web))
