bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; (c-a) + (b - d) +d
    
    a DB 3
    b DW 10
    c DD 7
    d DQ 5
    

; our code starts here
segment code use32 class=code
    start:
        MOV EAX, 0
        MOV AL, [a]
        SUB [c], EAX ; 7-3=4
        
        MOV EDX, 0
        MOV AX, [b]
        MOV EBX, dword[d]
        MOV ECX, dword[d+4]
        
        CLC
        SUB EAX, EBX
        SBB EDX, ECX ;10-5=5
        
        CLC
        MOV EBX, [c]
        MOV ECX, 0
        ADD EAX, EBX
        ADC EDX, ECX ; 4+5=9
        
        CLC
        MOV EBX, dword[d]
        MOV ECX, dword[d+4]
        ADD EAX, EBX
        ADC EDX, ECX ; 9+5=14
       
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
