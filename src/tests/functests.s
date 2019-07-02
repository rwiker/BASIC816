;;;
;;; Test BASIC functions
;;;

; Test LEN(S$)
TST_LEN         .proc
                UT_BEGIN "TST_LEN"

                setdp GLOBAL_VARS
                setdbr BASIC_BANK

                setaxl

                CALL INITBASIC

                LD_L CURLINE,LINE10
                CALL TOKENIZE
                LDA LINENUM
                CALL APPLINE

                LD_L CURLINE,LINE20
                CALL TOKENIZE
                LDA LINENUM
                CALL APPLINE

                CALL CMD_RUN

                TRACE "OK"

                ; Validate that A%=12
                setal
                LDA #<>VAR_A
                STA TOFIND
                setas
                LDA #`VAR_A
                STA TOFIND+2

                LDA #TYPE_INTEGER
                STA TOFINDTYPE

                CALL VAR_REF
                UT_M_EQ_LIT_B ARGTYPE1,TYPE_INTEGER,"EXPECTED INTEGER"
                UT_M_EQ_LIT_W ARGUMENT1,12,"EXPECTED A%=12"

                ; Validate that B%=5
                setal
                LDA #<>VAR_B
                STA TOFIND
                setas
                LDA #`VAR_B
                STA TOFIND+2

                LDA #TYPE_INTEGER
                STA TOFINDTYPE

                CALL VAR_REF
                UT_M_EQ_LIT_B ARGTYPE1,TYPE_INTEGER,"EXPECTED INTEGER"
                UT_M_EQ_LIT_W ARGUMENT1,5,"EXPECTED B%=5"

                UT_END
LINE10          .null '10 A%=LEN("Hello, World")'
LINE20          .null '20 N$="Hello":B%=LEN(N$)'
VAR_A           .null "A%"
VAR_B           .null "B%"
                .pend

; Test CHR$(value)
TST_CHR         .proc
                UT_BEGIN "TST_CHR"

                setdp GLOBAL_VARS
                setdbr BASIC_BANK

                setaxl

                CALL INITBASIC

                LD_L CURLINE,LINE10
                CALL TOKENIZE
                LDA LINENUM
                CALL APPLINE

                CALL CMD_RUN

                ; Validate that A%=12
                setal
                LDA #<>VAR_A
                STA TOFIND
                setas
                LDA #`VAR_A
                STA TOFIND+2

                LDA #TYPE_STRING
                STA TOFINDTYPE

                CALL VAR_REF
                UT_M_EQ_LIT_B ARGTYPE1,TYPE_STRING,"EXPECTED STRING"

                UT_END
LINE10          .null '10 A$=CHR$(64)'
VAR_A           .null "A%"
EXPECTED        .null "@"
                .pend

; Check that we can get the ASCII code for a string
TST_ASC         .proc
                UT_BEGIN "TST_ASC"

                setdp GLOBAL_VARS
                setdbr BASIC_BANK

                setaxl

                CALL INITBASIC

                TSTLINE '10 A%=ASC("A")'
                TSTLINE '20 B%=ASC("")'

                CALL CMD_RUN

                ; Validate we got the ASCII code for "A"
                UT_VAR_EQ_W "A%",TYPE_INTEGER,$41

                ; Validate we got the ASCII code 0 for ""
                UT_VAR_EQ_W "B%",TYPE_INTEGER,0

                UT_END
                .pend

; Check that we can create a string of spaces
TST_SPC         .proc
                UT_BEGIN "TST_SPC"

                setdp GLOBAL_VARS
                setdbr BASIC_BANK

                setaxl

                CALL INITBASIC

                TSTLINE '10 A$=SPC(5)'

                CALL CMD_RUN

                ; Validate we got a string of 5 spaces
                UT_VAR_EQ_STR "A$","     "

                UT_END
                .pend

; Check that we can create a string of TABs
TST_TAB         .proc
                UT_BEGIN "TST_TAB"

                setdp GLOBAL_VARS
                setdbr BASIC_BANK

                setaxl

                CALL INITBASIC

                TSTLINE '10 A$=TAB(5)'

                CALL CMD_RUN

                ; Validate we got a string of 5 TABs
                setal
                LDA #<>VAR_NAME
                STA TOFIND
                LDA #`VAR_NAME
                STA TOFIND+2

                setas
                LDA #TYPE_STRING
                STA TOFINDTYPE

                CALL VAR_REF            ; Try to get the result
                UT_M_EQ_LIT_B ARGTYPE1,TYPE_STRING,"EXPECTED STRING"
                UT_STRIND_EQ ARGUMENT1,EXPECTED,"EXPECTED A$=[{TAB}{TAB}{TAB}{TAB}{TAB}]"

                UT_END
VAR_NAME        .null "A$"
EXPECTED        .byte 9,9,9,9,9,0
                .pend

; Check that we can take the absolute value of an integer
TST_ABS         .proc
                UT_BEGIN "TST_ABS"

                setdp GLOBAL_VARS
                setdbr BASIC_BANK

                setaxl

                CALL INITBASIC

                TSTLINE '10 A%=ABS(-20)'
                TSTLINE '20 B%=ABS(20)'
                TSTLINE '30 C%=ABS(0)'

                CALL CMD_RUN

                ; Validate we get the absolute values back
                UT_VAR_EQ_W "A%",TYPE_INTEGER,20
                UT_VAR_EQ_W "B%",TYPE_INTEGER,20
                UT_VAR_EQ_W "C%",TYPE_INTEGER,0

                UT_END
                .pend

; Check that we can get the sign of an integer
TST_SGN         .proc
                UT_BEGIN "TST_SGN"

                setdp GLOBAL_VARS
                setdbr BASIC_BANK

                setaxl

                CALL INITBASIC

                TSTLINE '10 A%=SGN(-20)'
                TSTLINE '20 B%=SGN(20)'
                TSTLINE '30 C%=SGN(0)'

                CALL CMD_RUN

                ; Validate we get the absolute values back
                UT_VAR_EQ_W "A%",TYPE_INTEGER,-1
                UT_VAR_EQ_W "B%",TYPE_INTEGER,1
                UT_VAR_EQ_W "C%",TYPE_INTEGER,0

                UT_END
                .pend

; Check that we can get the hexadecimal representation of a number
TST_HEX         .proc
                UT_BEGIN "TST_HEX"

                setdp GLOBAL_VARS
                setdbr BASIC_BANK

                setaxl

                CALL INITBASIC

                TSTLINE '10 H$ = HEX$(123)'

                CALL CMD_RUN

                setal
                LDA #0
                STA LINENUM

                UT_VAR_EQ_STR "H$","7B"

                UT_END
                .pend

; Check that we can parse a hexadecimal number into an integer
TST_DEC         .proc
                UT_BEGIN "TST_DEC"

                setdp GLOBAL_VARS
                setdbr BASIC_BANK

                setaxl

                CALL INITBASIC

                TSTLINE '10 D% = DEC("   $12Ab")'

                CALL CMD_RUN

                setal
                LDA #0
                STA LINENUM

                UT_VAR_EQ_W "D%",TYPE_INTEGER,$12AB

                UT_END
                .pend

TST_FUNCS       .proc
                CALL TST_LEN
                CALL TST_CHR
                CALL TST_ASC
                CALL TST_SPC
                CALL TST_TAB
                CALL TST_ABS
                CALL TST_SGN
                CALL TST_HEX
                CALL TST_DEC

                UT_LOG "TST_FUNCS: PASSED"
                RETURN
                .pend