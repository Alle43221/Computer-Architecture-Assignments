bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    sir DB 2, 4, 2, 5, 2, 2, 4, 4 
    len equ $-sir
    
    rez times len DW 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ecx, len ;contor loop
        mov esi, sir
        mov edi, rez
        mov ebx, 0
        
        cld
        JECXZ final
        repeta:
            lodsb
            push ecx
            mov ecx, ebx
            mov edi, rez
            
            JECXZ final_loop
            repeta1:
               mov dx, [edi]
               cmp dl, al
               je incrementare
               ADD edi, 2
            loop repeta1
       
            final_loop:
            mov edi, rez
            mov word[edi+ebx*2], 0100h
            mov [edi+ebx*2], al
            inc ebx
            jmp final
            
            incrementare:
                add word[edi], 0100h
                
            final:
                pop ecx
            
        loop repeta
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
