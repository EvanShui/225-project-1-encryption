.ORIG x3000                  ; Start at address x3000
;store address to access block of memory for storing user input
LEA R1, STRSTOR              ; stores the address of the block of memory dedicated to holding the user's input intro R1
AND R5, R5, #0               ; Counter for number of characters that the user inputs.

;loop to grab character from user, input it into memory until user presses enter
LEA R0, STRINP               ; Load the encryption input message into R0
PUTS                         ; Writes the message to output as a prompt for user to input an encryption key
LOOP GETC                    ; Set LOOP to set the input character (without prompt and echo) to the
OUT                          ; Reads one character (the encryption value) from input (without echo) and loads into R0
STR R0, R1, #0               ; Stores the contents of R0 into the address loaded into R1
ADD R2, R0, #0               ; Saves the value of R0 (user input) into R2
ADD R2,R2,#-10               ; Decrements R2 (user input) by 10 to check if character inputted is an enter key.
BRz ENTER                    ; Conditional code, if the key entered is the enter key and is subtracted by 10, thus equating to 0, it will be move on to display the enter key message.
AND R0, R0, #0               ; clear R0
ADD R0, R1, R0               ; Sets R0 to R1 (address of the memory that has already been written to)
OUT                          ; Writes string of characters (the address of memory) from input (without echo) and loads into R0
ADD R5, R5, b01              ; increment the counter (R5)
AND R0, R0, b0
OUT
ADD R1, R1, #1               ; Increment R1 by 1, thus incrementing through memory
BRnzp LOOP

;checks to see if enter key has been pressed
ENTER LEA R0, ENTERPRESS     ; Load the enter key message into R0
PUTS                         ; Writes the message to output as a prompt for user to input an encryption key

LEA R0, STRSTOR              ; stores the address of the block of memory dedicated to holding the user's input intro R1
PUTS


;loading
STRINP .STRINGZ "Input Message: "; The input message for encryption
ENTERPRESS .STRINGZ "Enter Key has been pressed\n"; Just to check if the enter key has been pressed
STRSTOR .BLKW #21
ENCRYPTSTRSTOR .BLKW #21

.END
