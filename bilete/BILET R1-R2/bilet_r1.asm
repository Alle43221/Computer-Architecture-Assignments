bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fread, fclose, fopen, printf              
import exit msvcrt.dll    
import fread msvcrt.dll
import fclose msvcrt.dll
import fopen msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    denumire_fisier db "r1.txt", 0
    descriptor_fisier dd 0
    mod_acces db "r", 0
    text times 100 db 0
    format_afisare db "%s", 0

; our code starts here
segment code use32 class=code
    start:
        push dword mod_acces
        push dword denumire_fisier
        call [fopen]
        add esp, 4*2
        
        mov [descriptor_fisier], eax
        
        bucla:
            push dword[descriptor_fisier]
            push dword 100
            push dword 1
            push dword text
            call [fread]
            add esp, 4*4
            
            cmp eax, 0
            je final
            
            mov ecx, eax
            mov esi, text
            cld
            repeta:
                lodsb
                cmp al, 41h ; A
                jb final1
                cmp al, 7ah ; z
                ja final1
                cmp al, 61h ; a
                jae mai_jos
                cmp al, 5Ah ; Z
                jbe mai_jos
                
                jmp final1
                
                mai_jos:
                sub al, 2
                cmp al, 'A'
                jae mai_jos_1
                add al, 26
                jmp final1
                
                mai_jos_1:
                cmp al, 'a'
                jae final1
                cmp al, 'Z'
                jbe final1
                add al, 26
                
                final1:
                mov [esi-1], al
            loop repeta
            
            push dword text
            push dword format_afisare
            call [printf]
            add esp, 4*2
        
        jmp bucla
        
        final:
        push dword [descriptor_fisier]
        call [fclose]
        add esp, 4
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
