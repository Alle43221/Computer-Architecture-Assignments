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
    a DB 3
    b DW 10
    c DD 6
    d DQ 5
    ;(a+b)-(a+d)+(c-a)=(3+10)-(3+5)+(6-3)=13-8+3=16-8=8

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        MOV AH, 0
        MOV AL, [a]
        ADD [b], AX  ; b=a+b 3+10=13
        
        MOV EAX, 0
        MOV AL, [a]
        SUB [c], EAX ; c=c-a 6-3=3
        
        MOV EBX, 0
        MOV BX, [b]
        ADD EBX, [c] ; 3+13=16
        push EBX
        
        MOV EDX, 0
        MOV EBX, dword[d]
        MOV ECX, dword[d+4]
        
        CLC
        ADD EAX, EBX
        ADC EDX, ECX  ; EDX:EAX = d+a  3+5=8
        
        POP EBX
        MOV ECX, 0
        
        CLC 
        SUB EBX, EAX
        SBB ECX, EDX
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
