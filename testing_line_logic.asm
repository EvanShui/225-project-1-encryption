.ORIG x3000                  ; Start at address x3000
LEA R7, ENCRYPTSTRSTOR       ; load the beginning of the encrypted string memory storage into R7
;LEA R1, STRSTOR               load the beginning of the user inputted string memory storage into R6 (R6 will hold the value of the first character from the user)
AND R0, R0, b00000           ; clear R0
ADD R2, R0, #6               ; sets R2 to have the value 6 (actually R2 will be the register that holds the value of the encryption key)
ADD R1, R1, #15              ; hardcode in ascii character A
ADD R1, R1, #15              ; hardcode in ascii character A
ADD R1, R1, #15              ; hardcode in ascii character A
ADD R1, R1, #15              ; hardcode in ascii character A
ADD R1, R1, #5               ; hardcode in ascii character A
LEA R0, ENCINP               ; Load the encryption input message into R0
PUTS                         ; Writes the message to output as a prompt for user to input an encryption key
GETC                         ; Reads one character (the encryption value) from input (without echo) and loads into R0
OUT                          ; Writes one character to output (from R0)


;LOOP LDR R3, R1, #0           loads the data from address specified in R1 sets it into R3
ADD R3, R0, #0               ; Loads the data from R1 and sets it into R3
AND R4, R3, #-2              ; sets R4 to bit-wise AND between R3 and 11110 (to set the last bit to 0)
NOT R4, R4                   ; not R4
ADD R4, R4, R3               ; Adding R4 and R3 which, if they are equal, should be -1
ADD R4, R4, #1               ; If after bit-wise and operation is performed, and the values are equal (which means that the least-significant bit is 0), then R4 should be equal to 0
                             ; However, if they are not equal (which means that the least-significant bit is 1), then R4 should not be equal to 0
BRnp SIGBIT1                 ; Conditional statement, if it's not zero, then least-significant bit is 1, then have to change to 0.
AND R4, R4, #0
ADD R4, R0, #0
ADD R4, R4, #1               ; If the value loaded into R4 is 0, then it means the values are equal
BRnzp RETURN                 ; Jump to the ENDFUNC
SIGBIT1 AND R4, R4, #0       ; If the bit is 1, then shift to this instruction and clear Register 4
ADD R4, R0, #0
NOT R4, R4
ADD R4, R4, #1
NOT R4, R4
RETURN ADD R0, R2, R4        ; Store the encrypted value to R0 by adding R2 (the encrption key) and the R4 (the encrypted user-input character)
OUT

STRSTOR .BLKW #21
ENCRYPTSTRSTOR .BLKW #21
ENCINP .STRINGZ "Encryption Key (1-9): "; The input message for encryption
TRAP x25
.END
