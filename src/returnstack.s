;;;
;;; Subroutines to manage the return stack.
;;;
;;; The return stack will be used to store context for BASIC subroutines and looping instructions
;;;

;
; Typical things pushed to the return stack
; GOSUB: return_line, return_bip
; FOR: variable, end_value, increment, next_line, next_bip
; DO ... LOOP: loop_line, loop_bip 

;
; Initialize the RETURN stack to point to the the highest word position
;
INITRETURN      .proc
                PHP
                PHD
                PHB

                setdbr 0
                setdp GLOBAL_VARS

                setaxl
                LDA #RETURN_TOP-2
                STA RETURNSP

                PLB
                PLD
                PLP
                RETURN
                .pend

;
; Push the value in A to the RETURN stack
;
; Inputs:
;   A = the 16-bit value to push to the return stack
;   RETURNSP = the pointer to the next available position on the return stack
;
PHRETURN        .proc
                PHP
                PHD

                TRACE "PHRETURN"

                setdp GLOBAL_VARS
                setaxl

                STA (RETURNSP)
                DEC RETURNSP
                DEC RETURNSP

                PLD
                PLP
                RETURN
                .pend

;
; Push the lower 8 bit value in A to the RETURN stack as a 16-bit value
;
; Inputs:
;   A = the 8-bit value to push to the return stack
;   RETURNSP = the pointer to the next available position on the return stack
;
PHRETURNB       .proc
                PHP

                TRACE "PHRETURNB"

                setaxl

                AND #$00FF
                CALL PHRETURN
                PLP
                RETURN
                .pend

;
; Pop a value off the RETURN stack into A
;
; Inputs:
;   RETURNSP = the pointer to the next available position on the return stack
;
; Outputs:
;   A = the value popped off the RETURN stack
;   RETURNSP = the pointer to the next available position on the return stack
;
PLRETURN        .proc
                PHP
                PHD

                TRACE "PLRETURN"

                setdp GLOBAL_VARS

                setaxl
                INC RETURNSP
                INC RETURNSP
                LDA (RETURNSP)

                PLD
                PLP
                RETURN
                .pend