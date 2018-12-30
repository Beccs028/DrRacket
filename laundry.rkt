;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname laundry) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
;;
;; *****************************************
;;   Mo Jie (Rebecca) Ma (20772123)
;;   CS 135 Fall 2018
;;   Assignment 02, Question 3
;; *****************************************
;;

;; ==== Question 3a ========================

;;(acceptable-to-wear/cond? smelly clothing-type days) outputs whether
;;  an item of clothing is acceptable for wearing based on
;;  [smelly clothing-type days]
;; requires: symbol = socks or shirt
;; acceptable-to-wear/cond?: boolean Sym Nat -> boolean

;; Examples:
(check-expect (acceptable-to-wear/cond? true 'socks 2) false)
(check-expect (acceptable-to-wear/cond? false 'shirt 8) true)

(define (acceptable-to-wear/cond? smelly clothing-type days)
  (cond
    [(equal? smelly true) false]
    [(equal? smelly false)
     (cond
       [(symbol=? clothing-type 'socks)
        (cond
          [(>= days 4) false]
          [(< days 4) true])]
       [(symbol=? clothing-type 'shirt)
        (cond
          [(<= days 2) false]
          [(>= days 10) false]
          [else true])])]))

;; Tests:
(check-expect (acceptable-to-wear/cond? true 'shirts 1) false)
(check-expect (acceptable-to-wear/cond? false 'socks 4) false)
(check-expect (acceptable-to-wear/cond? false 'socks 6) false)
(check-expect (acceptable-to-wear/cond? false 'socks 2) true)
(check-expect (acceptable-to-wear/cond? false 'shirt 1) false)
(check-expect (acceptable-to-wear/cond? false 'shirt 2) false)
(check-expect (acceptable-to-wear/cond? false 'shirt 6) true)
(check-expect (acceptable-to-wear/cond? false 'shirt 10) false)
(check-expect (acceptable-to-wear/cond? false 'shirt 15) false)

;; ==== Question 3b ========================

;;(acceptable-to-wear/bool? smelly clothing-type days) outputs whether
;;  an item of clothing is acceptable for wearing based on
;;  [smelly clothing-type days]
;; requires: symbol = socks or shirt
;; acceptable-to-wear/bool?: boolean Sym Nat -> boolean

;; Examples:
(check-expect (acceptable-to-wear/bool? true 'socks 2) false)
(check-expect (acceptable-to-wear/bool? false 'shirt 8) true)

(define (acceptable-to-wear/bool? smelly clothing-type days)
  (and (not smelly)
       (or (and (symbol=? clothing-type 'socks)(< days 4))
           (and (symbol=? clothing-type 'shirt)
                (and (> days 2)(< days 10))))))

;; Tests:
(check-expect (acceptable-to-wear/bool? true 'shirts 1) false)
(check-expect (acceptable-to-wear/bool? false 'socks 4) false)
(check-expect (acceptable-to-wear/bool? false 'socks 6) false)
(check-expect (acceptable-to-wear/bool? false 'socks 2) true)
(check-expect (acceptable-to-wear/bool? false 'shirt 1) false)
(check-expect (acceptable-to-wear/bool? false 'shirt 2) false)
(check-expect (acceptable-to-wear/bool? false 'shirt 6) true)
(check-expect (acceptable-to-wear/bool? false 'shirt 10) false)
(check-expect (acceptable-to-wear/bool? false 'shirt 15) false)
  