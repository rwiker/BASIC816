# BASIC816 Implementation Check List and Status

## System Tasks

1. [X] Add a BREAK/Interrupt key
1. [X] Move BASIC code to higher memory
1. [X] Update ADDLINE to handle out of order entry
1. [-] Move key functions to a modifiable vector table
    1. [ ] READLINE
    1. [ ] PUTC
    1. [ ] LOCATE
1. [ ] Flesh out division for other systems
1. [X] Implement the garbage collector
1. [ ] Implement floating points
1. [ ] Update screen.s scrolling once DMA is available
1. [ ] Update screen.s scrolling to work with multiple text screen sizes
1. [ ] Update io_c256.s once kernel is finalized
1. [ ] Remove RESET vector once C256 is “done” or the interpreter is folded into the kernel ROM

## Statements

1. [ ] Flesh out other forms of IF THEN ELSE
1. [ ] Expand PRINT to support FLOATS and other types?
1. [ ] BEGIN / BEND
1. [X] CALL
1. [X] CLR
1. [X] CLS
1. [X] DATA
1. [ ] DEF FN
1. [X] DIM
1. [ ] DO loops
1. [X] FOR / NEXT
1. [ ] ON … GOTO
1. [X] POKE
    1. [X] POKEW
    1. [X] POKEL
1. [X] READ
1. [X] REM
1. [X] RESTORE
1. [X] STOP
1. [X] CALL
1. [ ] I/O
    1. [ ] CLOSE
    1. [X] GET
    1. [ ] GET#
    1. [X] INPUT
    1. [ ] INPUT#
    1. [ ] OPEN
    1. [ ] PRINT#

## Operators

1. [x] AND
1. [x] OR
1. [x] NOT
1. [ ] Comparisons
    1. [X] =
    1. [X] <
    1. [X] <=
    1. [X] >
    1. [X] >=
    1. [X] <>
1. [X] String +

## Functions

1. [ ] Floating Point Functions
    1. [ ] COS
    1. [ ] EXP
    1. [ ] INT
    1. [ ] LOG
    1. [ ] RND
    1. [ ] SIN
    1. [ ] SQR
    1. [ ] TAN
1. [ ] String Functions
    1. [X] ASC
    1. [X] CHR$
    1. [X] HEX$
    1. [X] LEFT$
    1. [X] LEN
    1. [X] MID$
    1. [X] RIGHT$
    1. [X] SPC
    1. [X] STR$
    1. [X] TAB
    1. [X] GETTIME$
    1. [X] VAL
1. [ ] Other Functions
    1. [X] ABS
    1. [X] DEC
    1. [ ] FN
    1. [ ] FRE
    1. [X] PEEK()
        1. [X] PEEKW()
        1. [X] PEEKL()
    1. [X] SGN
    1. [ ] STATUS
    1. [ ] USR

## Commands

1. [X] LIST
    1. [X] Support line target ranges
1. [ ] CONT
1. [-] I/O Commands
    1. [X] LOAD
    1. [ ] SAVE
    1. [X] DIR
    1. [ ] DEL