;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname bonus) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
;;
;; *****************************************
;;   Mo Jie Ma (20772123)
;;   CS 135 Fall 2018
;;   Assignment 02, Bonus question
;; *****************************************
;;

;; ==== Bonus question ========================

;; Constants for the Day of the Week:
(define Saturday   0)
(define Sunday     1)
(define Monday     2)
(define Tuesday    3)
(define Wednesday  4)
(define Thursday   5)
(define Friday     6)

;; (record-day date) indexes the day of the month
;;   from the provided [date]
;; record-day: Nat -> Nat
;; requires: date >= 17530101
;;           date must be an 8-digit number
;; Example:
(check-expect (record-day 20080930) 30)
(define (record-day date)
  (remainder date 100))

;; (record-month date) indexes the month
;;   from the provided [date]
;; record-month: Nat -> Nat
;; requires: date >= 17530101
;;           date must be an 8-digit number
;; Example:
(check-expect (record-month 19760525) 5)
(define (record-month date)
  (quotient (remainder date 10000) 100))

;; (set-month date) sets the correct value of
;;    for the month (January is 13; February is 14)
;;    based on [date]
;; set-month: Nat -> Nat
;; requires: date >= 17530101
;;           date must be an 8-digit number
;; Example:
(check-expect (set-month 20340112) 13)
(check-expect (set-month 12091107) 11)
(define (set-month date)
  (cond
    [(= (record-month date) 1) 13 ]
    [(= (record-month date) 2) 14]
    [else (record-month date)]))

;; (record-year date) indexes and sets the year (the year
;;   must be one less if the month is January or February)
;;   from the provided [date], also based on (record-month date)
;; record-year: Nat -> Nat
;; requires: date >= 17530101
;;           date must be an 8-digit number
;; Example:
(check-expect (record-year 20090417) 2009)
(check-expect (record-year 19840213) 1983)
(define (record-year date)
  (cond
    [(= (record-month date) 1) (- (quotient date 10000) 1)]
    [(= (record-month date) 2) (- (quotient date 10000) 1)]
    [else (quotient date 10000)]))

;; (record-year-of-century date) records the year of the century
;;   from the provided [date], also based on (record-year date)
;; record-year-of-century: Nat -> Nat
;; requires: date >= 17530101
;;           date must be an 8-digit number
;; Example:
(check-expect (record-year-of-century 20040305) 4)
(define (record-year-of-century date)
  (remainder (record-year date) 100))

;; (record-century date) records the century
;;   from the provided [date], also based on (record-year date)
;; record-century: Nat -> Nat
;; requires: date >= 17530101
;;           date must be an 8-digit number
;; Example:
(check-expect (record-century 18670914) 18)
(define (record-century date)
  (quotient (record-year date) 100))

;; (zellers-congruence date) calculates the numerical value
;;    of the day of the week based on [date], and the functions
;;    listed above
;; zellers-congruence: Nat -> Nat
;; requires: date >= 17530101
;;           date must be an 8-digit number
;; Example:
(check-expect (zellers-congruence 20180928) 6)
(check-expect (zellers-congruence 20180925) 3)
(define (zellers-congruence date)      
  (modulo (+ (record-day date)
             (floor (/ (* (+ (set-month date) 1) 13) 5))
             (record-year-of-century date)
             (floor (/ (record-year-of-century date) 4))
             (floor (/ (record-century date) 4))
             (* 5 (record-century date))) 7))

;; (date->day-of-week date) returns the actual day of
;;    of the week based on [date], also based on (zellers-congruence)
;; date->day-of-week: Nat -> Sym
;; requires: date >= 17530101
;;           date must be an 8-digit number
;; Example:
(check-expect (date->day-of-week 18670701) 'Monday)

(define (date->day-of-week date)
  (cond
    [(= (zellers-congruence date) Sunday) 'Sunday]
    [(= (zellers-congruence date) Monday) 'Monday]
    [(= (zellers-congruence date) Tuesday) 'Tuesday]
    [(= (zellers-congruence date) Wednesday) 'Wednesday]
    [(= (zellers-congruence date) Thursday) 'Thursday]
    [(= (zellers-congruence date) Friday) 'Friday]
    [(= (zellers-congruence date) Saturday) 'Saturday]))

;; Tests:
(check-expect (date->day-of-week 20131201)'Sunday)
(check-expect (date->day-of-week 20000107)'Friday)
(check-expect (date->day-of-week 19851015)'Tuesday)          
(check-expect (date->day-of-week 19180227)'Wednesday) 
(check-expect (date->day-of-week 19690707)'Monday)
(check-expect (date->day-of-week 19450607)'Thursday)             
(check-expect (date->day-of-week 20130316)'Saturday)
              
;; Works Cited:
;; Zeller's congruence: 2017. https://en.wikipedia.org/wiki/Zeller's_congruence.
;; Accessed: 2018-09-25.













 
