;;;
;;; BASIC for the 65816 processor
;;;

.cpu "65816"

.include "constants.s"
.include "memorymap.s"
.include "macros.s"

.section code

.include "bootstrap.s"

.include "bios.s"
.include "utilities.s"
.include "tokens.s"
.include "heap.s"
.include "strings.s"
.include "listing.s"
.include "eval.s"
.include "returnstack.s"
.include "interpreter.s"
.include "repl.s"
.include "operators.s"
.include "statements.s"
.include "commands.s"
.include "variables.s"

.if UNITTEST
.include "tests/basictests.s"
.endif

START       CLC                 ; Go to native mode
            XCE

            setdp GLOBAL_VARS
            setdbr BASIC_BANK

            setaxl

            CALL INITBASIC

            ; Clear the screen and print the welcome message
            CALL CLSCREEN

            setas
            LDA #'#'
            CALL PRINTC
            setal

            setdbr `GREET
            LDX #<>GREET
            CALL PRINTS
            setdbr BASIC_BANK

            setaxl
            LDA #<>WAIT         ; Send subsquent restarts to the WAIT loop
            STA RESTART

.if UNITTEST
            CALL TST_BASIC      ; Run the BASIC816 unit tests
.else
            JMP INTERACT        ; Start accepting input from the user
.endif

WAIT        JMP WAIT

INITBASIC   .proc
            PHP
            CALL INITIO         ; Initialize I/O system
            CALL CMD_NEW        ; Clear the program

            PLP
            RETURN
            .pend
.send

.section data
GREET       .null "Welcome to BASIC816 v0.0 for the C256 Foenix",13
.send