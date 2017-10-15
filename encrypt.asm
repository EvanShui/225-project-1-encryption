.ORIG x3000                  ; Start at address x3000

LEA R0, ENCINP               ; Load the encryption input message into R0
PUTS                         ; Writes the message to output as a prompt for user to input an encryption key
GETC                         ; Reads one character (the encryption value) from input (without echo) and loads into R0
OUT                          ; Writes one character to output (from R0)
ADD R0, R0, #-16             ; User inputted value is in ASCII, turning it into decimal form
ADD R0, R0, #-16             ; User inputted value is in ASCII, turning it into decimal form
ADD R0, R0, #-16             ; User inputted value is in ASCII, turning it into decimal form
AND R6, R6, #0               ; Clear R6
ADD R6, R6, R0               ; Copy R0 to R6 (will act as the encryption key holder)

;store address to access block of memory for storing user input
LEA R1, STRSTOR              ; stores the address of the block of memory dedicated to holding the user's input intro R1
AND R5, R5, #0               ; Counter for number of characters that the user inputs.

;loop to grab character from user, input it into memory until user presses enter
LEA R0, STRINP               ; Load the encryption input message into R0
PUTS                         ; Writes the message to output as a prompt for user to input an encryption key
LOOP GETC                    ; Set LOOP to set the input character (without prompt and echo) to the
OUT                          ; Reads one character (the encryption value) from input (without echo) and loads into R0
ADD R2, R0, #0               ; Saves the value of R0 (user input) into R2
ADD R2,R2,#-10               ; Decrements R2 (user input) by 10 to check if character inputted is an enter key.
BRz ENTER                    ; Conditional code, if the key entered is the enter key and is subtracted by 10, thus equating to 0, it will be move on to display the enter key message.
STR R0, R1, #0               ; Stores the contents of R0 into the address loaded into R1
AND R0, R0, #0               ; clear R0
ADD R0, R1, R0               ; Sets R0 to R1 (address of the memory that has already been written to)
ADD R5, R5, b01              ; increment the counter (R5)
AND R0, R0, b0
ADD R1, R1, #1               ; Increment R1 by 1, thus incrementing through memory
BRnzp LOOP

;checks to see if enter key has been pressed
ENTER LEA R0, ENTERPRESS     ; Loads in the address of ENTERPRESS (which contains a blank string to handle the odd scenario) and store into R0

;loading in data from memory
AND R2, R2, #0               ; Clear R2
ADD R2, R6, R2               ; Store the counter variable (previously in R6) now in R2
LEA R1, STRSTOR              ; stores the address of the block of memory dedicated to holding the user's input intro R1
PUTS                         ; prints out all of the characters that are in the STRSTOR address
LEA R6, ENCRYPTSTRSTOR       ; Store the address of ENCRYPTSTRSTOR in R6

;encryption process
ENCRYPTLOOP LDR R0, R1, #0   ; Stores the contents of R0 into the address loaded into R1
ADD R3, R0, #0               ; Loads the data from R1 and sets it into R3
AND R4, R3, #-2              ; sets R4 to bit-wise AND between R3 and 11110 (to set the last bit to 0)
NOT R4, R4                   ; not R4
ADD R4, R4, R3               ; Adding R4 and R3 which, if they are equal, should be -1
ADD R4, R4, #1               ; If after bit-wise and operation is performed, and the values are equal (which means that the least-significant bit is 0), then R4 should be equal to 0
                             ; However, if they are not equal (which means that the least-significant bit is 1), then R4 should not be equal to 0
BRnp SIGBIT1                 ; Conditional statement, if it's not zero, then least-significant bit is 1, then have to change to 0.

;conditional statement: least-sig bit = 0
AND R4, R4, #0               ; clear R4
ADD R4, R0, #0               ; Copy R0 to R4
ADD R4, R4, #1               ; If the value loaded into R4 is 0, then it means the values are equal
BRnzp RETURN                 ; Jump to the ENDFUNC

;conditional statement: least-sig bit = 1
SIGBIT1 AND R4, R4, #0       ; If the bit is 1, then shift to this instruction and clear Register 4
ADD R4, R0, #0               ; Copy R0 to R4
NOT R4, R4                   ; NOT R4
ADD R4, R4, #1               ; Add 1 to R4
NOT R4, R4                   ; NOT R4
RETURN ADD R0, R2, R4        ; Store the encrypted value to R0 by adding R2 (the encryption key) and the R4 (the encrypted user-input character)
STR R0, R6, #0               ; Store the contents of R0 into the address located within R6
ADD R1, R1, #1               ; Increment the address pointing towards the characters typed out by the user
ADD R6, R6, #1               ; Increment the address pointing towards where the encrypted character will be stored
ADD R5, R5, #-1              ; Decrement the counter variable
BRp ENCRYPTLOOP              ; Move to the ENCRYPTLOOP to repeat the encrypting process until the counter reaches 0


;printing Encrypted Message
LEA R0, ENCOUT               ; Store the address for ENCOUT into R0
PUTS                         ; Writes the message to output
LEA R0, ENCRYPTSTRSTOR       ; Store the address of ENCRYPTSTRSTOR into R0
PUTS                         ; Writes the message to output

;clears the data from memory for reuse later
AND R1, R1, #0               ; clears R1
ADD R1, R1, #15              ; Adds 21 to R1 as a counter
AND R1, R1, #6               ; Adds 21 to R1 as a counter
LEA R2, ENCRYPTSTRSTOR       ; Loads address to Encrypt string storage to R2
CLEARLOOP AND R0, R0, #0     ; Clears R0
STR R0, R2, #0               ; Stores contents of R0 into address specified in R2
ADD R2, R2, #1               ; Increment address specified in R2
ADD R1, R1, #-1              ; Decrement counter to clear all of memory in ENCRYPTSTRSTOR
BRp CLEARLOOP                ; Conditional code, moves to halt if counter reaches zero

TRAP x25                     ; HALT

;loading
ENCINP .STRINGZ "Encryption Key (1-9): "  ; The input message for encryption
STRINP .STRINGZ "\nInput Message: "       ; The input message for encryption
ENCOUT .STRINGZ "Encrypted Message: "     ; The output message for encryption
ENTERPRESS .STRINGZ ""                    ; Just to check if the enter key has been pressed
STRSTOR .BLKW #21                         ; Reserving space for user's characters
ENCRYPTSTRSTOR .BLKW #21                  ; Reserving space for the encrypted version of user's characters

.END                         ; END
