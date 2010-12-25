;; 2010-12-23
;;
;; Project Euler
;;
;; Problem 114
;; 17 February 2006
;;
;; A row measuring seven units in length has red blocks with a minimum length
;; of three units placed on it, such that any two red blocks (which are allowed
;; to be different lengths) are separated by at least one black square. There
;; are exactly seventeen ways of doing this.
;;
;; ooooooo
;;
;; xxxoooo  xxxxooo  xxxxxoo  xxxxxxo  xxxxxxx
;; oxxxooo  oxxxxoo  oxxxxxo  oxxxxxx
;; ooxxxoo  ooxxxxo  ooxxxxx
;; oooxxxo  oooxxxx
;; ooooxxx
;;
;; xxxoxxx
;;
;; ('o' denotes black cell, 'x' denotes red one)
;;                                                      
;; How many ways can a row measuring fifty units in length be filled?
;;
;; NOTE: Although the example above does not lend itself to the possibility, in
;; general it is permitted to mix block sizes. For example, on a row measuring
;; eight units in length you could use red (3), black (1), and red (4).
;;
;; Answer: 16475640049
;;


(defun p114-int (n)

  (let ((memo (make-array (1+ n) :initial-element nil)))

    (defun memo-ref (n)   (aref memo n))
    (defun memo-set (n x) (setf (aref memo n) x) x)

    (defun helper (n)
      (cond 
        ((< n 3) 0)   ;; nothing
        ((= n 3) 2)   ;; xxx and ooo
        (t
          (or (memo-ref n)
              (memo-set 
                n 
                (labels ((iter (left len acc)
                               (cond 
                                 ((> (+ left len) n) (iter 0 (1+ len) acc))
                                 ((= len n)          (+ 2 acc))
                                 (t
                                   (iter
                                     (1+ left)
                                     len
                                     (+ acc (max 1 (helper (- n (+ left len 1))))))))))
                  (iter 0 3 0)))))))
    (helper n)))


(defun p114 () (p114-int 50))


;; end of file
;; vim: ts=4 sw=4 et