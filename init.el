;; Using C-l to clear the buffer in Eshell
(defun eshell-clear-buffer ()
  "Clear terminal"
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))
 (setq eshell-cmpl-compare-entry-function
       (function
	(lambda (left right)
	  (let ((exts completion-ignored-extensions) found)
	    (while exts
	      (if (string-match (concat "\\" (car exts) "$") right)
		  (setq found t exts nil))
	      (setq exts (cdr exts)))
	    (if found
		nil
	      (file-newer-than-file-p left right))))))
(add-hook 'eshell-mode-hook
      '(lambda()
	 (local-set-key (kbd "C-l") 'eshell-clear-buffer)))

;; Something sus from Stack Overflow that doesn't work
(require 'ansi-color)

(defadvice display-message-or-buffer (before ansi-color activate)
  "Process ANSI color codes in shell output."
  (let ((buf (ad-get-arg 0)))
    (and (bufferp buf)
         (string= (buffer-name buf) "*Shell Command Output*")
         (with-current-buffer buf
           (ansi-color-apply-on-region (point-min) (point-max))))))

;; Workgroups config
(add-to-list 'load-path "~/.emacs.d/lisp/")
(require 'workgroups)
(setq wg-prefix-key (kbd "C-c w"))
(workgroups-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(send-mail-function (quote smtpmail-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
