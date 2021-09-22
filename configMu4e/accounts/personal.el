(add-to-list 'mu4e-contexts
(make-mu4e-context
  :name "personal"
  :match-func (lambda (msg)
                (when msg
                  (mu4e-message-contact-field-matches msg
                     :to "oscarvarto@pm.me")))
  :vars '((user-mail-address                . "oscarvarto@pm.me")
          (message-sendmail-extra-arguments . ("-a" "personal"))
          (mu4e-sent-messages-behavior      . sent)
          (mu4e-drafts-folder               . "/personal/Drafts")
          (mu4e-trash-folder                . "/personal/Trash")
          (mu4e-sent-folder                 . "/personal/Sent")
          (mu4e-maildir-shortcuts           . (("/personal/INBOX" . ?i)
                                               ("/personal/Drafts"         . ?d)
                                               ("/personal/Sent" . ?s)))
          (user-full-name                   . "Oscar Vargas Torres"))))
