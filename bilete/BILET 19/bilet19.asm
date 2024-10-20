bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fprintf, fopen, fclose, scanf, fread   
import exit msvcrt.dll   
import fprintf msvcrt.dll 
import fopen msvcrt.dll   
import fclose msvcrt.dll      
import scanf msvcrt.dll     
import fread msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    format db "%s", 10, 0
    format_citire db "%c", 0
    format_citire1 db "%d", 0
    
    nume_fisier db "output.txt", 0
    mod_acces db "w", 0
    descriptor_fisier dd 0
    vocale db 'aeiouAEIOU', 0
    sir times 100 db 0 
    numar dd 0

; our code starts here
segment code use32 class=code
    start:
        push numar
        push format_citire1
        call [scanf]
        add esp, 4*2
        push sir
        push format_citire
        call [scanf]
        add esp, 4*2
        
        ;deschiderea fisierului
        push dword mod_acces
        push dword nume_fisier   ; deschidere output.txt cu mod acces r
        call [fopen]
        add esp, 4*2
        
        mov [descriptor_fisier], eax ; salvam descriptorul 
        
        mov edi, 0
        mov esi, sir
        bucla:
            push esi
            push format_citire
            call [scanf]
            add esp, 4*2
            
            cmp byte[esi], '#'
            je final
            
            cmp byte[esi], 10
            jne final_bucla
            
            mov byte[esi], 0
            mov ebx, edi
            mov edi, 0
            mov eax, esi
            mov esi, sir
            cmp ebx, [numar]
            jb bucla
            mov bl, [eax-1]
            cmp bl, [sir]
            jne bucla
            
            push sir
            push format
            push dword[descriptor_fisier]
            call [fprintf]
            add esp, 4*3
            jmp bucla
            
            final_bucla:
            mov ecx, 10
            buclita:
                mov bl, [vocale+ecx-1]
                cmp bl, [esi]
                jne mai_jos
                inc edi
                mai_jos:
                
            loop buclita
            
            inc esi
            
        jmp bucla
        
        final:
        
        push dword[descriptor_fisier] ; inchidere fisier
        call [fclose]
        add esp, 4
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
        
