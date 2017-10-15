.ORIG x3000                  ; Start at address x3000
LEA R7, ENCRYPTSTRSTOR       ; load the beginning of the encrypted string memory storage into R7
LEA R1, STRSTOR              ; load the beginning of the user inputted string memory storage into R6 (R6 will hold the value of the first character from the user)
AND R0, R0, b0000            ; clear R0
ADD R2, R0, #6               ; sets R2 to have the value 6 (actually R2 will be the register that holds the value of the encryption key)

LOOP LDR R3, R0, #0          ; loads the data from address specified in R6 sets it into R3
AND R4, R3, b11110           ; sets R4 to bit-wise AND between R3 and 11110 (to set the last bit to 0)
ADD R5, R4, #0               ; copies the value of R4 to R5
NOT R4, R4                   ; not R4
ADD R4, R4, R3               ; Adding R4 and R3 which, if they are equal, should be -1
ADD R4, R4, #1               ; If after bit-wise and operation is performed, and the values are equal (which means that the least-significant bit is 0), then R4 should be equal to 0
                             ; However, if they are not equal (which means that the least-significant bit is 1), then R4 should not be equal to 0
BRnp SIGBIT1                 ; Conditional statement, if it's not zero, then least-significant bit is 1, then have to change to 0.
SIGBIT0 ADD R4, R4, #1       ; If the value loaded into R4 is 0, then it means the values are equal
JMP ENDFUNC                  ; Jump to the ENDFUNC
SIGBIT1 AND R4, R4, #0       ; If the bit is 1, then shift to this instruction and clear Register 4
ADD R4, R5, #0               ; Add Registers 5 (which is the encrypted value while removing the least significant bit with b11110)
ADD R4, R4, #1               ; Adds 1 to Register 4
NOT R4, R4                   ; Not R4 again to get the least significant bit toggled.
ENDFUNC ADD R0, R2, R4       ; Store the encrypted value to R0 by adding R2 (the encrption key) and the R4 (the encrypted user-input character)
STR R0, R7, #0               ; Store the encrypted value into memory beginning specified by ENCRYPTSTRSTOR
ADD R7, R7, #1               ; Increment the address
ADD R0, R0, #1               ; Increment the address
ADD R6, R6, #-1              ; decrement character counter
BRzp LOOP                    ; loops to the instruction that will load the data from memory into R3 (specifically the user data)
                             ; put the address of the
STRSTOR .BLKW #21
ENCRYPTSTRSTOR .BLKW #21


ask if the null character at the end of the file should be included when printing out the data from memory at the end.
