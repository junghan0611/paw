;;; paw-android.el -*- lexical-binding: t; -*-

(defcustom paw-eudic-android-program "com.eusoft.eudic"
  "The Eudic android program."
  :type 'string
  :group 'paw)

(defun paw-eudic-search-details (&optional word)
  "Call `paw-eudic-android-program' in termux to search for WORD."
  (interactive)
  (call-process-shell-command
   (format "termux-am start -a android.intent.action.SEND --es android.intent.extra.TEXT \"%s\" -t text/plain %s"
           (cond ((stringp word) word)
                 ((use-region-p)
                  (replace-regexp-in-string "[ \n]+" " " (replace-regexp-in-string "^[ \n]+" "" (buffer-substring-no-properties (region-beginning) (region-end)))))
                 (t (current-word t t)))
           paw-eudic-android-program)))

(defun paw-android-browse-url (url)
  "Open given URL in Termux."
  (interactive "sEnter the URL: ")
  (if (string-match-p "^http\\(s\\)?://[^ \n]*$" url)
      (call-process-shell-command (format "termux-open-url \"%s\"" url))
    (message "Invalid URL. Please enter a URL that begins with http://")))


(provide 'paw-android)
