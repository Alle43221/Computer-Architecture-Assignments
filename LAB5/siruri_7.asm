bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s1 db "1357"
    len1 equ $-s1
    s2 db "2694"
    len equ $-s1
    d times len db 0

; our code starts here
segment code use32 class=code
    start:
        mov ecx, len1
        
        mov esi, 0
        mov edi, 0
        
        jecxz final
        repeta:
            mov al, [s1+esi]
            mov [d+edi], al
            inc edi
            
            mov al, [s2+esi]
            mov [d+edi], al
            
            inc esi
            inc edi
        loop repeta
        
        final:
        ; exit(0)
            push    dword 0      ; push the parameter for exit onto the stack
            call    [exit]       ; call exit to terminate the program
