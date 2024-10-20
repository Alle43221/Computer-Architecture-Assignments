bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; x+a/b + c*d - b/c +e; 
    ;    DL  stiva  AL
    ;a,b,d-byte; c-word; e-doubleword; x-qword
    a DB 4
    b DB 2
    c DW 1
    d DB 3
    e DD 7
    x DQ 10

; our code starts here
segment code use32 class=code
    start:
        MOV AH, 0
        MOV AL, [a]
        DIV byte[b] ;AL=a/b=4/2=2
        MOV BL, AL;
        MOV EAX, 0
        MOV AL, BL
        MOV EDX, 0
        
        MOV EBX, dword[x]
        MOV ECX, dword[x+4]
        
        ADD EBX, EAX
        ADC ECX, EDX ; ECX:EBX=x+a/b = 10+2=12
        
        MOV AL, [d]
        MUL word[c]; DX:AX=c*d=1*3=3
        push DX
        push AX
        pop EAX
        
        MOV EDX, 0
        ADD EBX, EAX
        ADC ECX, EDX ; ECX:EBX=x+a/b+c*d=12+3=15
        
        MOV EAX, 0
        MOV AL, [b]
        DIV word[c]; AX=b/c=2/1=2
        MOV DX, AX;
        MOV EAX, 0
        MOV AX, DX
        MOV EDX, 0
        
        SUB EBX, EAX
        SBB ECX, EDX ;ECX:EBX=x+a/b+c*d-b/c=15-2=13
        
        MOV EAX, [e]
        ADD EBX, EAX
        ADC ECX, EDX ;ECX:EBX=x+a/b + c*d - b/c +e=13+7=20
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
