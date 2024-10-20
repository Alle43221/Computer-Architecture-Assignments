bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    input DB "abcd"
    len equ $-input
    src DB "atcr"
    dst DB "ztyr"
    output times len DB 0
    ;Se da un sir de octeti 'input' si inca doua siruri de dimensiune N fiecare, 'src' si 'dst'. Sa se obtina un nou sir 'output' din sirul 'input' in care se vor inlocui toti octetii cu valoarea src[i] cu dst[i], unde i=1..N.
    

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ebx, 0
        mov ecx, len ;contor loop
        mov esi, input
        mov edi, output
        mov edx, dst
        
        CLD
        repeta:
        
        LODSB
        cmp al, [src+ebx]
        JE egalitate
        
        dec esi
        MOVSB
        inc edx
        JMP final
        
        egalitate:
        push esi
        mov esi, edx
        MOVSB
        mov edx, esi
        pop esi
        
        final:
        inc ebx
        
        loop repeta
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
