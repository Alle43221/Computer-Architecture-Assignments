bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; Se dau cuvintele A si B. Se cere dublucuvantul C:
    ; x bitii 0-5 ai lui C coincid cu bitii 3-8 ai lui A
    ; x bitii 6-8 ai lui C coincid cu bitii 2-4 ai lui B
    ; x bitii 9-15 ai lui C reprezinta bitii 6-12 ai lui A
    ; bitii 16-31 ai lui C sunt 0
     a dw 1010001101111101b; 1010 0011 0111 1101
     b dw 0100100111011010b; 0100 1001 1101 1010
     c dd 0

; our code starts here
segment code use32 class=code
    start:
        MOV AX, [a] ; A37D 1010 0011 0111 1101
        SHL AX, 7   ;      1011 1110 1000 0000
        SHR AX, 10  ;      0000 0000 0010 1111
        OR [c], AX  ;    c=0000 0000 0010 1111
        
        MOV AX, [b] ;      0100 1001 1101 1010
        SHR AX, 2   ;      0001 0010 0111 0110
        SHL AX, 12  ;      0110 0000 0000 0000
        SHR AX, 6   ;      0000 0001 1000 0000
        OR [c], AX  ;    c=0000 0001 1010 1111
        
        MOV AX, [a] ;      1010 0011 0111 1101
        SHR AX, 6   ;      0000 0010 1000 1101
        SHL AX, 9   ;      0001 1010 0000 0000
        OR [c], AX  ;    c=0001 1011 1010 1111
        MOV EAX, [c]
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
