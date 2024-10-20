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
    a DW 6
    b DW 2
    c DW 17
    d DW 4
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        MOV AX, [a]
        ADD [d], AX ; d=d+a  4+6=10
        
        MOV AX, [c]
        ADD AX, [b] ; AX=c+b 17+2=19
        
        ADD AX, [d] ; AX=(d+a)+(c+b)     19+10=29
        ADD AX, [c] ; AX=(d+a)+(c+b)+c   29+17=46
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
