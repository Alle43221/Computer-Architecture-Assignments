bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ;d-a+(b+a-c)
    ;a - byte, b - word, c - double word, d - qword
    a DB -3
    b DW 6
    c DD 10
    d DQ -14

; our code starts here
segment code use32 class=code
    start:
        MOV EBX, dword[d]
        MOV ECX, dword[d+4]
        
        MOV Al, [a]
        CBW
        CWDE
        CDQ
        
        SUB EBX, EAX
        SBB ECX, EDX ; d-a=-14-(-3)=-11 retinuta in ECX:EBX
        
        ADD AX, [b] ; a=b+a=6-3=3
        
        CWDE
        SUB EAX, [c] ; EAX=a+b-c=3-10=-7
        
        CDQ
        ADD EAX, EBX
        ADC EDX, ECX ;d-a+(b+a-c)=-11+(-7)=-18
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
