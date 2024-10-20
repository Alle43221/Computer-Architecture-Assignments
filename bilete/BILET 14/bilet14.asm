bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fread, printf, fopen, fclose
import fread msvcrt.dll      
import exit msvcrt.dll   
import printf msvcrt.dll 
import fopen msvcrt.dll   
import fclose msvcrt.dll           

; our data is declared here (the variables needed by our program)
segment data use32 class=data

    nume_fisier db "prufung.txt", 0
    mod_acces db "r", 0
    descriptor_fisier dd 0
    format_scriere db "%s", 10, 0
    cate dd 0
    
    sir times 200 db 0

; our code starts here
segment code use32 class=code
    start:
        ;deschiderea fisierului
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        mov [descriptor_fisier], eax ; salvam descriptorul
        
        mov esi, sir
        bucla:
            push dword [descriptor_fisier]
            push dword 1
            push dword 1
            push esi
            call [fread]
            add esp, 4*4
            
            cmp eax, 0
            je final
            
            cmp byte[esi], ' '
            je mai_jos
            
            cmp byte[esi], '.'
            je mai_jos
            
            inc esi
            jmp bucla
            
            mai_jos:
            mov ebx, esi
            sub ebx, sir
            mov [cate], ebx
            and ebx, 01
            mov byte[esi], 0
            mov esi, sir
            je bucla
            
            mov edx, 0
            mov eax, [cate]
            mov ebx, 2
            div ebx
            mov ebx, sir
            add ebx, eax
            mov byte[ebx], ' '
            
            push sir
            push format_scriere
            call [printf]
            add esp, 4*2
            
        jmp bucla
            
        final:
        
        push dword[descriptor_fisier] ; inchidere fisier
        call [fclose]
        add esp, 4
        
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
        
