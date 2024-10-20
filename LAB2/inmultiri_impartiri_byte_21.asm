bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a DB 7
    b DB 5
    c DB 1
    d DB 28

; our code starts here
segment code use32 class=code
    start:
        MOV AL, [a]  ;AL=a 
        ADD AL, [b]  ;AL=AL+b  7+5=12
        ADD AL, 2    ;AL=AL+2  12+2=14
        MOV byte[a], 3; a=3
        MUL byte[a]  ; AX=AL*a  14*3=42
        MOV BX, AX   ;BX=AX
        
        ADD byte[c], 2  ; c=c+2  1+2=3
        MOV AL, [c]     ; AL=c
        MOV byte[c], 5  ; c=5 
        MUL byte[c]     ; AX=AL*c  5*3=15
        
        SUB BX, AX      ; BX=BX-AX  42-15=27
        MOV AX, [d]       ; AX=d
        SUB AX, BX      ; AX=AX-BX  28-27=1
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
