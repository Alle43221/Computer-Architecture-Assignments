bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; c-(d+a)+(b+c)
    ;a - byte, b - word, c - double word, d - qword - Interpretare cu semn
    a DB -3
    b DW 5
    c DD -7
    d DQ 10

; our code starts here
segment code use32 class=code
    start:
        MOV AL, [a]
        CBW
        CWDE
        CDQ
        
        MOV EBX, dword[d]
        MOV ECX, dword[d+4]
        
        CLC
        ADD EBX, EAX
        ADC ECX, EDX  ; ECX:EBX = d+a = -3 + 10 = 7
        
        MOV EAX, [c]
        CDQ
        
        CLC
        SUB EAX, EBX
        SBB EDX, ECX  ; EDX:EAX = c-(d+a) = -7-7 = -14
        
        MOV EBX, EAX
        MOV ECX, EDX
        
        MOV AX, [b]
        CWDE
        ADD EAX, [c] ; EAX = b+c = 5-7 =-2
        
        
        CLC
	cDQ
        ADD EAX, EBX
        ADC EDX, ECX  ;EDX:EAX = c-(d+a)+(b+c) = -14 - 2 = -16
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
