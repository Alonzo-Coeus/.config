;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Alonzo Coeus"
      user-mail-address "Alonzo.Coeus@mail.com")

(setq auth-sources '("~/.authinfo"))

(setq socks-server (list "Default Proxy" "localhost" 9050 5))
(setq socks-noproxy '("localhost"))
(require 'socks)

(setq read-process-output-max (* 1024 1024))
;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

(when (display-graphic-p) (setq doom-theme 'doom-solarized-dark))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
        "bibtex %b"
        "pdflatex -interaction nonstopmode -output-directory %o %f"
        "pdflatex -interaction nonstopmode -output-directory %o %f"))


;; Haskell
(require 'lsp-haskell)
(require 'nix-sandbox)
(setq default-nix-wrapper
      (lambda (args)
        (append
         (append (list "nix-shell" "-I" "." "--command" )
                 (list (mapconcat 'identity args " "))
                 )
         (list (nix-current-sandbox))
         )
        )
      )
(setq haskell-nix-wrapper
      (lambda (args)
        (apply default-nix-wrapper (list (append args (list "--ghc-option" "-Wwarn"))))
        )
      )

(setq haskell-process-wrapper-function haskell-nix-wrapper)
(setq haskell-process-type 'cabal-repl)


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(global-set-key [f1] 'eshell)

(defalias 'vi 'evil-edit)

(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  :bind
  ("C-<prior>" . centaur-tabs-backward)
  ("C-<next>" . centaur-tabs-forward))

(defconst freenode-irc "chat.freenode.net")
;;(defconst freenode-irc "ajnvpgl6prmkb7yktvue6im5wiedlz2w32uhcwaamdiecdrfpwwgnlqd.onion")

(use-package erc
  :delight "ε "

  :custom-face
  (erc-action-face ((t (:foreground "#8fbcbb"))))
  (erc-error-face ((t (:foreground "#bf616a"))))
  (erc-input-face ((t (:foreground "#ebcb8b"))))
  (erc-notice-face ((t (:foreground "#ebcb8b"))))
  (erc-timestamp-face ((t (:foreground "#a3be8c"))))


  :custom
  (erc-autojoin-channels-alist '((freenode-irc
                                  "#nixos" "#bash" "#haskell" "#emacs"
                                  "#xmonad" "#latex" "#linux" "#python")))
  (erc-autojoin-timing 'ident)
  (erc-fill-function 'erc-fill-static)
  (erc-fill-static-center 22)
  (erc-header-line-format "%n on %t (%m)")
  (erc-hide-list '("JOIN" "PART" "QUIT"))
  (erc-join-buffer 'bury)
  (erc-kill-buffer-on-part t)
  (erc-kill-queries-on-quit t)
  (erc-kill-server-buffer-on-quit t)
  (erc-lurker-hide-list '("JOIN" "PART" "QUIT"))
  (erc-lurker-threshold-time 43200)
  (erc-prompt-for-nickserv-password nil)
  (erc-server-reconnect-attempts 5)
  (erc-server-reconnect-timeout 3)
  (erc-track-exclude-types '("JOIN" "MODE" "NICK" "PART" "QUIT"
                             "324" "329" "332" "333" "353" "477")))

(if (file-exists-p "~/.config/doom.d/extensions/erc-sasl/erc-sasl.el")
    (use-package erc-sasl
      :load-path "extensions/erc-sasl/"
      :after erc
      :config
      (add-to-list 'erc-sasl-server-regexp-list "*.onion")
    ;;(setq erc-server-connect-function 'socks-open-network-stream)
      (defun erc-login ()
        "Perform user authentication at the IRC server."
        (erc-log (format "login: nick: %s, user: %s %s %s :%s"
                         (erc-current-nick)
                         (user-login-name)
                         (or erc-system-name (system-name))
                         erc-session-server
                         erc-session-user-full-name))
        (if erc-session-password
            (erc-server-send (format "PASS %s" erc-session-password))
          (message "Logging in without password"))
        (when (and (featurep 'erc-sasl) (erc-sasl-use-sasl-p))
          (erc-server-send "CAP REQ :sasl"))
        (erc-server-send (format "NICK %s" (erc-current-nick)))
        (erc-server-send
         (format "USER %s %s %s :%s"
                 ;; hacked - S.B.
                 (if erc-anonymous-login erc-email-userid (user-login-name))
                 "0" "*"
                 erc-session-user-full-name))
        (erc-update-mode-line))))


(defun irc ()
  "Connect to IRC."
  (interactive)
  (when (y-or-n-p "IRC? ")
    (erc :server freenode-irc :port 6667 :nick "AlonzoC")))

(use-package org-roam
      :ensure t
      :hook
      (after-init . org-roam-mode)
      :custom
      (org-roam-directory "~/slip-box")
      :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n g" . org-roam-graph))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))
              (("C-c n I" . org-roam-insert-immediate))))
