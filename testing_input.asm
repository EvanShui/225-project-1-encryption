.ORIG x3000                  ; Start at address x3000
LEA R0, ENCINP               ; Load the encryption input message into R0
PUTS                         ; Writes the message to output as a prompt for user to input an encryption key
GETC                         ; Reads one character (the encryption value) from input (without echo) and loads into R0
OUT                          ; Writes one character to output (from R0)
ADD R0, R0, #-16
ADD R0, R0, #-16
ADD R0, R0, #-16
ADD R4,R0,#0                 ; Copies R0 (user input) value into R4.
HALT                         ; HALT
ENCINP .STRINGZ "Encryption Key (1-9): "; The input message for encryption
.END                         ; End of program
