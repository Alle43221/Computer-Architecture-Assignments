bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a DB 5
    b DB 3
    c DB 7
    d DB 2

; our code starts here
segment code use32 class=code
    start:
        MOV AL, [a]
        
        SUB [c], AL ; 7-5=2  c=c-a
        
        ADD AL, [d] ; 5+2=7  AL=a+d
        
        MOV BL, [a]
        ADD BL, [b] ; 5+3=8  BL=a+b
        
        SUB BL, AL  ; 8-7=1  BL=(a+b)-(a+d)
        ADD BL, [c] ; 1+2=3  BL=(a+b)-(a+d)+(c-a)
 
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
