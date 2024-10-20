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
    a DB -4
    b DB 2
    c DW -1
    d DB 3
    e DD 7
    x DQ -10

; our code starts here
segment code use32 class=code
    start:
        MOV AL, [a]
        CBW
        IDIV byte[b] ;AL=a/b=-4/2=-2
	CBW
        CWDE
        CDQ
        
        MOV EBX, dword[x]
        MOV ECX, dword[x+4]
        
        ADD EBX, EAX
        ADC ECX, EDX ; ECX:EBX=x+a/b = -10+(-2)=-12 
        
        MOV AL, [d]
	CBW
        IMUL word[c]; DX:AX=c*d=-1*3=-3 
        push DX
        push AX
        pop EAX
        
        CDQ
        ADD EBX, EAX
        ADC ECX, EDX ; ECX:EBX=x+a/b+c*d=-12+(-3)=-15
        
        
        MOV AL, [b]
        CBW
        CWD
        IDIV word[c]; AX=b/c=2/-1=-2 
        CWDE
        CDQ
        
        SUB EBX, EAX
        SBB ECX, EDX ;ECX:EBX=x+a/b+c*d-b/c=-15-(-2)=-13
        
        MOV EAX, [e]
        CDQ
        ADD EBX, EAX
        ADC ECX, EDX ;ECX:EBX=x+a/b + c*d - b/c +e=-13+7=-6
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
