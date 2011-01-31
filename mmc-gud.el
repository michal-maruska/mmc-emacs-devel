(require 'gud)



(global-set-key [(super ?c)]    'gud-cont)
(global-set-key [(super ?t)]    'gud-tbreak)
(global-set-key [(super ?s)]    'gud-step)
(global-set-key [(super ?b)]    'gud-break)
(global-set-key [(super ?n)]   'gud-next)
(global-set-key [(super ?f)]   'gud-finish)


(global-set-key [(control alt ?c)] 'gud-cont)
(global-set-key [(control alt ?t)] 'gud-tbreak)
(global-set-key [(control alt ?s)] 'gud-step)
(global-set-key [(control alt ?b)] 'gud-break)
(global-set-key [(control alt ?n)] 'gud-next)
(global-set-key [(control alt ?\ )] 'gud-next)
(global-set-key [(control alt ?f)] 'gud-finish)


(provide 'mmc-gud)
