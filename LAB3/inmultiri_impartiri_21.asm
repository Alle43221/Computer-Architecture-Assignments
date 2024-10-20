bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; (a*a/b+b*b)/(2+b)+e-x
    ; a-byte; b-word; e-doubleword; x-qword
    a DB 4
    b DW 2
    e DD 10
    x DQ 7

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        MOV AL, [a]
        MUL byte[a] ; AX=a*a=4*4=16
        MOV DX, 0
        
        DIV word[b] ; AL=a*a/b=16/2=8 ;
        MOV EBX, 0
        MOV BL, AL
        
        MOV EAX, 0
        MOV AX, [b]
        MUL word[b] ; DX:AX=b*b=2*2=4
        
        push DX
        push AX
        pop EAX
        
        ADD EAX, EBX ;EAX=a*a/b+b*b=8+4=12
        push EAX
        pop AX
        pop DX
        
        MOV BX, [b]
        ADD BX, 2    ;BX=2+b=2+2=4
        
        DIV BX ; AX=(a*a/b+b*b)/(2+b)=12/4=3  ; 
        
        MOV EBX, 0
        MOV BX, AX
        ADD EBX, [e] ; EBX=(a*a/b+b*b)/(2+b)+e=3+10=13 ;
        
        MOV ECX, 0
        MOV EAX, dword[x]
        MOV EDX, dword[x+4]
        
        SUB EBX, EAX
        SBB ECX, EDX ; ECX:EBX=(a*a/b+b*b)/(2+b)+e-x=13-7=6
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
