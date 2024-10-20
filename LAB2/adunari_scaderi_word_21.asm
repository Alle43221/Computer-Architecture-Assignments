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
    a DW 11
    b DW 8
    c DW 9
    d DW 10

; our code starts here
segment code use32 class=code
    start:
        ; ...
    
        MOV AX, [a]
        SUB AX, [c] ; AX=a-c     11-9=2
        ADD AX, [d] ; AX=AX+d    2+10=12
        SUB AX, 7   ; AX=AX-7    12-7=5
        ADD AX, [b] ; AX=AX+b    5+8=13
        
        ADD byte[d], 2  ; d=d+2        10+2=12
        SUB AX, [d] ; AX=AX-(2+d)  13-12=1
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
