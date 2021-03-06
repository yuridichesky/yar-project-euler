;; 03 Apr. 2008
;; 
;; Yuri Arapov <yuridichesky@gmail.com>
;; 
;; Project Euler
;; 
;; http://projecteuler.net/index.php?section=problems&id=55
;;
;; Problem 55
;; 24 October 2003
;;
;; If we take 47, reverse and add, 47 + 74 = 121, which is palindromic.
;;
;; Not all numbers produce palindromes so quickly. For example,
;;
;; 349 + 943 = 1292,
;; 1292 + 2921 = 4213
;; 4213 + 3124 = 7337
;;
;; That is, 349 took three iterations to arrive at a palindrome.
;;
;; Although no one has proved it yet, it is thought that some numbers, like
;; 196, never produce a palindrome. A number that never forms a palindrome
;; through the reverse and add process is called a Lychrel number. Due to the
;; theoretical nature of these numbers, and for the purpose of this problem, we
;; shall assume that a number is Lychrel until proven otherwise. In addition
;; you are given that for every number below ten-thousand, it will either (i)
;; become a palindrome in less than fifty iterations, or, (ii) no one, with all
;; the computing power that exists, has managed so far to map it to a
;; palindrome. In fact, 10677 is the first number to be shown to require over
;; fifty iterations before producing a palindrome: 4668731596684224866951378664
;; (53 iterations, 28-digits).
;;
;; Surprisingly, there are palindromic numbers that are themselves Lychrel
;; numbers; the first example is 4994.
;;
;; How many Lychrel numbers are there below ten-thousand?
;;
;; NOTE: Wording was modified slightly on 24 April 2007 to emphasise the
;; theoretical nature of Lychrel numbers.
;;
;; Answer: 249
;;
;; FIXME: bruteforce
;;      


(load "range.scm")


(define (lychrel-number? n)
;; test if given number is lychrel or not
;; in 50 iterations of reverse-and-add
;;
  (let loop ((iter 1)
             (n (reverse-and-add (number->digits n))))
    (cond ((> iter 50)
           #t)

          ((palindrome? n)
           #f)

          (else
            (loop (+ iter 1) (reverse-and-add n))))))


(define (palindrome? n)
;; check if number n is palindromic
;;
  (let ((half-len (quotient (length n) 2)))
    (equal? (list-head n half-len)
            (list-head (reverse n) half-len))))


(define (reverse-and-add n)
;; reverse number n and add result to n.
;;
;; n is a list of digits, lower digits first
;;
;; return list of digits, lower digits first.
;;
  (let loop ((n n)
             (rn (reverse n))
             (shift 0))
    (if (null? n)
      (if (zero? shift)
        '()
        (cons shift '()))
      (let ((s (+ (car n) (car rn) shift)))
        (cons (remainder s 10) (loop (cdr n) 
                                     (cdr rn) 
                                     (quotient s 10)))))))


(define (number->digits n)
;; 123 -> (3 2 1)
;; i.e. lower digits first
;;
  (if (< n 10)
    (cons n '())
    (cons (remainder n 10) (number->digits (quotient n 10)))))


(define (p55)
  (length (filter lychrel-number? (range 1 9999))))


;; end of file
