;; 2010-02-05
;; 
;; Yuri Arapov <yuridichesky@gmail.com>
;; 
;; Project Euler
;;
;; http://projecteuler.net/index.php?section=problems&id=61
;;
;; Problem 61
;; 16 January 2004
;;
;; Triangle, square, pentagonal, hexagonal, heptagonal, and octagonal numbers
;; are all figurate (polygonal) numbers and are generated by the following
;; formulae:
;;
;; Triangle             P3,n=n(n+1)/2           1, 3,  6, 10, 15, ...
;; Square               P4,n=n^2                1, 4,  9, 16, 25, ...
;; Pentagonal           P5,n=n(3n-1)/2          1, 5, 12, 22, 35, ...
;; Hexagonal            P6,n=n(2n-1)            1, 6, 15, 28, 45, ...
;; Heptagonal           P7,n=n(5n-3)/2          1, 7, 18, 34, 55, ...
;; Octagonal            P8,n=n(3n-2)            1, 8, 21, 40, 65, ...
;;
;; The ordered set of three 4-digit numbers: 8128, 2882, 8281, has three
;; interesting properties.
;;
;; The set is cyclic, in that the last two digits of each number is the first
;; two digits of the next number (including the last number with the first).
;; Each polygonal type: triangle (P3,127=8128), square (P4,91=8281), and
;; pentagonal (P5,44=2882), is represented by a different number in the set.
;; This is the only set of 4-digit numbers with this property.
;; Find the sum of the only ordered set of six cyclic 4-digit numbers for which
;; each polygonal type: triangle, square, pentagonal, hexagonal, heptagonal,
;; and octagonal, is represented by a different number in the set.
;;
;; Answer: 28684
;;
;; FIXME: Too much code?  Any possibility to make it more terse?
;;


;; Polygonal numbers.
;;
(define (p3 n)  (/ (* n (+ n 1 ) ) 2))
(define (p4 n)  (* n n))
(define (p5 n)  (/ (* n (- (* 3 n) 1)) 2))
(define (p6 n)  (* n (- (* 2 n) 1)))
(define (p7 n)  (/ (* n (- (* 5 n) 3)) 2))
(define (p8 n)  (* n (- (* 3 n) 2)))


;; Generate list of 4-digit polygonal numbers.
;;
(define (gen-4digit-p-numbers p-fn)
  (let loop ((i 1)
             (res '()))
    (let ((x (p-fn i)))
      (if (> x 9999)
        (reverse res)
        (loop (+ 1 i) (if (< x 1000) res (cons x res)))))))


;; Turn list of numbers into bitvector.
;;
(define (numbers->bitvector max-num ls)
  (let ((bv (make-bitvector (+ 1 max-num) #f)))
    (for-each (lambda (n) (bitvector-set! bv n #t)) ls)
    bv))


;; Memoize each of polygonal number in certain bitvector.
;;
(define p3-bv (numbers->bitvector 9999 (gen-4digit-p-numbers p3)))
(define p4-bv (numbers->bitvector 9999 (gen-4digit-p-numbers p4)))
(define p5-bv (numbers->bitvector 9999 (gen-4digit-p-numbers p5)))
(define p6-bv (numbers->bitvector 9999 (gen-4digit-p-numbers p6)))
(define p7-bv (numbers->bitvector 9999 (gen-4digit-p-numbers p7)))
(define p8-bv (numbers->bitvector 9999 (gen-4digit-p-numbers p8)))


;; Test the number for being polygonal (using corresponding bitvector).
;;
(define (p? bv n) (and (<= 1000 n 9999) (bitvector-ref bv n)))


;; Test number for being polygonal.
;;
(define (p3? n) (p? p3-bv n))
(define (p4? n) (p? p4-bv n))
(define (p5? n) (p? p5-bv n))
(define (p6? n) (p? p6-bv n))
(define (p7? n) (p? p7-bv n))
(define (p8? n) (p? p8-bv n))


;; Combine two 2-digit numbers xx and yy to produce 4-digit number xxyy.
;;
(define (combine xx yy) (+ (* 100 xx) yy))


;; Make list of 2-digit numbers that make a polygonal number 
;; by combining with given xx number:
;;   (make-plist 12) -> (25 47 75 81 88 96)
;;     1225 is p3,
;;     1247 is p5,
;;     1275 is p3,
;;     etc.
;;
(define (make-plist xx)
  (let loop ((yy 10)
             (res '()))
    (if (> yy 99)
      (reverse res)
      (loop (+ yy 1)
            (if ((lambda (x)
                   (any (lambda (p) (p x)) (list p3? p4? p5? p6? p7? p8?)))
                 (combine xx yy))
              (cons yy res)
              res)))))


;; Make p-list for each number in 0..99 range (first 10 numbers
;; are ignored but are kept to simplify code).
;;
(define buddies (list->vector (map make-plist (iota 100))))


;; Return p-list for given number.
;;
(define (get-buddies n) (vector-ref buddies n))


;; Return type of polygonal number (test function from the list) given pair
;; represents.
;; Return false if no such function found.
;;
(define (find-p xx yy avail-p) 
  ((lambda (n)
     (find (lambda (p) (p n)) avail-p))
   (combine xx yy)))


;; Turn list of 2-digit numbers into list of 4-digit numbers
;; by combining each two consecutive numbers in the list 
;; plus combining last and first numbers too.
;;
(define (make-res-list ls)
  (define (make-n ls) (combine (car ls) (cadr ls)))
  (let loop ((ls (cons (last ls) ls)))
    (if (null? (cddr ls))
      (list (make-n ls))
      (cons (make-n ls) (loop (cdr ls))))))


;; Solve problem 61.
;;
(define (p61)

  (define (test-n n avail-p res)
    (let loop ((b (get-buddies n)))
      (cond ((null? b)
             #f)
            ((null? avail-p)
             (if (= n (last res))
               res
               #f))
            (else
              (let ((p (find-p n (car b) avail-p)))
                (if p
                  (or (test-n (car b)
                              (delete p avail-p)
                              (cons n res))
                      (loop (cdr b)))
                  (loop (cdr b))))))))

  (let loop ((n 10))
    (if (= n 100)
      #f
      (let ((r (test-n n (list p3? p4? p5? p6? p7? p8?) '())))
        (if r
          (let ((rr (make-res-list r)))
            (format #t "~a -> ~a -> ~a\n" 
                    r 
                    rr
                    (apply + rr))
            #t)
          (loop (+ 1 n)))))))


;; end of file
