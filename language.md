# Language Elements

This page lists the commands, statments, operators, and functions BASIC816 will support. It should be
considered an incomplete document at the moment, as I haven't really had time to sit down and write out
a full specification. The intention is to create a version of BASIC similar in many ways to Commodore BASIC 7.0,
but with some differences. Statements relating to graphics, sound, disk, and other I/O device functions will
likely be different. Also, BASIC816 will have some sort of foreign function interface that will allow a user
to install a "pack" of new statements to expand the language as they need.

## Commands

The following commands are planned for implementation:

### NEW

Erase the current BASIC program and all variable.s

### RUN [*START*]

Start the BASIC program. If a line number *START* is provided, start execution from that line.

### LIST [*START* [- [*END*]]]

Print a listing of the current BASIC program. If only line number *START* is provided, just print that one line.
If only line number *END* is provided, print all lines up to and including *END*.
If both *START* and *END* are provided, print all lined from *START* to *END*, inclusive.

### LOAD *FILENAME* [, *ADDRESS*]

Attempt to load the named file from the file system. If an *ADDRESS* is supplied, attempt to load the file to that location in memory. Otherwise, *FILENAME* should be a BASIC file to load into the BASIC program area.

### SAVE *FILENAME* [, *ADDRESS*, *LENGTH*]

Save memory to the filesystem as the *FILENAME*. If an *ADDRESS* and *LENGTH* are provided saves the block of memory specified as a binary file. Otherwise, saves the current BASIC program as a BASIC file.

### DIR [*PATH*]

Print a listing of all files in the filesystem at *PATH*. If no *PATH* is provided, list all files from the current working path.

### CWD *PATH*

Change the working directory to *PATH*.

### PWD

Print out the current working directory.

## Statements

The following statements are planned for implementation:

### GOTO *LINE*

Stop executing from the current position in the program and start executing from the beginning of line number *LINE*.

### GOSUB *LINE*

Stop executing from the current position in the program, and start executing the subroutine that started on line number *LINE*.
When the subrouting reaches the RETURN statement, return to executing the statement immediately after the GOSUB.

### RETURN

Only to be used within a subroutine. Continues execution with the statement immediately following the most recently executed GOSUB.

### IF *TEST* THEN *TRUE STATEMENTS* [ELSE *FALSE STATEMENTS*] [ENDIF]

Evaluate the expression *TEST*, if it is true, execute all statements in *TRUE STATEMENTS*, otherwise execute all statements in
*FALSE STATEMENTS*. Both *TRUE STATEMENTS* and *FALSE STATEMENTS* can be just a number, in which case it is a shorthand for a GOTO.
When the statements are either line numbers or GOTO statements, and the entire IF statement is on one line, no END IF is required.
If any other statements are used, the IF is in block form and requires a closing END IF.

### DO [WHILE *CONDITION* | UNTIL *CONDITION*] *STATEMENTS* LOOP [WHILE *CONDITION* | UNTIL *CONDITION*]

Execute the *STATEMENTS* repeatedly. A WHILE or UNTIL condition can be applied either to the DO statement
or the LOOP statement. When applied to the DO statement, the condition can prevent the statements from
being executed at all. When applied to the LOOP, the statements will execute at least once. A program can force a premature exit from a DO loop with a BREAK statement.

### FOR *VARIABLE* = *INITIAL* TO *LIMIT* [STEP *INCREMENT*] *STATEMENTS* NEXT [*VARIABLE*]

Loop through *STATEMENTS*. For the first execution, *VARIABLE* will be set to *INITIAL*. *VARIABLE* will go up by 1, unless *INCREMENT* is
provided, in which case it will go up or down by *INCREMENT*. The loop will stop when *VARIABLE* reaches *LIMIT*.

### POKE *ADDRESS*,*VALUE*

Store an 8-bit *VALUE* directly to memory at address *ADDRESS*.

### WPOKE *ADDRESS*,*VALUE*

Store a 16-bit *VALUE* directly to memory at address *ADDRESS*.

### CLS

Clears the screen and puts the cursor in the upper-right cornoer.

### INPUT [*PROMPT*;] *VARIABLE*

Optionally print a prompt and wait for the user to input data. The system will attempt to read the data and assign it to the supplied variable. It will be an error if the data cannot be converted to fit the variable (e.g. "hello" was entered, but the variable is a number).

### GET *VARIABLE*

Get the next keypress from the input buffer and assign it to *VARIABLE*. Wait for a keypress if the input buffer is empty.

### PRINT [*EXPRESSION* [,|; [*EXPRESSION*] ...]

Print each *EXPRESSION* supplied to the screen. Expressions are separated by either a comma or a semicolon, and the last expression can be followed by a comma or semicolon. If two expressions are separated by a semi-colon, nothing will be printed between them. If they are separated by a comma, a TAB will be printed between them on the screen. If the final expression is followed by a semicolon, no carriage retrun will be printed at the end of the PRINT statement.