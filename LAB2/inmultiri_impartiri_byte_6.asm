bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a DB 2
    b DB 3
    c DB 1
    d DB 4

; our code starts here
segment code use32 class=code
    start:
        MOV AL, [a]
        ADD AL, [b] ; AL=a+b  2+3=5
        MOV byte[a], 2  
        MUL byte[a]     ; AX=2*AL 2*5=10
        MOV BX, AX  ; mutam rezultatul din AX in BX
        MOV AL, 5
        MUL byte[c]     ; AX=5*c  5*1=5
        
        SUB BX, AX  ; BX=BX-AX  10-5=5
        SUB byte[d], 3 ; d=d-3 4-3=1
        MOV EAX, 0
        MOV AL, [d]
        MUL BX     ; DX:AX=AX*BX  1*5=5
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
