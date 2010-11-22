;; 24 December 2007
;; 
;; Yuri Arapov <yuridichesky@gmail.com>
;; 
;; Project Euler
;; 
;; http://projecteuler.net/index.php?section=problems&id=2
;; 
;; Problem 2
;; 19 October 2001
;; 
;; Each new term in the Fibonacci sequence is generated by
;; adding the previous two terms. By starting with 1 and 2, the
;; first 10 terms will be:
;; 
;;   1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
;; 
;; Find the sum of all the even-valued terms in the sequence
;; which do not exceed one million.
;; 
;; Answer:
;;      1089154
;;      1089154 (scheme)
;; 
;; Done.
;; 
;; Some useful references:
;;   http://en.wikipedia.org/wiki/Fibonacci_sequence
;;   http://en.wikibooks.org/wiki/Fibonacci_number_program
;;   http://mathworld.wolfram.com/FibonacciNumber.html


(defun p1 ()
  (defun iter (a b acc)
    (if (> b 1000000)
      acc
      (iter b (+ a b)
            (if (evenp b)
              (+ acc b)
              acc))))
  (iter 0 1 0))


;; end of file
