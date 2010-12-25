;; Project Euler
;;
;; http://projecteuler.net/index.php?section=problems&id=12
;;
;; Problem 12
;; 08 March 2002
;;
;; The sequence of triangle numbers is generated by adding the natural numbers.
;; So the 7th triangle number would be 1 + 2 + 3 + 4 + 5 + 6 + 7 = 28. The first
;; ten terms would be:
;;
;; 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
;;
;; Let us list the factors of the first seven triangle numbers:
;;
;;       1: 1
;;       3: 1,3
;;       6: 1,2,3,6
;;      10: 1,2,5,10
;;      15: 1,3,5,15
;;      21: 1,3,7,21
;;      28: 1,2,4,7,14,28
;;
;; We can see that the 7th triangle number, 28, is the first triangle number to
;; have over five divisors.
;;
;; Which is the first triangle number to have over five-hundred divisors?
;;
;; Answer: 76576500
;;


(define (divider? n d) (zero? (remainder n d)))


;; Return list of factors of given n:
;;   (factorize (* 64 123)) -> (2 2 2 2 2 2 3 41)
;;
(define (factorize n)
  (let loop ((n   n)
             (d   2)
             (res '()))
    (cond ((> (* d d) n)
           (reverse (if (< 1 n) (cons n res) res)))
          ((divider? n d)
           (loop (quotient n d) d (cons d res)))
          (else
            (loop n (if (= 2 d) 3 (+ 2 d)) res)))))


;; Pack factorization: make list of factors and their powers:
;;   (pack-factorization (factorize (* 64 123))) -> ((2 . 6) (3 . 1) (41 . 1))
;;
(define (pack-factorization s)
  (define (add d pow res) (cons (cons d pow) res))
  (let loop ((d    (car s))
             (pow  1)
             (s    (cdr s))
             (res  '()))
    (cond ((null? s)
           (reverse (add d pow res)))
          ((= d (car s))
           (loop d (1+ pow) (cdr s) res))
          (else
            (loop (car s) 1 (cdr s) (add d pow res))))))


;; Return number of divisors of given n.
;;
;; See:
;;   http://primes.utm.edu/glossary/page.php?sort=Tau
;;
;;            F
;;            _
;;   Let n = | | f ^ p    -- factorization of the n
;;            i   i   i
;;
;;   So number of divisors of the n is:
;;
;;        F
;;        _
;;   D = | | (p + 1)
;;        i    i
(define (number-of-divisors n)
  (apply *
         (map (lambda (x) (1+ (cdr x)))
              (pack-factorization (factorize n)))))


;; Problem 12.
;;
(define (p12)
  (let loop ((n 2)
             (t 3))
    (if (< 500 (number-of-divisors t))
      t
      (loop (1+ n) (+ t (1+ n))))))


;; end of file
;; vim: ts=4 sw=4 et