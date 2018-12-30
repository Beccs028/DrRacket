;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname immigration) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
;;
;; *****************************************
;;   Mo Jie (Rebecca) Ma (20772123)
;;   CS 135 Fall 2018
;;   Assignment 02, Question 2
;; *****************************************
;;

;; ==== Question 2a ========================

;; Constant for a score of Zero:
(define no-score 0)

;; Constants for age-score:
(define max-high-scoring-age       29)
(define min-high-scoring-age       20)
(define second-high-scoring-age    19)
(define third-high-scoring-age     18)
(define max-decreasing-scoring-age 48)
(define min-decreasing-scoring-age 30)

;; Constants for education-score:
(define education-highschool     28)
(define education-undergraduate 112)
(define education-graduate      126)

;; Constants for language-score:
(define max-score 116)
(define mid-score  88)
(define min-score  64)

;; Constants for work-xp-score:
(define no-work-xp      0)
(define little-work-xp 35)
(define some-work-xp   56)
(define max-work-xp    70)

;; Constants for job-offer:
(define yes-offer 200)
(define no-offer    0)

;; Examples:
(check-expect (pr-cec-score 45 'graduate 9 3 true) 518)
(check-expect (pr-cec-score 25 'undergraduate 2 0 false) 212)

;; (age-score age) calculates the points earned by an applicant for their age
;;   based on [age]
;; Example:
(check-expect (age-score 32) 85)
(define (age-score age)
  (cond
    [(and (<= age max-high-scoring-age )(>= age min-high-scoring-age )) 100]
    [(and (<= age max-decreasing-scoring-age)
          (>= age min-decreasing-scoring-age))
     (- 100 (* (- age 29) 5))]
    [(= age second-high-scoring-age) 95]
    [(= age third-high-scoring-age) 90]
    [else no-score]))

;; (education-score education) calculates the points earned by an applicant
;;   based on their [education] level
;; Example:
(check-expect (education-score 'highschool) education-highschool)
(define (education-score education)
  (cond
    [(symbol=? education 'highschool) education-highschool]
    [(symbol=? education 'undergraduate) education-undergraduate]
    [(symbol=? education 'graduate) education-graduate]))

;; (language-score language) calculates the points earned by an applicant for
;;   their profficiency in language based on [language]
;; Example:
(check-expect (language-score 8) mid-score)
(define (language-score language)
  (cond
    [(>= language 9) max-score]
    [(= language 8) mid-score]
    [(= language 7) min-score]
    [else no-score]))

;; (work-xp-score work-xp) calculates the points earned by an applicant for
;;   their work experience based on [work-xp]
;; Example:
(check-expect (work-xp-score 3) some-work-xp)
(define (work-xp-score work-xp)
 (cond
    [(= work-xp 0) no-work-xp]
    [(= work-xp 1) little-work-xp]
    [(or (= work-xp 2)(= work-xp 3)) some-work-xp]
    [(>= work-xp 4) max-work-xp]))

;; (job-offer offer) calculates the points earned by an applicant based on
;;   whether or not they have a job [offer]
;; Example:
(check-expect (job-offer true) yes-offer)
(define (job-offer offer)
  (cond
    [(equal? offer true) yes-offer]
    [(equal? offer false) no-offer]))

;; (pr-csc-score age education language work-xp job-offer) calculates the score
;;    of an applicant applying for permanent residency in Canada based on the
;;    five components [age education language work-xp job-offer]
;; requires: age > 0
;;           education = 'highschool or 'undergraduate or 'graduate
;;           1 <= language <= 10
;; pr-csc-score: Nat Sym Nat Nat Bool -> Int

(define (pr-cec-score age education language work-xp offer)
  (+ (age-score age)
     (education-score education)
     (language-score language)
     (work-xp-score work-xp)
     (job-offer offer)))

;; Tests:
(check-expect (pr-cec-score 20 'graduate 10 0 true) 542)
(check-expect (pr-cec-score 27 'undergraduate 9 1 false) 363)
(check-expect (pr-cec-score 29 'highschool 8 2 true) 472)
(check-expect (pr-cec-score 30 'graduate 7 3 false) 341)
(check-expect (pr-cec-score 35 'undergraduate 10 4 true) 568)
(check-expect (pr-cec-score 48 'highschool 9 9 false) 219)
(check-expect (pr-cec-score 18 'graduate 8 5 true) 574)
(check-expect (pr-cec-score 19 'undergraduate 7 0 false) 271)
(check-expect (pr-cec-score 11 'highschool 3 3 true) 284)
(check-expect (pr-cec-score 49 'graduate 7 5 false) 260)
(check-expect (pr-cec-score 64 'undergraduate 4 9 true) 382)

;; ==== Question 2b ========================

;; (pr-cec-eligible? age education language work-xp job-offer) checks whether
;;    the given applicant is eligible to apply for the CEC category based on the
;;    five components [age education language work-xp job-offer]
;; requires: education = 'highschool or 'undergraduate or 'graduate
;;           1 <= language <= 10
;; pr-csc-eligible?: Nat Sym Nat Nat Bool -> Num

;; Examples:
(check-expect (pr-cec-eligible? 69 'graduate 3 6 true) true)
(check-expect (pr-cec-eligible? 96 'highschool 8 0 false) false)

(define (pr-cec-eligible? age education language work-xp offer)
  (and (>= (+ (age-score age)
              (education-score education)
              (language-score language)
              (work-xp-score work-xp)
              (job-offer offer)) 350)
       (>= work-xp 1)))

;; Tests:
(check-expect (pr-cec-eligible? 42 'highschool 1 0 false) false)
(check-expect (pr-cec-eligible? 15 'graduate 10 3 true) true)
(check-expect (pr-cec-eligible? 18 'undergraduate 9 1 false) true)
