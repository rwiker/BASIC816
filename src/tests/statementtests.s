;;;
;;; Unit tests for statements
;;;

; Test that we can add comments
TST_REM         .proc
                UT_BEGIN "TST_REM"

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

                ; Validate that A%=1234
                setal
                LDA #<>VAR_A
                STA TOFIND
                setas
                LDA #`VAR_A
                STA TOFIND+2

                LDA #TYPE_INTEGER
                STA TOFINDTYPE

                CALL VAR_REF            ; Try to get the result
                UT_M_EQ_LIT_B ARGTYPE1,TYPE_INTEGER,"EXPECTED INTEGER"
                UT_M_EQ_LIT_W ARGUMENT1,1234,"EXPECTED A%=1234"

                UT_END
LINE10          .null "10 A%=1234"
LINE20          .null "20 REM:A%=5678"
VAR_A           .null "A%"
                .pend

; Test that we can clear variables and heap
TST_CLR         .proc
                UT_BEGIN "TST_CLR"

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

                ; Validate that variables are empty
                UT_M_EQ_LIT_L VARIABLES,0,"EXPECTED VARIABLES = 0"

                ; Validate that heap is empty
                UT_M_EQ_LIT_L HEAP,HEAP_TOP,"EXPECTED HEAP = HEAP_TOP"

                ; Validate pointer to allocated objects is 0
                UT_M_EQ_LIT_L ALLOCATED,0,"EXPECTED ALLOCATED = 0"

                UT_END
LINE10          .null "10 A%=1234"
LINE20          .null "20 CLR"
                .pend

; Test that we can STOP execution
TST_STOP        .proc
                UT_BEGIN "TST_STOP"

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

                LD_L CURLINE,LINE30
                CALL TOKENIZE
                LDA LINENUM
                CALL APPLINE

                CATCH TRAP_POINT

                setal
                LDA #<>BASIC_BOT            ; Point to the first line of the program
                STA CURLINE
                LDA #`BASIC_BOT
                STA CURLINE + 2

                CALL S_CLR
                STZ GOSUBDEPTH              ; Clear the depth of the GOSUB stack

                CALL EXECPROGRAM

                ; Validate that A%=1234
TRAP_POINT      setal
                LDA #<>VAR_A
                STA TOFIND
                setas
                LDA #`VAR_A
                STA TOFIND+2

                LDA #TYPE_INTEGER
                STA TOFINDTYPE

                CALL VAR_REF            ; Try to get the result
                UT_M_EQ_LIT_B ARGTYPE1,TYPE_INTEGER,"EXPECTED INTEGER"
                UT_M_EQ_LIT_W ARGUMENT1,1234,"EXPECTED A%=1234"

                UT_END
LINE10          .null "10 A%=1234"
LINE20          .null "20 STOP"
LINE30          .null "30 A%=5678"
VAR_A           .null "A%"
                .pend


; Test that we can execut the LET statement in various forms
TST_LET         .proc
                UT_BEGIN "TST_LET"

                setdp GLOBAL_VARS
                setdbr BASIC_BANK

                setaxl

                CALL INITBASIC

                LD_L CURLINE,LINE10
                CALL TOKENIZE
                LDA LINENUM
                CALL APPLINE

                CALL CMD_RUN

                ; Validate that ABC%=1234
                setal
                LDA #<>VAR_ABC
                STA TOFIND
                setas
                LDA #`VAR_ABC
                STA TOFIND+2

                LDA #TYPE_INTEGER
                STA TOFINDTYPE

                CALL VAR_REF            ; Try to get the result
                UT_M_EQ_LIT_B ARGTYPE1,TYPE_INTEGER,"EXPECTED INTEGER"
                UT_M_EQ_LIT_W ARGUMENT1,1234,"EXPECTED ABC%=1234"

                TRACE "CHECK N$"

                ; Validate that NAME$ is a string
                setal
                LDA #<>VAR_NAME
                STA TOFIND
                setas
                LDA #`VAR_NAME
                STA TOFIND+2

                LDA #TYPE_STRING
                STA TOFINDTYPE

                CALL VAR_REF            ; Try to get the result

                MOVE_L SCRATCH2,ARGUMENT1

                UT_M_EQ_LIT_B ARGTYPE1,TYPE_STRING,"EXPECTED STRING"
                UT_STRIND_EQ SCRATCH2,EXPECTED,"EXPECTED 'FOO'"

                UT_END
LINE10          .null '10 ABC%=1234:NAME$="FOO"'
VAR_ABC         .null "ABC%"
VAR_NAME        .null "NAME$"
EXPECTED        .null "FOO"
                .pend

TST_STMNTS      .proc
                CALL TST_REM
                CALL TST_CLR
                CALL TST_LET
                ; CALL TST_STOP

                UT_LOG "TST_STMNTS: PASSED"
                RETURN
                .pend