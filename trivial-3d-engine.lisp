
;;
;;   _____     _       _       _   _____ ____    _____             _            
;;  |_   _| __(_)_   _(_) __ _| | |___ /|  _ \  | ____|_ __   __ _(_)_ __   ___ 
;;    | || '__| \ \ / / |/ _` | |   |_ \| | | | |  _| | '_ \ / _` | | '_ \ / _ \
;;    | || |  | |\ V /| | (_| | |  ___) | |_| | | |___| | | | (_| | | | | |  __/
;;    |_||_|  |_| \_/ |_|\__,_|_| |____/|____/  |_____|_| |_|\__, |_|_| |_|\___|
;;                                                            |___/             

#|

A simple test to transpose a wonderful little tutorial by Tsoding that demonstrates how
to store data as vectors and use some simple formulas to translate the data and
render the points and lines of a cubed in 3d dimentions.

Tsoding performs the line tutorial in Javascript and I wanted to see what the code wuold
look like in Sketch and learn a little bit about how to render 3d data.

This is my first attempt. 

All comments are welcome. All criticisms and suggestions are even better. 

Original tutorial link: https://www.youtube.com/watch?v=qjWkNZ0SXfo
Tutorial author: Tsoding
Authors GitHub: https://github.com/tsoding

To load the app, in SLY or SLIME run: (ql:quickload :trivial-3d-engine)
When the app compiles it should open up a Sketch window with a spinning cube. If you
close the Sketch window, you can just start another Sketch window with: (trivial-3d-engine:start-app)

|#

(defpackage #:trivial-3d-engine
  (:use #:cl #:sketch)
  (:export #:start-app))

(in-package :trivial-3d-engine)

(defparameter *screen-width* 400)
(defparameter *screen-height* 400)
(defparameter *box-width* 10)
(defparameter *box-height* 10)
(defparameter *x* nil)
(defparameter *y* nil)
(defparameter *fps* 60)
(defparameter *dt* (/ 1 *fps*))
(defparameter *dz* 0.75 )
(defparameter *angle* 0)
(defparameter *p1x* nil)
(defparameter *p1y* nil)
(defparameter *p2x* nil)
(defparameter *p2y* nil)

(defun screenx (x)
  (* (/ (+ x 1) 2) *screen-width*)) 

(defun screeny (y)
  ;; note the - 1 to flip the y-coordinates
  (* (- 1 (/ (+ y 1) 2)) *screen-height*)) 

(defparameter vs
  (vector
   '( :x  0.25 :y  0.25 :z  0.25)
   '( :x -0.25 :y  0.25 :z  0.25)
   '( :x -0.25 :y -0.25 :z  0.25)
   '( :x  0.25 :y -0.25 :z  0.25)

   '( :x  0.25 :y  0.25 :z  -0.25)
   '( :x -0.25 :y  0.25 :z  -0.25)
   '( :x -0.25 :y -0.25 :z  -0.25)
   '( :x  0.25 :y -0.25 :z  -0.25)
   ))

(defparameter fs 
  (vector
   #(0 1 2 3)  
   #(4 5 6 7)
   #(0 4)
   #(1 5)
   #(2 6)
   #(3 7)
   ))

(defun draw-point ()
  (with-pen (make-pen :stroke (hex-to-color "ecc437") :weight 3)
    (rect
     (- (screenx *x*) (/ *box-width* 2 )) ;; x
     (- (screeny *y*) (/ *box-height* 2 )) ;; y
     *box-width*  
     *box-height*)))

(defun draw-line ()
  (with-pen (make-pen :stroke (hex-to-color "d94f00") :weight 3 :weight 3)
    (line 
     ;; point 1
     (screenx *p1x*)
     (screeny *p1y*) 
     ;; point 2
     (screenx *p2x*) 
     (screeny *p2y*) 
     )))

(defun project-p1 (xyz)
  (let ((x (first xyz))
        (y (second xyz))
        (z (third xyz)))
    (setf *p1x* (/ x z))
    (setf *p1y* (/ y z))))

(defun project-p2 (xyz)
  (let ((x (first xyz))
        (y (second xyz))
        (z (third xyz)))
    (setf *p2x* (/ x z))
    (setf *p2y* (/ y z))))

(defun project (xyz)
  (let ((x (first xyz))
        (y (second xyz))
        (z (third xyz)))
    (setf *x* (/ x z))
    (setf *y* (/ y z))))

(defun translate (xyz)
  (let ((x (first xyz))
        (y (second xyz))
        (z (third xyz))
        (result '()))
    (push x result)
    (push y result)
    (push (+ z *dz*) result)
    (reverse result)))

(defun rotate (&key x y z angle)
  (let ((c (cos angle))
        (s (sin angle))
        (result '()))
    (when x (push (- (* x c) (* z s)) result))       
    (when y (push y result))
    (when z (push (+ (* x s) (* z c)) result ))
    (reverse result)))

(defsketch trivial-3d-engine ((title "Trivial 3d Engine")
                              (width *screen-width* )
                              (height *screen-height*))
  ;; set the background color
  ;; --
  (background (rgb 0.2 0.2 0.2))
  
  ;; Uncomment to see live values of variables
  ;; --
  (with-font (make-font :color (hex-to-color "ddd9d0") ) 
    ;; Display values for: *dz*
    (text (format nil "dz: ~a" *dz*) 10 10)
    ;; Display values for (draw-line): P1 and P2 
    (text (format nil "p1x: ~a" *p1x*) 10 40)
    (text (format nil "p1y: ~a" *p1y*) 10 55)
    (text (format nil "p2x: ~a" *p2x*) 10 70)
    (text (format nil "p2y: ~a" *p2y*) 10 85)
    ;; Display values of: *x* and *y*
    (text (format nil "x: ~a" *x*) 10 115)
    (text (format nil "y: ~a" *y*) 10 130))
  
  ;; Update the angle ever frame
  ;; --
  (setf *angle* (+ *angle* (* (* 2 pi) *dt* )))

  ;; Draw the points.
  ;; --
  (loop for i across vs
        do (project 
            (translate 
             (rotate 
              :x (getf i :x) 
              :y (getf i :y) 
              :z (getf i :z) 
              :angle *angle*)))
           ;; draw point every loop
           (draw-point))
 
  ;; Draw the lines.
  ;; --
  (loop for f across fs
        do (loop for i from 0 below (length f)
                 for a = (aref vs (aref f i))
                 for b = (aref vs (aref f (mod (+ 1 i) (length f))))
                 do
                    (loop for f across fs
                          do (loop for i from 0 below (length f)
                                   for a = (aref vs (aref f i))
                                   for b = (aref vs (aref f (mod (+ 1 i) (length f))))
                                   do
                                      ;; point P1
                                      (project-p1
                                       (translate
                                        (rotate :x (getf a :x) 
                                                :y (getf a :y) 
                                                :z (getf a :z) 
                                                :angle *angle*))) 
                       
                                      ;; point P2
                                      (project-p2
                                       (translate
                                        (rotate :x (getf b :x) 
                                                :y (getf b :y) 
                                                :z (getf b :z) 
                                                :angle *angle*
                                                ))) 

                                      ;; draw the lines every loop
                                      (draw-line)
                                   )))))

;; Let just try to start a Sketch intance on load.
;; --
(make-instance 'trivial-3d-engine)

;; render without anti-aliasing
;; --
;; from this discussion on github: https://github.com/vydd/sketch/issues/172
;; note: this only works as long as you don't use scale in your sketch
(defmethod setup :after ((sketch trivial-3d-engine) &key &allow-other-keys)
  (gl:disable :multisample))


;; Use this to start after loading with quicklisp.
;; Example: (trivial-3d-engine:start-app)
;; -- 
(defun start-app ()
  (make-instance 'trivial-3d-engine))


