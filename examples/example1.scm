#! /usr/local/bin/guile -s
!#


; ==============================================================================
;
; example1.scm
;
; A sample of different gates and functions of g2q. Note that this program does
; not intend to be a functional one. It is just a way to demostrate what gates
; and functions you can write and how. Don't worry about the sense it doesn't 
; make as a practical program.  
;
; Compilation:
;
; - cd to your /examples folder.
;
; - Enter the following:
;
;   guile example1.scm 
;
; ==============================================================================
;
; Copyright (C) 2018  Pablo Edronkin (pablo.edronkin at yahoo.com)
;
;   This program is free software: you can redistribute it and/or modify
;   it under the terms of the GNU Lesser General Public License as published by
;   the Free Software Foundation, either version 3 of the License, or
;   (at your option) any later version.
;
;   This program is distributed in the hope that it will be useful,
;   but WITHOUT ANY WARRANTY; without even the implied warranty of
;   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;   GNU Lesser General Public License for more details.
;
;   You should have received a copy of the GNU Lesser General Public License
;   along with this program.  If not, see <https://www.gnu.org/licenses/>.
;
; ==============================================================================


; Modules. These two will be almost always required.
(use-modules (g2q g2q0))
(use-modules (g2q g2q2))


; Vars and initial stuff.
(define fname "example1.qasm")
(define qver 2.0)
(define q "q")
(define c "c")


; This configures the output to be sent a file instead of the console. If you
; take out or disable these lines, and those closing the output port (see at  
; the bottom) instead of getting a qasm file you will see the compiled lines
; on the console.
(define port1 (current-output-port))
(define port2 (open-output-file fname))
(set-current-output-port port2)


; Remember what this program is about (optional).
(qcomm "This program does nothing in particular, but shows how to use g2q functions.")


; Creating header and required vectors.
(qhead fname qver)
(qregdef q 5 c 5)


; This places five Hadamard gates on y axis (i.e. in parallell), from register
; 0 to register 4. Notice that functuon qcomm will print comments on the qasm
; file, while these comments, starting will ; only appear in source files such  
; as this one.
(qcomm "Five h gates.")
(g1y "h" q 0 4)


; Now we do the same for a Pauli X, just for fun, but on the three first
; registers. You can view the source code for modules g2q0, g2q1 and g2q2 for 
; more specific info about these funtctions. Each one is commented there.
(qcomm "Two x gates.")
(g1y "x" q 1 2)


; And we add other gates, one by one.
(qcomm "Various basic gates.")
(g1 "id" q 3)
(g1 "y" q 4)
(g1 "z" q 0)
(g1 "s" q 1)
(g1 "t" q 2)
(g1 "tdg" q 3)
(g1 "sdg" q 4)
(u1 1.6 q 0)
(u2 1.6 1.6 q 1)
(u3 1.6 1.6 1.6 q 2)


; cx, cy, cz and ch gates.
(qcomm "Controlled x.")
(cx q 2 q 0)
(qcomm "Controlled y.")
(cy q 3 q 4)
(qcomm "Controlled z.")
(cz q 4 q 2)
(qcomm "Controlled h.")
(ch q 2 q 0)


; Rotations and others.
(qcomm "Controlled x.")
(rx 1.6 q 1)
(qcomm "Controlled y.")
(ry 1.6 q 2)
(qcomm "Controlled z.")
(rz 1.6 q 3)
(qcomm "crz.")
(crz 1.6 q 3 q 4)
(qcomm "Controlled u1.")
(cu1 1.6 q 2 q 0)
(qcomm "Controlled u3.")
(cu3 1.6 1.6 q 2 q 0)


; Let's put a barrier.
(qcomm "Barriers.")
(g1y "barrier" q 0 4)


; And now measure.
(qcomm "Measuring")
(qmeas q 0 c 0)
(qmeas q 1 c 1)
(qmeas q 2 c 2)
(qmeas q 3 c 3)
(qmeas q 4 c 4)


; Message
(qcomm "This message will appear at the end of the qasm file.")

; Sets the output pot againt to the console. Don't forget to check if the 
; compilation is error free or you have some bugs to kill.
(set-current-output-port port1)
(close port2)
(qendc)

