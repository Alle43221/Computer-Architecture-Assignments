bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fprintf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll   
import fopen msvcrt.dll    
import fclose msvcrt.dll    
import fprintf msvcrt.dll    

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    mod_afisare db "%x", 10, 0
    nume_fisier db "output.txt", 0
    mod_acces db "w", 0
    descriptor_fisier dd 0
    
    valoare dw 0BCAFh

; our code starts here
segment code use32 class=code
    start:
        
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        mov [descriptor_fisier], eax
        mov esi, valoare
        mov edx, 0
        ;add esi, 1
        
        
        cld
        ;std
        mov ecx, 2
        jecxz sfarsit_bucla
        bucla:
            lodsb
            mov bl, al
            shr al, 4
            
            push ecx
            
            mov dl, al
            push edx
            push mod_afisare
            push dword[descriptor_fisier]
            call [fprintf]
            add esp, 4*3
            
            mov al, bl
            shl al, 4
            shr al, 4
            mov dl, al
            push edx
            push mod_afisare
            push dword[descriptor_fisier]
            call [fprintf]
            add esp, 4*3
            pop ecx
            
            loop bucla
        sfarsit_bucla:
        
        push dword[descriptor_fisier]
        call [fclose]
        add esp, 4
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
