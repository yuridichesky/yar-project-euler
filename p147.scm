;; Tue Mar 13 17:09:09 MSK 2012
;;
;; Project Euler
;;
;; http://projecteuler.net/problem=147
;;
;; Problem 147
;; 31 March 2007
;;
;; In a 3x2 cross-hatched grid, a total of 37 different rectangles could be
;; situated within that grid as indicated in the sketch.
;;
;;                            (nice drawing here)
;;
;; There are 5 grids smaller than 3x2, vertical and horizontal dimensions being
;; important, i.e. 1x1, 2x1, 3x1, 1x2 and 2x2. If each of them is
;; cross-hatched, the following number of different rectangles could be
;; situated within those smaller grids:
;;
;; 1x1:  1
;; 2x1:  4
;; 3x1:  8
;; 1x2:  4
;; 2x2: 18
;;
;; Adding those to the 37 of the 3x2 grid, a total of 72 different rectangles
;; could be situated within 3x2 and smaller grids.
;;
;; How many different rectangles could be situated within 47x43 and smaller
;; grids?
;;
;; Answer:
;;


(define (with-range fn init from to)
  (let loop ((from from)
             (res init))
    (if (> from to) res
      (loop (1+ from) (fn from res)))))


(define (count-strait-rects w h)
  (/ (* h (1+ h) w (1+ w)) 4))


(define (count-all-strait-rects w h)
  (with-range
    (lambda (w res)
      (+ res (with-range
               (lambda (h res)
                 (+ res (count-strait-rects w h)))
               0
               1
               h)))
      0
      1
      w))


;; end of file
;; vim: ts=4 sw=4 et