bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    b DB         10111100b ;           1011.1100 (3-> 0) = 1100
    a DW 1110100100101011b ; 1110.1001.0010.1011 (11->8) = 1001

; our code starts here
segment code use32 class=code
    start:
        AND byte[b], 11110000b ; 1011.0000
        MOV AX, [a];
        SHL AX, 4     ;1001.0010.1011.0000
        SHR AX, 12;    0000.0000.0000.1001
        OR [b], AL ;             1011.1001
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
